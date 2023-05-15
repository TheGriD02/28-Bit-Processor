`timescale 1ns / 1ns
////////////////////////////////////////////////////////////////////
//                                                                //
// Name: Griffen Devino NetID: GXD190008                          //
// Alu module which implements the functions of the alu for       //
// add, branch on equal, store, load, and set on less than        //
////////////////////////////////////////////////////////////////////


module ALU(
    // Operation for ALU to perform specified by 2 bits
    input [1:0] aluOp,
    // First input data bus, 24 bits
    input [23:0] data1,
    // Second input data bus, 24 bits
    input [23:0] data2,
    // Output data bus, 24 bits
    output reg [23:0] data_out,
    // Output bit indicating whether output is zero or not
    output reg zero
    );
    
    always @* begin
        case (aluOp)
            // Addition
            2'b00 : data_out = data1 + data2; // Used for add, store, load 
            // Subtraction
            2'b01 : data_out = data1 - data2; // Used for branch on equal to check if data1 & data2 are equal
            // Less than
            2'b10 : data_out = data1 < data2; // Used for set on less than
        endcase
        
        zero = (data_out == 0); // If output is zero sets zero to 1 which
        // indicates that data1 and data2 are equal if subtraction was done, used to branch on equal
    end
endmodule
