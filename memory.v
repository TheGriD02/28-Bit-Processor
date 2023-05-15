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


module memory(
    input clk,
    input memwrite,
    input memread,
    input [10:0] address,
    input [23:0] writedata,
    output reg [23:0] memdata
    );
    
    
    reg[23:0] mem [2047:0];
    initial begin
        mem[16] = 20;
        mem[32] = 22;
        mem[1024] = 8'b00000001; // Opcode = 00011, Rs = 0, Rt = 0, Rd = 00001, imm = 16 = 00010000, load
        mem[1025] = 8'b10000000;
        mem[1026] = 8'b00000001;
        mem[1027] = 8'b00010000;
        mem[1028] = 8'b00000001; // Opcode = 00011, Rs = 0, Rt = 0, Rd = 00010, imm = 32 = 00100000, load
        mem[1029] = 8'b10000000;
        mem[1030] = 8'b00000010;
        mem[1031] = 8'b00100000;
        mem[1032] = 8'b00000000; // Opcode = 00000, Rs = 00001, Rt = 00010, Rd = 00011, imm = 00000000, add
        mem[1033] = 8'b00000100;
        mem[1034] = 8'b01000011;
        mem[1035] = 8'b00000000;
        mem[1036] = 8'b00000001; // Opcode = 00010, Rs = 00011, Rt = 0, Rd = 0, imm = 48 = 00110000, store
        mem[1037] = 8'b00001100;
        mem[1038] = 8'b00000000;
        mem[1039] = 8'b00110000;
    end
    always @(posedge clk) begin
        if(memwrite)
            mem[address] = writedata;
        if (memread && (address >= 11'b10000000000))
            memdata = mem[address][7:0];
        else if (memread)
            memdata = mem[address];
    end
            
        
        
    
endmodule
