`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2023 06:08:58 PM
// Design Name: 
// Module Name: mem_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_reg(
    input clk,
    input [23:0] memdata,
    output reg [23:0] data
    );
    
    always @(posedge clk)
        data <= memdata;
endmodule
