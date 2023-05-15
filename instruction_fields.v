`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2023 12:08:37 PM
// Design Name: 
// Module Name: instruction_fields
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


module instruction_fields(
    // 28-bit instruction
    input [27:0] instruction,
    // 5-bit opcode
    output [4:0] Opcode,
    // 5-bit register addresses
    output [4:0] Rs,
    output [4:0] Rd,
    output [4:0] Rt,
    // 8-bit immediate value to be used in calculations
    output [7:0] Immediate
    );
    
    
    assign Opcode = instruction[27:23];
    assign Rs = instruction[22:18];
    assign Rt = instruction[17:13];
    assign Rd = instruction[12:8];
    assign Immediate = instruction[7:0];
    
    // Area to define opcodes of commands
    always @Opcode begin
        case (Opcode)
            5'b00000 : add(Rs, Rt, Rd); // Signed add Rd <- Rs + Rt
            5'b00001 : addu(Rs, Rt, Rd); // Unsigned add Rd <- |Rs| + }Rt|
            5'b00010 : store(Immediate, Rd, Rd); // Store word M[Rd + Immediate] <- Rs
            5'b00011 : load(Immediate, Rs, Rd); // Load word Rd <- M[Rs + Immediate]
            5'b00100 : loadi(Immediate, Rd); // Load immediate Rd <- Immediate
            5'b00101 : beq(Immediate, Rs, Rt); // Branch to instruction at PC + immediate if Rs == Rt
            5'b00110 : slt(Rs, Rt, Rd); // Set on less than  if(Rs < Rt) Rd = 1
        endcase
    end
endmodule

    
// Modules which output their instruction in binary
/*
add(Rs, Rt, Rd)	Rd = Rs + Rt				Signed add
Opcode    Rs      Rt    Rd    Immediate			
00000    xxxxx  xxxxx  xxxxx  00000000
*/
module add(
    input [4:0] Rs,
    input [4:0] Rd,
    input [4:0] Rt,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 5'b00000;
    assign Instruction[22:18] = Rs;
    assign Instruction[17:13] = Rt;
    assign Instruction[12:8] = Rd;
    assign Instruction[7:0] = 8'b00000000;
    
endmodule

/*
addu(Rs, Rt, Rd)	Rd = |Rs| + |Rt|			Unsigned added
Opcode    Rs      Rt    Rd    Immediate
00001    xxxxx  xxxxx  xxxxx  00000000
*/
module addu(
    input [4:0] Rs,
    input [4:0] Rd,
    input [4:0] Rt,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 5'b00001;
    assign Instruction[22:18] = Rs;
    assign Instruction[17:13] = Rt;
    assign Instruction[12:8] = Rd;
    assign Instruction[7:0] = 8'b00000000;
    
endmodule

/*
store(Immediate, Rs, Rd) 	M[Rd + Immediate] <- Rs	Store
Opcode    Rs      Rt    Rd    Immediate			Places data in Rs at memory addr.
00010    xxxxx  00000  xxxxx  xxxxxxxx			indicated by Rd & Immediate
*/
module store(
    input [7:0] Immediate,
    input [4:0] Rs,
    input [4:0] Rd,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 4'b00010;
    assign Instruction[22:18] = Rs;
    assign Instruction[17:13] = 4'b00000;
    assign Instruction[12:8] = Rd;
    assign Instruction[7:0] = Immediate;
    
endmodule

/*
load(Immediate, Rs, Rd) 	Rd <- M[Rs + Immediate]	Load
Opcode    Rs       Rt    Rd    Immediate		  Places data at memory addr.
00011    xxxxx   00000  xxxxx  xxxxxxxx			  indicated by Rs & Immediate in Rd
*/
module load(
    input [7:0] Immediate,
    input [4:0] Rs,
    input [4:0] Rd,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 5'b00011;
    assign Instruction[22:18] = Rs;
    assign Instruction[17:13] = 5'b00000;
    assign Instruction[12:8] = Rd;
    assign Instruction[7:0] = Immediate;
    
endmodule

/*
loadi(Immediate, Rd)	Rd <- Immediate	    Load immediate
Opcode    Rs      Rt    Rd    Immediate		Places immediate value in Rd
00100    00000  00000  xxxxx  xxxxxxxx
*/
module loadi(
    input [7:0] Immediate,
    input [4:0] Rs,
    input [4:0] Rd,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 5'b00100;
    assign Instruction[22:18] = 5'b00000;
    assign Instruction[17:13] = 5'b00000;
    assign Instruction[12:8] = Rd;
    assign Instruction[7:0] = Immediate;
    
endmodule

/*
beq(Immediate, Rs, Rt)					        Branch on equal
Opcode    Rs      Rt     Rd   Immediate			Branches if Rs == Rt
00101    xxxxx  xxxxx  00000  xxxxxxxx
*/

module beq(
    input [7:0] Immediate,
    input [4:0] Rs,
    input [4:0] Rt,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 5'b000101;
    assign Instruction[22:18] = Rs;
    assign Instruction[17:13] = Rt;
    assign Instruction[12:8] = 5'b00000;
    assign Instruction[7:0] = Immediate;
    
endmodule

/*
slt(Rs, Rt, Rd);		Rd = 1 if Rs < Rt		Set on less than
Opcode    Rs     Rt      Rd    Immediate		Sets Rd to 1 if Rs < Rt
00110    xxxxx  xxxxx  xxxxx   00000000
*/
module slt(
    input [4:0] Rs,
    input [4:0] Rd,
    input [4:0] Rt,
    output [27:0] Instruction
    );
    
    assign Instruction[27:23] = 5'b00110;
    assign Instruction[22:18] = Rs;
    assign Instruction[17:13] = Rt;
    assign Instruction[12:8] = Rd;
    assign Instruction[7:0] = 8'b00000000;
    
endmodule