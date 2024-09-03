`timescale 1ns/100ps // time_unit/time_precision.
//Time Unit affects the scale of all timing controls, such as #delay, @(posedge clk), etc.
//Time Precision affects how accurately the simulator can model and display timing.

module counter(
   input clk, rst,
   output reg [4:0]led);
// COUNT 60 Hz.
// Crystal Frequency = 50_000_000Hz ,
// To create 1Hz frequency 
// 50_000_000/x = 1Hz 
// x = 50_000_000. 
// Apply same method. You need 60 Hz.
// 50_000_00/x  = 60 
// x = 50_000_000 / 60 = 833_334


localparam freq_count = 50_000_000; //50MHz Crystal Oscillator
localparam bin_max = 20;
localparam sixtyhz_count = 833_334; 
reg [25:0]temp_count = 26'b0;
reg [4:0]bin_count = 5'b0;
wire [4:0] value = 5'b0;
reg tick;
wire tok;
// We need a counter which counts up to 833_334. 2^x = 833334; x = log2base(833_334) = 19.669; rounding that to 20.
 reg [20:0] sixty_count = 20'b0;

always @(posedge clk)begin
   if (rst) begin
      //led <= 1'b0;
      temp_count <= 26'b0;
   end
   else begin
      if (temp_count == (freq_count -1)) begin
         tick        <= 1'b1;
         temp_count  <= 26'b0;
      end
      else begin
         tick       <= 1'b0;
         temp_count <= temp_count + 1'b1;
      end
   end
//end
//assign tok = tick;
//always @(posedge clk, posedge rst) begin
   if (tick) begin
      if (bin_count == (bin_max -1)) begin
          bin_count <= 5'b0;
      end
      else begin
         bin_count <= bin_count + 1'b1;
      end
   end
   else bin_count <= bin_count;
   
   led <= bin_count; 
end

//assign led = bin_count;
        
//alwyays @(posedge(clk))begin
//   if (rst) begin
//      //led = 4'b0;
//      sixty_count = 20'b0;
//   end
//   else begin
//      if (sixty_count == (sixtyhz_count -1)) begin
//         led = ~led;
//      end
//      else
//         led = led;
//   end
//end
endmodule
