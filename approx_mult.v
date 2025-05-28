module HA(output sum, carry, input a, b);
assign sum = a^b;
assign carry =(a&b);
endmodule

module FA(output sum1, carry1, input c,d,cin);
assign sum1 =(c^d^cin);
assign carry1 = ((c&d)|(c&cin)|(d&cin));
endmodule

module approxcomp(input x1,x2,x3,x4, output s,c);
assign s=x3|(x3^x4)&(~(x1^x2));
assign c=x1|(x2&x4)&(x3|x4);

endmodule

module approxadder2(input x1,x2,x3,cin ,output s,c);
assign s= (~(x1|(x2&cin)));
assign c=(x1|x2)|(cin);
endmodule


module multiplier_8x8_struct(output [15:0] out, input [7:0] A, B);

wire[64:0] s,c,cout,S,M,carry;

//STAGE 1
HA ha1(s[0],c[0],(A[4]&B[0]),(A[3]&B[1]));
HA ha7(s[7],c[7], (A[1]&B[0]),(A[0]&B[1]));

HA ha3(s[2],c[2],(A[2]&B[4]),(A[1]&B[5]));
HA ha4(s[3],c[3],(A[3]&B[6]),(A[2]&B[7]));
FA fa1(s[4],c[4],(A[3]&B[5]),(A[2]&B[6]),(A[1]&B[7]));

approxcomp ac1((A[5]&B[0]),(A[4]&B[1]),(A[3]&B[2]),(A[2]&B[3]),S[1],carry[1]);
approxcomp ac2((A[6]&B[0]),(A[5]&B[1]),(A[4]&B[2]),(A[3]&B[3]),S[2],carry[2]);
approxcomp ac3((A[7]&B[0]),(A[6]&B[1]),(A[5]&B[2]),(A[4]&B[3]),S[3],carry[3]);
approxcomp ac4((A[3]&B[4]),(A[2]&B[5]),(A[1]&B[6]),(A[0]&B[7]),S[4],carry[4]);

FA C51(M[0],cout[0],(A[7]&B[1]),(A[6]&B[2]),(A[5]&B[3]));
HA C52(S[5],carry[5],(A[4]&B[4]),M[0]);

FA C61(M[1],cout[1],(A[7]&B[2]),(A[6]&B[3]),(A[5]&B[4]));
FA C62(S[6],carry[6],(A[4]&B[5]),M[1],cout[0]);

FA C63(M[2],cout[2],(A[7]&B[3]),(A[6]&B[4]),(A[5]&B[5]));
FA C64(S[7],carry[7],(A[4]&B[6]),M[2],cout[1]);

FA ha2(s[1],c[1],(A[7]&B[4]),(A[6]&B[5]),cout[2]);

//STAGE 2

approxadder2 AF1((A[2]&B[0]),(A[1]&B[1]),(A[0]&B[2]),c[7],s[21],c[21]);
approxadder2 AF2((A[3]&B[0]),(A[2]&B[1]),(A[1]&B[2]),(A[0]&B[3]),S[8],carry[8]);

approxcomp ac9(s[0],(A[0]&B[4]),(A[2]&B[2]),(A[1]&B[3]),S[9],carry[9]);
approxcomp ac10(S[1],(A[1]&B[4]),(A[0]&B[5]),c[0],S[10],carry[10]);
approxcomp ac11(S[2],(A[0]&B[6]),carry[1],s[2],S[11],carry[11]);

//approxcomp ac12(S[3],S[4],carry[2],c[2],S[12],carry[12]);
FA Cx74(M[8],cout[8],S[3],S[4],carry[2]);
HA Cx75(S[12],carry[12],c[2],M[8]);

FA Cx61(M[3],cout[3],S[5],s[4],carry[3]);
FA Cx62(S[13],carry[13],carry[4],M[3],cout[8]);

FA Cx67(M[4],cout[4],S[6],s[3],carry[5]);
FA Cx65(S[14],carry[14],c[4],M[4],cout[3]);

FA Cx69(M[5],cout[5],S[7],(A[3]&B[7]),carry[6]);
FA Cx68(S[15],carry[15],c[3],M[5],cout[4]);

FA Cx70(M[6],cout[6],s[1],(A[5]&B[6]),carry[7]);
FA Cx71(S[16],carry[16],(A[4]&B[7]),M[6],cout[5]);

FA Cx72(M[7],cout[7],(A[7]&B[5]),(A[6]&B[6]),(A[5]&B[7]));
FA Cx73(S[17],carry[17],c[1],M[7],cout[6]);

FA ha6(s[6],c[6],(A[7]&B[6]),(A[6]&B[7]),cout[7]);

//STAGE 3

HA fa3(s[9],c[9], S[8],c[21]);
FA fa4(s[10],c[10], S[9],carry[8], c[9]);
FA fa5(s[11],c[11], S[10],carry[9], c[10]);
FA fa6(s[12],c[12], S[11],carry[10], c[11]);
FA fa7(s[13], c[13], S[12], carry[11], c[12]);
FA fa8(s[14], c[14], S[13], carry[12], c[13]);
FA fa9(s[15], c[15], S[14], carry[13], c[14]);
FA fa10(s[16], c[16], S[15], carry[14], c[15]);
FA fa11(s[17], c[17], S[16], carry[15], c[16]);
FA fa12(s[18], c[18], S[17], carry[16], c[17]);
FA fa13(s[19], c[19], s[6], carry[17], c[18]);
FA ha14(s[20],c[20], (A[7]&B[7]), c[19], c[6]);


assign out[0] = A[0]&B[0]; 
assign out[1] = s[7];
assign out[2] = s[21]; 
assign out[3] = s[9];   
assign out[4] = s[10];  
assign out[5] = s[11];
assign out[6] = s[12];
assign out[7] = s[13];
assign out[8] = s[14];
assign out[9] = s[15];
assign out[10] = s[16];
assign out[11] = s[17];
assign out[12] = s[18];
assign out[13] = s[19];
assign out[14] = s[20];
assign out[15] = c[20];


endmodule