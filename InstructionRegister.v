`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 03:49:26 PM
// Design Name: 
// Module Name: InstructionRegister
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


module instruction_register(
    input [7:0] instruction,
    input [2:0] ir_write,
    input clk,
    output reg [4:0] opcode,
    output reg [4:0] Rs,
    output reg [4:0] Rt,
    output reg [4:0] Rd,
    output reg [7:0] imm
    );
    
    always @(posedge clk) begin
        if(ir_write) begin
            case (ir_write)
                3'b001: begin
                    opcode[4:1] = instruction[3:0];
                end
                3'b010: begin
                    opcode[0] = instruction[7]; // For some reason this case keeps getting asserted twice with both non-blocking and blocking
                    Rs = instruction[6:2]; 
                    Rt[4:3] = instruction[1:0];
                end
                3'b011: begin
                    Rt[2:0] = instruction[7:5];
                    Rd = instruction[4:0];
                end
                3'b100: begin
                    imm = instruction;
                end
                    
            endcase
        end
     end
        
endmodule
