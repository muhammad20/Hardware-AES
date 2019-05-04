module decryption(plainText, cipherText,key, Nk, Nr, clk, rst);

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


AddRoundKey2 ss(plainText, s, w, Nr);

InvShiftRows sdas(s1,s2);
InvSubByte adda(s2,s3);
AddRoundKey2 asdjkb(s3,s4, w, counter);
InvMixColumns lkjh(s4, s5);

AddRoundKey2 asdjskb(s3, s6, w, counter);

always@(posedge clk)	begin
	
	if(rst)	begin
		counter =  Nr;
		
		end
	if(done)	begin
			s1 = (counter<Nr) ? s5: s;
			counter = counter -1;
			end
	if(counter==4'b1111)	begin
			cipherText = s6;
			end
			else	cipherText = 0;
end
endmodule
