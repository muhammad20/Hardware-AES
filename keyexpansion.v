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


wire [31:0] temp_op;
reg [5:0] counter;
wire [31:0] temp_fixed, temp_rot_fixed, temp_sub_fixed, xor_fixed;
wire [31:0] w_temp;
wire [31:0] w_normal, w_8, w_mod, w_out;
wire [2:0] count_mod_Nk;
wire iter_result_least_selector, iter_result_most_selector;
assign count_mod_Nk = counter % Nk;
assign iter_result_least_selector = ~(count_mod_Nk[0] | count_mod_Nk[1] | count_mod_Nk[2]);
assign iter_result_most_selector = Nk[3] & count_mod_Nk[2] & ~count_mod_Nk[1] & ~count_mod_Nk[0];
wire [1:0] iter_result_selector;
assign iter_result_selector = {iter_result_most_selector, iter_result_least_selector};

wire [31:0] Rconii;
assign Rconii = Rcon[counter/Nk - 1];

wire en;
assign en = (counter >= Nk) ? 1'b1 : 1'b0;

assign done = (counter >= 4 * (Nk + 6 + 1)) ? 1'b1 : 1'b0;

assign err = (~(Nk[3] ^ Nk[2]) | Nk[2] | (Nk[3] & Nk[1])) ? 1'b1 : 1'b0;

// ------------ if Counter mod Nk == 0
RotWord rot(temp_op, temp_rot_fixed);
SubWord sub(temp_rot_fixed, temp_sub_fixed);
xor32 myXor(temp_sub_fixed, Rconii, xor_fixed);
xor32 myXor2(xor_fixed, w_temp, w_mod);

// ----------- normal oerpation
xor32 myXor3(w_temp, temp_op, w_normal);

// ----------- if Nk = 8 and counter mod Nk == 4
SubWord sub2(temp_op, temp_fixed);
xor32 myXor4(temp_fixed, w_temp, w_8);

// ---------- choose iteration result and store it in w_array
mux4x1 iter_result(w_normal, w_mod, w_8, w_8, iter_result_selector, w_out);

// -----w[i]
assign temp_op = w_array[counter - 1];

// -----w[i - Nk]
assign w_temp = w_array[counter - Nk];

always @(clk, rst, err, done)
    begin
        if(rst)
        	counter = 6'b0;
		else if(!err && !done) begin
			counter = counter + 6'h1;		
if(en && !done)
			w_array[counter - 1] = w_out;	
	if (counter == 6'h1 && !err) begin
		w_array[0] = w_array_fixed[0];
		w_array[1] = w_array_fixed[1];
		w_array[2] = w_array_fixed[2];
		w_array[3] = w_array_fixed[3];
		w_array[4] = w_array_fixed[4];
		w_array[5] = w_array_fixed[5];
		w_array[6] = w_array_fixed[6];
		w_array[7] = w_array_fixed[7];
	end
end
end


genvar k;
generate
for (k = 0; k < 60; k = k + 1) begin : getOutput
    assign w[32*k + 31: 32*k] = w_array[k];
end
endgenerate
	
endmodule


