module top2_tb;
  reg clk, rst;
  wire h_sync, v_sync;
  wire [7:0] rgb;

  top uut (
    .clk(clk),
    .rst(rst),
    .h_sync(h_sync),
    .v_sync(v_sync),
    .rgb(rgb)
  );
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  
  end
  initial begin
    rst = 1;
    #10 rst = 0; 
  end
initial begin
    #1000000 $stop;  
end
endmodule

