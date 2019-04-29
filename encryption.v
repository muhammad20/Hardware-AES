module encryption(plainText, cipherText,key, Nk, Nr, clk, rst);

input [4*8*4-1 : 0] plainText;
input [3 : 0] Nr;
input [3 : 0] Nk;
input [8 * 8 * 4 - 1 : 0] key;
input rst;
input clk;
output reg [4*8*4-1 : 0] cipherText;



wire [32 * 4 * (14 + 1) - 1 : 0] w;
wire err;
wire done;
wire [127:0] s;
reg [127:0] s1;
wire [127:0] s2;
wire [127:0] s3;
wire [127:0] s4;
wire [127:0] s5;
wire [127:0] s6;

reg [3:0] counter;

keyexpansion kexp (key, w, Nk, clk, rst, done, err);


AddRoundKey2 ss(plainText, s, w, 4'b0000);

//assign s1 = (counter>0) ? s5: s;

SubByte adda(s1,s2);
ShiftRows sdas(s2,s3);
MixColumns lkjh(s3,s4);
AddRoundKey2 asdjkb(s4, s5, w, counter);


AddRoundKey2 asdjskb(s3, s6, w, counter);

always@(posedge clk)	begin
	
	if(rst)	begin
		counter = 5'd0;
		
		end
	if(done)	begin
			s1 = (counter>0) ? s5: s;
			counter = counter +1;
			end
	if(counter==Nr+1)	begin
			cipherText = s6;
			end
			else	cipherText = 0;
end
endmodule
