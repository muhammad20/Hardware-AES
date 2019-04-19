
module MixColumns(prevState, nextState);
input  [127:0]prevState ;
output [127:0] nextState ;
wire [7:0] s [3:0][3:0];
wire [7:0] sNew [3:0][3:0];
wire [3:0] temp [20:0];

// Construct the 2D state array
assign s[0][0] = prevState[7:0];
assign s[0][1] = prevState[15:8];
assign s[0][2] = prevState[23:16];
assign s[0][3] = prevState[31:24];
assign s[1][0] = prevState[39:32];
assign s[1][1] = prevState[47:40];
assign s[1][2] = prevState[55:48];
assign s[1][3] = prevState[63:56];
assign s[2][0] = prevState[71:64];
assign s[2][1] = prevState[79:72];
assign s[2][2] = prevState[87:80];
assign s[2][3] = prevState[95:88];
assign s[3][0] = prevState[103:96];
assign s[3][1] = prevState[111:104];
assign s[3][2] = prevState[119:112];
assign s[3][3] = prevState[127:120];
/*
byteMul(temp[0], s[0][0],1'd2);
byteMul(temp[1], s[1][0],1'd3);
xor( sNew[0][0], temp[0], temp[1], s[2][0], s[3][0] );

 byteMul(temp[2], s[1][0],1'd2);
 byteMul(temp[3], s[2][0],1'd3);
xor( sNew[1][0], temp[2], temp[3], s[0][0], s[3][0] );

 byteMul(temp[4], s[0][0],1'd2);
 byteMul(temp[5], s[1][0],1'd3);
xor( s[2][0], temp[4], temp[5], s[0][0], s[1][0] );

 byteMul(temp[6], s[3][0],1'd2);
 byteMul(temp[7], s[0][0],1'd3);
xor( s[3][0], temp[6], temp[7], s[2][0], s[1][0] );
*/


endmodule