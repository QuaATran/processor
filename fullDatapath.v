module fullDatapath (clk, rst, PCsrc, ALUsrc, memReadWrite, memToReg, RegWrite, immSel, ALUop, status, out, instruction, zero);

 input clk, rst, PCsrc, ALUsrc, memReadWrite, memToReg, RegWrite;
 input [1:0] immSel;
 input [2:0] ALUop;

 output zero;
 output [3:0] status;
 output [31:0] out, instruction;

 wire [7:0] muxtoPCWire, PCout, counterOut, sum;
 wire [31:0] imOut, rOut1, rOut2, writeData,  genOut, data2mux, ALUresult, readData,idOut;
 
 wire [4:0] rs1, rs2, rd;
 
 PC pc (clk, rst, muxtoPCWire, PCout);
 counter counter (rst, PCout, counterOut);
 IM im (PCout, clk, imOut);
 ID id (imOut, rd, rs1, rs2, idOut);
 
 assign instruction = idOut;
 
 adder adder (sum, PCout, genOut);
 mux2to1 mux3 (muxtoPCWire, sum, counterOut, PCsrc); // pc mux
 
 RegFile register (rs1, rs2, rd, RegWrite, writeData, rOut1, rOut2, clk, rst);
 immGen immgen (genOut, idOut, immSel);
 
 mux2to1 mux1 (data2mux, genOut, rOut2, ALUsrc); // read data 2 mux
 ALU alu (ALUresult, rOut1, data2mux, ALUop, status);
 
 assign zero = (status[2] == 1) ? 1 : 0;
 
 RAM ram (readData, rOut2, ALUresult, clk, memReadWrite);
 mux2to1 mux2 (writeData, ALUresult, readData, memToReg); // data memory mux
 
 assign out = writeData;

 
 
endmodule 