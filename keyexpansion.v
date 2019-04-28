	/// key is the algorithm key either 128, 192 or 256 bits
/// Nk: a number that determines the key length (number of 32-bit words in key)
/// Nr: number of rounds
module keyexpansion(key, w, Nk, clk, rst, done, err);

input [3 : 0] Nk;
input clk,rst;
input [8 * 8 * 4 - 1 : 0] key;
output [32 * 4 * (14 + 1) - 1 : 0] w;
output done, err;
wire [31 : 0] w_array_fixed [0 : 7];
reg [31 : 0] w_array [0 : 4 * (14 + 1) - 1];
wire [31 : 0] temp_w [0 : 4 * (14 + 1) - 1];
wire [31 : 0] Rcon [0 : 10 - 1];

assign Rcon[0] = 32'h01000000;
assign Rcon[1] = 32'h02000000;
assign Rcon[2] = 32'h04000000;
assign Rcon[3] = 32'h08000000;
assign Rcon[4] = 32'h10000000;
assign Rcon[5] = 32'h20000000;
assign Rcon[6] = 32'h40000000;
assign Rcon[7] = 32'h80000000;
assign Rcon[8] = 32'h1b000000; // computed by shifting left and taking the mod.
assign Rcon[9] = 32'h36000000; // computed by shifting left and taking the mod.

wire [31:0] zero_reg;
assign zero_reg = 32'h0;

wire [1:0] mux4x1_sel;
assign mux4x1_sel = {Nk[3], Nk[1]};
mux2x1 m7(zero_reg, key[31:0], Nk[3], w_array_fixed[7]);
mux2x1 m6(zero_reg, key[63:32], Nk[3], w_array_fixed[6]);
mux4x1 m5(zero_reg, key[31:0], key[95:64], zero_reg, mux4x1_sel, w_array_fixed[5]);
mux4x1 m4(zero_reg, key[63:32], key[127:96], zero_reg, mux4x1_sel, w_array_fixed[4]);
mux4x1 m3(key[31:0], key[95:64], key[159:128], zero_reg, mux4x1_sel, w_array_fixed[3]);
mux4x1 m2(key[63:32], key[127:96], key[191:160], zero_reg, mux4x1_sel, w_array_fixed[2]);
mux4x1 m1(key[95:64], key[159:128], key[223:192], zero_reg, mux4x1_sel, w_array_fixed[1]);
mux4x1 m0(key[127:96], key[191:160], key[255:224], zero_reg, mux4x1_sel, w_array_fixed[0]);


reg [31:0] temp_op;
reg [5:0] counter;

wire [31:0] temp_fixed, temp_rot_fixed, temp_sub_fixed, xor_fixed;
wire en_wire;
assign en_wire = 1'b0;
reg en;
reg [31:0] Rconi;
reg [31:0] w_temp;
reg done, err;
wire [31:0] w_normal, w_8, w_mod;


RotWord rot(temp_op, temp_rot_fixed);
SubWord sub(temp_rot_fixed, temp_sub_fixed);
xor32 myXor(temp_sub_fixed, Rconi, xor_fixed);
xor32 myXor2(xor_fixed, w_temp, w_mod);
xor32 myXor3(w_temp, temp_op, w_normal);
SubWord sub2(temp_op, temp_fixed);
xor32 myXor4(temp_fixed, w_temp, w_8);

always @(Nk)
    begin
        if (Nk != 4 && Nk != 6 && Nk != 8)
            err = 1'b1;
        else
            err = 1'b0;
    end


always @(posedge clk, rst, err)
    begin
        if(rst)
	begin
        counter = 5'b0;
	    en = en_wire;
	end
	else if(!err)
	begin
        if(counter == Nk)
	    begin
        if (Nk < 8)
        begin
            w_array[59] <= zero_reg;
            w_array[58] <= zero_reg;
            w_array[57] <= zero_reg;
            w_array[56] <= zero_reg;
            w_array[55] <= zero_reg;
            w_array[54] <= zero_reg;
            w_array[53] <= zero_reg;
            w_array[52] <= zero_reg;
        end
		if(Nk == 4)
		begin
	    w_array[51] <= zero_reg;
            w_array[50] <= zero_reg;
            w_array[49] <= zero_reg;
            w_array[48] <= zero_reg;
            w_array[47] <= zero_reg;
            w_array[46] <= zero_reg;
            w_array[45] <= zero_reg;
            w_array[44] <= zero_reg;        
		end
	        done = 1'b0;
            	en = 1'b1;
	    end
        else if(counter == 1)
        begin
            w_array[0] <= w_array_fixed[0];
            w_array[1] <= w_array_fixed[1];
            w_array[2] <= w_array_fixed[2];
            w_array[3] <= w_array_fixed[3];
            w_array[4] <= w_array_fixed[4];
            w_array[5] <= w_array_fixed[5];
            w_array[6] <= w_array_fixed[6];
            w_array[7] <= w_array_fixed[7];
            counter <= counter + 5'b1;
	end
	else if (!en)
	    counter <= counter + 5'b1;
    end
    end
    

always @(posedge clk, en, done, err)
    begin
        if(!err)
            if(en && !done && !err)
                begin
                    temp_op = w_array[counter - 1];
                    if(counter % Nk == 0)
                        Rconi = Rcon[counter / Nk - 1];
                counter = counter + 1'b1;
                w_temp = w_array[counter - Nk - 1];
        end
    end

always @(negedge clk, en)
	begin
	if(en && !done && !err)
begin
	if((counter - 1) % Nk == 0)
		w_array[counter - 1] = w_mod;
	else if (Nk > 6 && (counter - 1) % Nk == 4)
		w_array[counter - 1] = w_8;
	else
            w_array[counter - 1] = w_normal;
            if (counter == 4 * (Nk + 6 + 1))
                done = 1'b1;
end
	end

genvar k;
for (k = 0; k < 60; k = k + 1)
    assign w[32*k + 31: 32*k] = w_array[k];

endmodule


