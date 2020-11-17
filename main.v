module invert (input wire i, output wire o);
   assign o = !i;
endmodule

module mux2 (input wire i0, i1, j, output wire o);
  assign o = (j==0)?i0:i1;
endmodule

module df (input wire clk, in, output wire out);
  reg df_out;
  always@(posedge clk) df_out <= in;
  assign out = df_out;
endmodule

module dfr (input wire clk, reset, in, output wire out);
  wire reset_, df_in;
  invert invert_0 (reset, reset_);
  and2 and2_0 (in, reset_, df_in);
  df df_0 (clk, df_in, out);
endmodule

module dfrl (input wire clk, reset, load, in, output wire out);
  wire _in;
  mux2 mux2_0(out, in, load, _in);
  dfr dfr_1(clk, reset, _in, out);
endmodule

module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule

module and3 (input wire i0, i1, i2, output wire o);
   wire t;
   and2 and2_0 (i0, i1, t);
   and2 and2_1 (i2, t, o);
endmodule

module xor2 (input wire i0, i1, output wire o);
  assign o = i0 ^ i1;
endmodule

module even_sequence_generator(input wire clk ,reset , output wire [0:3] o);
    wire [0:2] i;
    wire [0:10] t; 
    dfrl dfrl_0(clk,reset,1'b1,i[0],o[0]);
    dfrl dfrl_1(clk,reset,1'b1,i[1],o[1]);
    dfrl dfrl_2(clk,reset,1'b1,i[2],o[2]);
    and3 and_0(!o[0],o[1],o[2],i[0]);
    xor2 xor_0(o[1],o[2],t[0]);
    and2 and_1(!o[0],t[0],i[1]);
    and2 and_2(!o[0],!o[2],i[2]);
    assign o[3]=1'b0;
endmodule