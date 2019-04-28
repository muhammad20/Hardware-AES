

module InvMixColumns(prevState, nextState);
input  [127:0]prevState ;
output [127:0] nextState ;
wire [7:0] s [0:3][0:3];
wire [7:0] sNew[ 0:3][0:3];
wire [7:0] temp [0:3][0:23];

// Construct the 2D state array
assign s[3][3] = prevState[7:0];
assign s[2][3] = prevState[15:8];
assign s[1][3] = prevState[23:16];
assign s[0][3] = prevState[31:24];
assign s[3][2] = prevState[39:32];
assign s[2][2] = prevState[47:40];
assign s[1][2] = prevState[55:48];
assign s[0][2] = prevState[63:56];
assign s[3][1] = prevState[71:64];
assign s[2][1] = prevState[79:72];
assign s[1][1] = prevState[87:80];
assign s[0][1] = prevState[95:88];
assign s[3][0] = prevState[103:96];
assign s[2][0] = prevState[111:104];
assign s[1][0] = prevState[119:112];
assign s[0][0] = prevState[127:120];


/*
Mul m1 (temp1,s[0][0], 8'h2);
Mul m2 (temp2,s[1][0], 8'h3);
eightbitxor m3 (temp3, temp1, temp2);
eightbitxor m4 (temp4, s[2][0], s[3][0]); 
eightbitxor m5 (sNew[0][0], temp3, temp4); 

Mul m6 (temp5,s[1][0], 8'h2);
Mul m7 (temp6,s[2][0], 8'h3);
eightbitxor m8 (temp7, temp5, temp6);
eightbitxor m9 (temp8, s[0][0], s[3][0]); 
eightbitxor m10 (sNew[1][0], temp7, temp8);

Mul m11 (temp9,s[2][0], 8'h2);
Mul m12 (temp10,s[3][0], 8'h3);
eightbitxor m13 (temp11, temp10, temp9);
eightbitxor m14 (temp12, s[0][0], s[1][0]); 
eightbitxor m15 (sNew[2][0], temp11, temp12); 

Mul m16 (temp13,s[3][0], 8'h2);
Mul m17 (temp14,s[0][0], 8'h3);
eightbitxor m18 (temp15, temp13, temp14);
eightbitxor m19 (temp16, s[2][0], s[1][0]); 
eightbitxor m20 (sNew[3][0], temp16, temp15); 


/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

Mul m21 (temp17,s[0][1], 8'h2);
Mul m22 (temp18,s[1][1], 8'h3);
eightbitxor m23 (temp19, temp17, temp18);
eightbitxor m24 (temp20, s[2][1], s[3][1]); 
eightbitxor m25 (sNew[0][1], temp19, temp20); 

Mul m26 (temp21,s[1][1], 8'h2);
Mul m27 (temp22,s[2][1], 8'h3);
eightbitxor m28 (temp23, temp21, temp22);
eightbitxor m29 (temp24, s[0][1], s[3][1]); 
eightbitxor m30 (sNew[1][1], temp23, temp24);

Mul m31 (temp25,s[2][1], 8'h2);
Mul m32 (temp26,s[3][1], 8'h3);
eightbitxor m33 (temp27, temp25, temp26);
eightbitxor m34 (temp28, s[0][1], s[1][1]); 
eightbitxor m35 (sNew[2][1], temp27, temp28); 

Mul m36 (temp29,s[3][1], 8'h2);
Mul m37 (temp30,s[0][1], 8'h3);
eightbitxor m38 (temp31, temp29, temp30);
eightbitxor m39 (temp32, s[2][1], s[1][1]); 
eightbitxor m40 (sNew[3][1], temp31, temp32); */

genvar i;
generate 
for ( i=0; i<4; i = i+1) begin
	Mul mx1 (temp[i][0],s[0][i], 8'h0e);
	Mul mx2 (temp[i][1],s[1][i], 8'h0b);
	Mul mx3 (temp[i][2],s[2][i], 8'h0d);
	Mul mx4 (temp[i][3],s[3][i], 8'h09);
	eightbitxor mx5 (temp[i][4], temp[i][0], temp[i][1]);
	eightbitxor mx6 (temp[i][5], temp[i][2], temp[i][3]); 
	eightbitxor mx7 (sNew[0][i], temp[i][4], temp[i][5]);

	Mul mx8 (temp[i][6],s[0][i], 8'h09);
	Mul mx9 (temp[i][7],s[1][i], 8'h0e);
	Mul mx10 (temp[i][8],s[2][i], 8'h0b);
	Mul mx11 (temp[i][9],s[3][i], 8'h0d);
	eightbitxor mx12 (temp[i][10], temp[i][6], temp[i][7]);
	eightbitxor mx13 (temp[i][11], temp[i][8], temp[i][9]); 
	eightbitxor mx14 (sNew[1][i], temp[i][10], temp[i][11]); 


	Mul mx15 (temp[i][12],s[0][i], 8'h0d);
	Mul mx16 (temp[i][13],s[1][i], 8'h09);
	Mul mx17 (temp[i][14],s[2][i], 8'h0e);
	Mul mx18 (temp[i][15],s[3][i], 8'h0b);
	eightbitxor mx19 (temp[i][16], temp[i][12], temp[i][13]);
	eightbitxor mx20 (temp[i][17], temp[i][14], temp[i][15]); 
	eightbitxor mx21 (sNew[2][i], temp[i][16], temp[i][17]);

	Mul mx22 (temp[i][18],s[0][i], 8'h0b);
	Mul mx23 (temp[i][19],s[1][i], 8'h0d);
	Mul mx24 (temp[i][20],s[2][i], 8'h09);
	Mul mx25 (temp[i][21],s[3][i], 8'h0e);
	eightbitxor mx26 (temp[i][22], temp[i][18], temp[i][19]);
	eightbitxor mx27 (temp[i][23], temp[i][20], temp[i][21]); 
	eightbitxor mx28 (sNew[3][i], temp[i][22], temp[i][23]);  

	


end
endgenerate

assign  nextState[7:0] = sNew[3][3];
assign  nextState[15:8] = sNew[2][3];
assign  nextState[23:16] = sNew[1][3];
assign  nextState[31:24] = sNew[0][3];
assign  nextState[39:32] = sNew[3][2];
assign  nextState[47:40] = sNew[2][2];
assign  nextState[55:48] = sNew[1][2];
assign  nextState[63:56] = sNew[0][2];
assign  nextState[71:64] = sNew[3][1];
assign  nextState[79:72] = sNew[2][1];
assign  nextState[87:80] = sNew[1][1];
assign  nextState[95:88] = sNew[0][1];
assign  nextState[103:96] = sNew[3][0];
assign  nextState[111:104] = sNew[2][0];
assign  nextState[119:112] = sNew[1][0];
assign  nextState[127:120] = sNew[0][0];


endmodule