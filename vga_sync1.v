module vga_sync1 (
  input clk, rst, 
  output reg [9:0] pixel_x, pixel_y, 
  output video_on, 
  output reg h_sync, v_sync
);

parameter H_DISPLAY = 640;
parameter H_FRONT = 16;
parameter H_SYNC = 96;
parameter H_BACK = 48;
parameter V_DISPLAY = 480;
parameter V_FRONT = 10;
parameter V_SYNC = 2;
parameter V_BACK = 33;

parameter H_TOTAL = (H_DISPLAY + H_FRONT + H_SYNC + H_BACK);
parameter V_TOTAL = (V_DISPLAY + V_FRONT + V_SYNC + V_BACK);

reg [9:0] h_count ;  
reg [9:0] v_count ;

// Horizontal and vertical counters
always @(posedge clk or posedge rst) begin
    if (rst) begin
        h_count <= 0;
        v_count <= 0;
    end else begin
        if (h_count == H_TOTAL - 1) begin
            h_count <= 0;
            if (v_count == V_TOTAL - 1) begin
                v_count <= 0;
            end else begin
                v_count <= v_count + 1;
            end
        end else begin
            h_count <= h_count + 1;
        end
    end
end

// Horizontal sync signal generation
always @(posedge clk or posedge rst) begin
    if (rst) begin
        h_sync <= 1'b1;
    end else if (h_count >= (H_DISPLAY + H_FRONT) && h_count < (H_DISPLAY + H_FRONT + H_SYNC)) begin
        h_sync <= 1'b0;  
    end else begin
        h_sync <= 1'b1;
    end
end

// Vertical sync signal generation
always @(posedge clk or posedge rst) begin
    if (rst) begin
        v_sync <= 1'b1;
    end else if (v_count >= (V_DISPLAY + V_FRONT) && v_count < (V_DISPLAY + V_FRONT + V_SYNC)) begin
        v_sync <= 1'b0;  
    end else begin
        v_sync <= 1'b1;
    end
end

// Video on/off signal
assign video_on = (h_count < H_DISPLAY && v_count < V_DISPLAY);

// Pixel X and Y coordinates
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pixel_x <= 0;
        pixel_y <= 0;
    end else begin
        pixel_x <= h_count;
        pixel_y <= v_count;
    end
end

endmodule

