`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2023 07:27:44 PM
// Design Name: 
// Module Name: program2_tb
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


module program1_tb(

    );
    reg clk;
    reg reset;
    
    
    processor_with_mem dut(clk, reset);
    initial begin
        clk = 0;
        reset = 1;
        #6
        reset = 0;
    end
    always begin
       #5 clk = ~clk;
       $display("%d", dut.pcr.dp.opcode);
       $display("%d", dut.pcr.dp.ir_write);
       $display("%d", dut.mem.mem[48]);
    end
    
    
endmodule
