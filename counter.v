module counter (rst, Din, Dout);

 input  		rst;
 input  		[7:0] Din;
 output reg [7:0] Dout;

 always @(*) begin
 
  if (rst == 0)
   Dout = Din + 4;
 
 end

endmodule 