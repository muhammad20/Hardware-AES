module RotWord(inWord, outWord);

input [31:0] inWord;
output [31:0] outWord;

assign outWord[31:8] = inWord[23:0];
assign outWord[7:0] = inWord[31:24];

endmodule