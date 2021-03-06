module InvSubByte(
					input  [127:0]prevState ,
					output [127:0] nextState 
					);

wire [7:0] s [0:3][0:3];
wire [7:0] sNew [0:3][0:3];
wire [7:0] S_box [15:0][15:0];
wire [7:0] s1;
wire [7:0] s2;
wire [7:0] s3;


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

assign s1=s[0][0];
assign s2=sNew[0][0];
assign s3=S_box[0][0];

assign sNew[0][0]=S_box[s[0][0][7:4]][s[0][0][3:0]];
assign sNew[0][1]=S_box[s[0][1][7:4]][s[0][1][3:0]];
assign sNew[0][2]=S_box[s[0][2][7:4]][s[0][2][3:0]];
assign sNew[0][3]=S_box[s[0][3][7:4]][s[0][3][3:0]];
assign sNew[1][0]=S_box[s[1][0][7:4]][s[1][0][3:0]];
assign sNew[1][1]=S_box[s[1][1][7:4]][s[1][1][3:0]];
assign sNew[1][2]=S_box[s[1][2][7:4]][s[1][2][3:0]];
assign sNew[1][3]=S_box[s[1][3][7:4]][s[1][3][3:0]];
assign sNew[2][0]=S_box[s[2][0][7:4]][s[2][0][3:0]];
assign sNew[2][1]=S_box[s[2][1][7:4]][s[2][1][3:0]];
assign sNew[2][2]=S_box[s[2][2][7:4]][s[2][2][3:0]];
assign sNew[2][3]=S_box[s[2][3][7:4]][s[2][3][3:0]];
assign sNew[3][0]=S_box[s[3][0][7:4]][s[3][0][3:0]];
assign sNew[3][1]=S_box[s[3][1][7:4]][s[3][1][3:0]];
assign sNew[3][2]=S_box[s[3][2][7:4]][s[3][2][3:0]];
assign sNew[3][3]=S_box[s[3][3][7:4]][s[3][3][3:0]];


//Construct S-box
assign S_box[0][0] = 8'h52;
assign S_box[0][1] = 8'h09;
assign S_box[0][2] = 8'h6a;
assign S_box[0][3] = 8'hd5;
assign S_box[0][4] = 8'h30;
assign S_box[0][5] = 8'h36;
assign S_box[0][6] = 8'ha5;
assign S_box[0][7] = 8'h38;
assign S_box[0][8] = 8'hbf;
assign S_box[0][9] = 8'h40;
assign S_box[0][10] = 8'ha3;
assign S_box[0][11] = 8'h9e;
assign S_box[0][12] = 8'h81;
assign S_box[0][13] = 8'hf3;
assign S_box[0][14] = 8'hd7;
assign S_box[0][15] = 8'hfb;

assign S_box[1][0] = 8'h7c;
assign S_box[1][1] = 8'he3;
assign S_box[1][2] = 8'h39;
assign S_box[1][3] = 8'h82;
assign S_box[1][4] = 8'h9b;
assign S_box[1][5] = 8'h2f;
assign S_box[1][6] = 8'hff;
assign S_box[1][7] = 8'h87;
assign S_box[1][8] = 8'h34;
assign S_box[1][9] = 8'h8e;
assign S_box[1][10] = 8'h43;
assign S_box[1][11] = 8'h44;
assign S_box[1][12] = 8'hc4;
assign S_box[1][13] = 8'hde;
assign S_box[1][14] = 8'he9;
assign S_box[1][15] = 8'hcb;

assign S_box[2][0] = 8'h54;
assign S_box[2][1] = 8'h7b;
assign S_box[2][2] = 8'h94;
assign S_box[2][3] = 8'h32;
assign S_box[2][4] = 8'ha6;
assign S_box[2][5] = 8'hc2;
assign S_box[2][6] = 8'h23;
assign S_box[2][7] = 8'h3d;
assign S_box[2][8] = 8'hee;
assign S_box[2][9] = 8'h4c;
assign S_box[2][10] = 8'h95;
assign S_box[2][11] = 8'h0b;
assign S_box[2][12] = 8'h42;
assign S_box[2][13] = 8'hfa;
assign S_box[2][14] = 8'hc3;
assign S_box[2][15] = 8'h4e;

assign S_box[3][0] = 8'h08;
assign S_box[3][1] = 8'h2e;
assign S_box[3][2] = 8'ha1;
assign S_box[3][3] = 8'h66;
assign S_box[3][4] = 8'h28;
assign S_box[3][5] = 8'hd9;
assign S_box[3][6] = 8'h24;
assign S_box[3][7] = 8'hb2;
assign S_box[3][8] = 8'h76;
assign S_box[3][9] = 8'h5b;
assign S_box[3][10] = 8'ha2;
assign S_box[3][11] = 8'h49;
assign S_box[3][12] = 8'h6d;
assign S_box[3][13] = 8'h8b;
assign S_box[3][14] = 8'hd1;
assign S_box[3][15] = 8'h25;

assign S_box[4][0] = 8'h72;
assign S_box[4][1] = 8'hf8;
assign S_box[4][2] = 8'hf6;
assign S_box[4][3] = 8'h64;
assign S_box[4][4] = 8'h86;
assign S_box[4][5] = 8'h68;
assign S_box[4][6] = 8'h98;
assign S_box[4][7] = 8'h16;
assign S_box[4][8] = 8'hd4;
assign S_box[4][9] = 8'ha4;
assign S_box[4][10] = 8'h5c;
assign S_box[4][11] = 8'hcc;
assign S_box[4][12] = 8'h5d;
assign S_box[4][13] = 8'h65;
assign S_box[4][14] = 8'hb6;
assign S_box[4][15] = 8'h92;

assign S_box[5][0] = 8'h6c;
assign S_box[5][1] = 8'h70;
assign S_box[5][2] = 8'h48;
assign S_box[5][3] = 8'h50;
assign S_box[5][4] = 8'hfd;
assign S_box[5][5] = 8'hed;
assign S_box[5][6] = 8'hb9;
assign S_box[5][7] = 8'hda;
assign S_box[5][8] = 8'h5e;
assign S_box[5][9] = 8'h15;
assign S_box[5][10] = 8'h46;
assign S_box[5][11] = 8'h57;
assign S_box[5][12] = 8'ha7;
assign S_box[5][13] = 8'h8d;
assign S_box[5][14] = 8'h9d;
assign S_box[5][15] = 8'h84;

assign S_box[6][0] = 8'h90;
assign S_box[6][1] = 8'hd8;
assign S_box[6][2] = 8'hab;
assign S_box[6][3] = 8'h00;
assign S_box[6][4] = 8'h8c;
assign S_box[6][5] = 8'hbc;
assign S_box[6][6] = 8'hd3;
assign S_box[6][7] = 8'h0a;
assign S_box[6][8] = 8'hf7;
assign S_box[6][9] = 8'he4;
assign S_box[6][10] = 8'h58;
assign S_box[6][11] = 8'h05;
assign S_box[6][12] = 8'hb8;
assign S_box[6][13] = 8'hb3;
assign S_box[6][14] = 8'h45;
assign S_box[6][15] = 8'h06;

assign S_box[7][0] = 8'hd0;
assign S_box[7][1] = 8'h2c;
assign S_box[7][2] = 8'h1e;
assign S_box[7][3] = 8'h8f;
assign S_box[7][4] = 8'hca;
assign S_box[7][5] = 8'h3f;
assign S_box[7][6] = 8'h0f;
assign S_box[7][7] = 8'h02;
assign S_box[7][8] = 8'hc1;
assign S_box[7][9] = 8'haf;
assign S_box[7][10] = 8'hbd;
assign S_box[7][11] = 8'h03;
assign S_box[7][12] = 8'h01;
assign S_box[7][13] = 8'h13;
assign S_box[7][14] = 8'h8a;
assign S_box[7][15] = 8'h6b;

assign S_box[8][0] = 8'h3a;
assign S_box[8][1] = 8'h91;
assign S_box[8][2] = 8'h11;
assign S_box[8][3] = 8'h41;
assign S_box[8][4] = 8'h4f;
assign S_box[8][5] = 8'h67;
assign S_box[8][6] = 8'hdc;
assign S_box[8][7] = 8'hea;
assign S_box[8][8] = 8'h97;
assign S_box[8][9] = 8'hf2;
assign S_box[8][10] = 8'hcf;
assign S_box[8][11] = 8'hce;
assign S_box[8][12] = 8'hf0;
assign S_box[8][13] = 8'hb4;
assign S_box[8][14] = 8'he6;
assign S_box[8][15] = 8'h73;

assign S_box[9][0] = 8'h96;
assign S_box[9][1] = 8'hac;
assign S_box[9][2] = 8'h74;
assign S_box[9][3] = 8'h22;
assign S_box[9][4] = 8'he7;
assign S_box[9][5] = 8'had;
assign S_box[9][6] = 8'h35;
assign S_box[9][7] = 8'h85;
assign S_box[9][8] = 8'he2;
assign S_box[9][9] = 8'hf9;
assign S_box[9][10] = 8'h37;
assign S_box[9][11] = 8'he8;
assign S_box[9][12] = 8'h1c;
assign S_box[9][13] = 8'h75;
assign S_box[9][14] = 8'hdf;
assign S_box[9][15] = 8'h6e;

assign S_box[10][0] = 8'h47;
assign S_box[10][1] = 8'hf1;
assign S_box[10][2] = 8'h1a;
assign S_box[10][3] = 8'h71;
assign S_box[10][4] = 8'h1d;
assign S_box[10][5] = 8'h29;
assign S_box[10][6] = 8'hc5;
assign S_box[10][7] = 8'h89;
assign S_box[10][8] = 8'h6f;
assign S_box[10][9] = 8'hb7;
assign S_box[10][10] = 8'h62;
assign S_box[10][11] = 8'h0e;
assign S_box[10][12] = 8'haa;
assign S_box[10][13] = 8'h18;
assign S_box[10][14] = 8'hbe;
assign S_box[10][15] = 8'h1b;

assign S_box[11][0] = 8'hfc;
assign S_box[11][1] = 8'h56;
assign S_box[11][2] = 8'h3e;
assign S_box[11][3] = 8'h4b;
assign S_box[11][4] = 8'hc6;
assign S_box[11][5] = 8'hd2;
assign S_box[11][6] = 8'h79;
assign S_box[11][7] = 8'h20;
assign S_box[11][8] = 8'h9a;
assign S_box[11][9] = 8'hdb;
assign S_box[11][10] = 8'hc0;
assign S_box[11][11] = 8'hfe;
assign S_box[11][12] = 8'h78;
assign S_box[11][13] = 8'hcd;
assign S_box[11][14] = 8'h5a;
assign S_box[11][15] = 8'hf4;

assign S_box[12][0] = 8'h1f;
assign S_box[12][1] = 8'hdd;
assign S_box[12][2] = 8'ha8;
assign S_box[12][3] = 8'h33;
assign S_box[12][4] = 8'h88;
assign S_box[12][5] = 8'h07;
assign S_box[12][6] = 8'hc7;
assign S_box[12][7] = 8'h31;
assign S_box[12][8] = 8'hb1;
assign S_box[12][9] = 8'h12;
assign S_box[12][10] = 8'h10;
assign S_box[12][11] = 8'h59;
assign S_box[12][12] = 8'h27;
assign S_box[12][13] = 8'h80;
assign S_box[12][14] = 8'hec;
assign S_box[12][15] = 8'h5f;

assign S_box[13][0] = 8'h60;
assign S_box[13][1] = 8'h51;
assign S_box[13][2] = 8'h7f;
assign S_box[13][3] = 8'ha9;
assign S_box[13][4] = 8'h19;
assign S_box[13][5] = 8'hb5;
assign S_box[13][6] = 8'h4a;
assign S_box[13][7] = 8'h0d;
assign S_box[13][8] = 8'h2d;
assign S_box[13][9] = 8'he5;
assign S_box[13][10] = 8'h7a;
assign S_box[13][11] = 8'h9f;
assign S_box[13][12] = 8'h93;
assign S_box[13][13] = 8'hc9;
assign S_box[13][14] = 8'h9c;
assign S_box[13][15] = 8'hef;

assign S_box[14][0] = 8'ha0;
assign S_box[14][1] = 8'he0;
assign S_box[14][2] = 8'h3b;
assign S_box[14][3] = 8'h4d;
assign S_box[14][4] = 8'hae;
assign S_box[14][5] = 8'h2a;
assign S_box[14][6] = 8'hf5;
assign S_box[14][7] = 8'hb0;
assign S_box[14][8] = 8'hc8;
assign S_box[14][9] = 8'heb;
assign S_box[14][10] = 8'hbb;
assign S_box[14][11] = 8'h3c;
assign S_box[14][12] = 8'h83;
assign S_box[14][13] = 8'h53;
assign S_box[14][14] = 8'h99;
assign S_box[14][15] = 8'h61;

assign S_box[15][0] = 8'h17;
assign S_box[15][1] = 8'h2b;
assign S_box[15][2] = 8'h04;
assign S_box[15][3] = 8'h7e;
assign S_box[15][4] = 8'hba;
assign S_box[15][5] = 8'h77;
assign S_box[15][6] = 8'hd6;
assign S_box[15][7] = 8'h26;
assign S_box[15][8] = 8'he1;
assign S_box[15][9] = 8'h69;
assign S_box[15][10] = 8'h14;
assign S_box[15][11] = 8'h63;
assign S_box[15][12] = 8'h55;
assign S_box[15][13] = 8'h21;
assign S_box[15][14] = 8'h0c;
assign S_box[15][15] = 8'h7d;

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