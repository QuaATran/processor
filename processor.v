module processor (Dout, clk, reset);

 input  clk, reset;
 output [31:0] Dout;

 wire PCsrc, ALUsrc, memReadWrite, memToReg, RegWrite, zero;
 wire [1:0] immSel;
 wire [2:0] ALUop;
 wire [31:0] instruction;
 
 fullDatapath dp (clk, reset, PCsrc, ALUsrc, memReadWrite, memToReg, RegWrite, immSel, ALUop, status, Dout, instruction, zero);
 controlUnit cu (immSel, ALUop, PCsrc, ALUsrc, memReadWrite, memToReg, RegWrite, instruction, zero);
 
endmodule 