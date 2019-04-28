module xor32(data1, data2, out);

input [31:0] data1, data2;
output [31:0] out;
reg [31:0] out;

always @(data1, data2)
	out = data1 ^ data2;

endmodule
