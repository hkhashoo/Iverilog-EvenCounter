`timescale 1 ns / 100 ps

module tb;
  reg clk, reset;
  wire [0:3]out;
  integer i;
  initial begin $dumpfile("main_tb.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #10 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  even_sequence_generator eqg0(clk, reset,out);
  initial begin
    #110 $finish;
  end
endmodule
