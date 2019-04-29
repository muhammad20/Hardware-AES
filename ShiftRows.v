
module ShiftRows(prevState, nextState);
input  [127:0]prevState ;
output [127:0] nextState ;
wire [7:0] s [0:3][0:3];
wire [7:0] sNew[ 0:3][0:3];

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
	
assign sNew[0][0] = s[0][0];
assign sNew[0][1] = s[0][1];
assign sNew[0][2] = s[0][2];
assign sNew[0][3] = s[0][3];

assign sNew[1][0] = s[1][1];
assign sNew[1][1] = s[1][2];
assign sNew[1][2] = s[1][3];
assign sNew[1][3] = s[1][0];

assign sNew[2][0] = s[2][2];
assign sNew[2][1] = s[2][3];
assign sNew[2][2] = s[2][0];
assign sNew[2][3] = s[2][1];

assign sNew[3][0] = s[3][3];
assign sNew[3][1] = s[3][0];
assign sNew[3][2] = s[3][1];
assign sNew[3][3] = s[3][2];


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