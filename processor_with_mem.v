`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2023 07:15:56 PM
// Design Name: 
// Module Name: processor_with_mem
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


module processor_with_mem(
    input clk,
    input reset
    );
    
    wire memread;
    wire memwrite;
    wire [10:0] address;
    wire [23:0] memdata, writedata;
    
    processor pcr(clk, reset, memdata, memread, memwrite, writedata, address);
    memory mem(clk, memwrite, memread, address, writedata, memdata);
endmodule
