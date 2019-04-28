module mux4x1(data1, data2, data3, data4, sel, data_out);

input [31:0] data1, data2, data3, data4;
input [1:0] sel;
output [31:0] data_out;

reg [31:0] data_out;

always @(data1, data2, sel)
begin
	if(sel == 0)
		data_out = data1;
	else if (sel == 1)
        data_out = data2;
    else if (sel == 2)
        data_out = data3;
    else
		data_out = data4;
	end
endmodule
