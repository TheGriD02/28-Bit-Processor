`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 01:02:55 PM
// Design Name: 
// Module Name: memory
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

module processor(
    input clk, reset,
    input [23:0] memdata,
    output memread, memwrite,
    output [23:0] writedata,
    output [10:0] address
    );
    
    wire [4:0] opcode;
    wire zero, aluSrcA, memtoreg, data_not_instr, PC_enable, reg_write, reg_dest;
    wire [1:0] aluOp, pc_source, aluSrcB;
    wire [2:0] ir_write;
    
    datapath dp(clk, reset, memdata, aluSrcA, mem_to_reg, data_not_instr, pc_write, pc_write_cond, reg_write, reg_dst, pc_source, aluSrcB, aluOp, ir_write, zero, address, writedata, opcode);
    control cont(opcode, clk, reset, memread, memwrite, data_not_instr, ir_write, aluSrcA, aluSrcB, mem_to_reg, pc_write, pc_write_cond, pc_source, aluOp, reg_dest, reg_write);

endmodule
