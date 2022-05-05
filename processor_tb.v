module processor_tb ();

 reg  clk, reset;
 wire [31:0] Dout;
 
 processor dut (Dout, clk, reset);
  
 always begin
 #5 clk = ~clk;
 end
 
 initial begin
 clk = 0;
 reset = 0;
 #50
 reset = 1;
 #10
 reset = 0;
 end
 
 initial begin
 #500 $stop;
 end

endmodule 