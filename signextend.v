`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2023 03:21:00 PM
// Design Name: 
// Module Name: signextend
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


module signextend(
    input [7:0] imm,
    output [23:0] immExt
    );
    
    assign immExt = {{24{imm[7]}}, imm[7:0]};
endmodule
