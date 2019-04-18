//to get A0 mod B
// hold state of A0 and compare A0 with B if A0 > B then A1 = A0 - B
// then hold state of A1 and compare A1 with B and so on till we get An < B
// irr_pol = irreducable polynomial

module mod(inData, outData, irr_pol);

parameter size = 4;

input [size-1:0] inData;
input [size-1:0] irr_pol;
output [size-1:0] outData;

