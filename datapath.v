`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 03:40:20 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk, reset,
    input [23:0] memdata,
    input aluSrcA, mem_to_reg, data_not_instr, pc_write, pc_write_cond, reg_write, reg_dst,
    input [1:0] pc_source, aluSrcB, aluOp,
    input [2:0] ir_write,
    output zero,
    output [10:0] address,
    output [23:0] writedata,
    output [4:0] opcode
    );
    
    wire [4:0] writeaddress, Rs, Rt, Rd;
    wire [10:0] pcresult, ws;
    wire [23:0] aluout, md, pcshift, wd, aout, signextended, alusrc1, alusrc2, readdata1, readdata2;
    wire [7:0] imm;
    
    
    mux2to1 regmux(Rt, Rd, reg_dst, writeaddress);
    PC pc(clk, pc_write, reset, pc_write_cond, zero, pcshift, pcresult);
    instruction_register ireg(memdata[7:0], ir_write, clk, opcode, Rs, Rt, Rd, imm);
    mem_reg memreg(clk, memdata, md);
    mem_reg areg(clk, readdata1, aout);
    mem_reg breg(clk, readdata2, writedata);
    mux2to1 addressmux(pcresult, aluOut, data_not_instr, address);
    mux2to1 alusrc1mux(pcresult, aout, aluSrcA, alusrc1);
    signextend se(imm, signextended);
    mux4to1 alusrc2mux(bout, 24'b100, signextended, signextended << 2, aluSrcB, alusrc2);
    mux4to1 pcmux(aluout, aluout, 24'b0, 24'b0, pc_source, pcshift);
    mux2to1 writedatamux(aluout, md, mem_to_reg, wd);
    
    regfile rf(Rs, Rt, writeaddress, wd, clk, reg_write, readdata1, readdata2);
    ALU alu(aluOp, alusrc1, alusrc2, aluout, zero);
endmodule
