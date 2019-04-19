module eightbitxor(out, in1, in2);
input [7:0] in1;
input [7:0] in2;
output [7:0] out;

xor(out[0],in1[0],in2[0]);
xor(out[1],in1[1],in2[1]);
xor(out[2],in1[2],in2[2]);
xor(out[3],in1[3],in2[3]);
xor(out[4],in1[4],in2[4]);
xor(out[5],in1[5],in2[5]);
xor(out[6],in1[6],in2[6]);
xor(out[7],in1[7],in2[7]);

endmodule
