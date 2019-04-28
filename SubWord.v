module SubWord(inWord, outWord);

input [31:0] inWord;
output [31:0] outWord;

SubByte s1(inWord, outWord);
endmodule