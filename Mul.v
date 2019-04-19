module Mul(out,a,b);
input [7:0] a;
input [7:0] b;
output [7:0] out;

reg [7:0] temp0;
reg [7:0] temp1;
reg [7:0] temp2;
reg [7:0] temp3;
reg [7:0] temp4;
reg [7:0] temp5;
reg [7:0] temp6;
reg [7:0] temp7;

wire [7:0] temp_x01;
wire [7:0] temp_x02;
wire [7:0] temp_x04;
wire [7:0] temp_x08;
wire [7:0] temp_x10;
wire [7:0] temp_x20;
wire [7:0] temp_x40;
wire [7:0] temp_x80;

wire [7:0] temp_x0;
wire [7:0] temp_x1;
wire [7:0] temp_x2;
wire [7:0] temp_x3;
wire [7:0] temp_x4;
wire [7:0] temp_x5;



assign temp_x01 = a;
xtime x02 (a,      temp_x02);
xtime x04 (temp_x02, temp_x04);
xtime x08 (temp_x04, temp_x08);
xtime x10 (temp_x08, temp_x10);
xtime x20 (temp_x10, temp_x20);
xtime x40 (temp_x20, temp_x40);
xtime x80 (temp_x40, temp_x80);



always @(a or b or temp_x01 or temp_x02 or temp_x04 or temp_x08 or temp_x10 or temp_x20 or temp_x40 or temp_x80)
begin

if( b[0] == 1'b0 )
	temp0 = 8'b0;
else
	temp0 = temp_x01;

if( b[1] == 1'b0 )
	temp1 = 8'b0;
else
	temp1 = temp_x02;

if( b[2] == 1'b0 )
	temp2 = 8'b0;
else
	temp2 = temp_x04;

if( b[3] == 1'b0 )
	temp3 = 8'b0;
else
	temp3 = temp_x08;

if( b[4] == 1'b0 )
	temp4 = 8'b0;
else
	temp4 = temp_x10;

if( b[5] == 1'b0 )
	temp5 = 8'b0;
else
	temp5 = temp_x20;

if( b[6] == 1'b0 )
	temp6 = 8'b0;
else
	temp6 = temp_x40;

if( b[7] == 1'b0 )
	temp7 = 8'b0;
else
	temp7 = temp_x80;

end


eightbitxor x0 (temp_x0, temp0, temp1);
eightbitxor x1 (temp_x1, temp2, temp3);
eightbitxor x2 (temp_x2, temp4, temp5);
eightbitxor x3 (temp_x3, temp6, temp7);
eightbitxor x4 (temp_x4, temp_x0, temp_x1);
eightbitxor x5 (temp_x5, temp_x2, temp_x3);
eightbitxor x6 (out, temp_x4, temp_x5);


endmodule