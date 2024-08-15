module pixel_gen2 (
    input wire clk,              
    input wire [9:0] pixel_x,    
    input wire [9:0] pixel_y,    
    input wire video_on,         
    output reg [7:0] rgb_out     
);

    
    localparam IMG_WIDTH = 640;
    localparam IMG_HEIGHT = 480;

   
    localparam ADDR_WIDTH = $clog2(IMG_WIDTH * IMG_HEIGHT);

   
    reg [7:0] memory [0:(IMG_WIDTH*IMG_HEIGHT)-1];

   
    wire [ADDR_WIDTH-1:0] address;
    assign address = (pixel_y * IMG_WIDTH) + pixel_x;

    
    initial begin
        $readmemh("image_data (4).hex", memory);  
    end

   
    always @(posedge clk) begin
        if (video_on)
            rgb_out <= memory[address];
        else
            rgb_out <= 8'b00000000; 
    end

endmodule

