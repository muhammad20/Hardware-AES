module mux2x1(data1, data2, sel, data_out);

input [31:0] data1, data2;
input sel;
output [31:0] data_out;

reg [31:0] data_out;

always @(data1, data2, sel)
begin
	if(sel == 0)
		data_out <= data1;
	else
		data_out <= data2;
	end
endmodule


