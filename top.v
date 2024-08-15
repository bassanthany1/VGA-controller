module top (
   input clk , rst , 
   output h_sync , v_sync , 
   output [7:0] rgb 
);
   wire video_on ;
   wire [9:0] pixel_x , pixel_y ;

vga_sync1 u0 (
     .clk(clk),
     .rst(rst) , 
     .pixel_x(pixel_x),
     .pixel_y(pixel_y),
     .video_on(video_on),
     .h_sync(h_sync),
     .v_sync(v_sync)
);

pixel_gen2 u1 (
      .clk(clk) , 
      .pixel_x (pixel_x) , 
      .pixel_y(pixel_y) ,
      .video_on(video_on), 
      .rgb_out(rgb)
);
endmodule 
