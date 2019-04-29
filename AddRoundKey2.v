
module AddRoundKey2(prevState, nextState,w,round);

input  [127:0]prevState ;
input [32 * 4 * (14 + 1) - 1 : 0] w;
input [3:0]round;
wire [31:0] wo [0:59];
output [127:0] nextState ;

genvar j;
generate 
for ( j=0; j<60; j = j+1) begin
	assign wo [j] = w[(j+1)*32-1 : j*32];
end
endgenerate

genvar i;
generate 
for ( i=0; i<16; i = i+4) begin
	eightbitxor mx (nextState[8*(i+1)-1 : i*8], prevState[8*(i+1)-1 : i*8], wo[(round+1)*4-i/4-1][7:0]);
	eightbitxor mx2 (nextState[8*(i+2)-1 : 8*(i+1)], prevState[8*(i+2)-1 : 8*(i+1)], wo[(round+1)*4-i/4-1][15:8]);
	eightbitxor mx3 (nextState[8*(i+3)-1 : 8*(i+2)], prevState[8*(i+3)-1 : 8*(i+2)], wo[(round+1)*4-i/4-1][23:16]);
	eightbitxor mx4 (nextState[8*(i+4)-1 : 8*(i+3)], prevState[8*(i+4)-1 : 8*(i+3)], wo[(round+1)*4-i/4-1][31:24]);
	
end
endgenerate

endmodule