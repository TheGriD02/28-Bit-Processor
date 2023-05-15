`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 02:24:20 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input pc_write,
    input reset,
    input pc_write_cond,
    input zero,
    input [23:0] pcshift,
    output reg [10:0] pcresult
    );
    wire pc_enable;
    assign pc_enable = pc_write || (pc_write_cond && zero);
    initial begin
        pcresult = 11'b10000000000;
    end
    always @(posedge clk) begin
        if(reset)
            pcresult = 11'b10000000000;
        else
            if(pc_enable)
                pcresult = pcresult + 1;
                
    end
endmodule
