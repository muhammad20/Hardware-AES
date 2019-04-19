
module xtime(in,out);
input [7:0] in;
output [7:0] out;
wire [7:0] temp;
reg[7:0] out;

eightbitxor t (temp, {in[6:0],1'b0}, 8'b00011011); 

always@(in)
begin
	if(in[7]==0) 
		out = {in[6:0],1'b0};
	else
		out = temp;
end
endmodule