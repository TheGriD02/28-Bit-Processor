`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////
//                                                                                  //
// Name: Griffen Devino NetID: GXD190008                                            //
// Register file module which implements read and write                             //
//////////////////////////////////////////////////////////////////////////////////////


module regfile(
    // Read addresses 1 & 2
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    // Write address & data
    input [4:0] write_addr,
    input [23:0] write_data,
    // Clock to provide impulse
    input clk,
    // Write_enable determines whether the current clock cycle includes a write
    input write_enable,
    // 24-bit Data output for read
    output reg [23:0] read_data1,
    output reg [23:0] read_data2
    );
    
    // 31 registers 24 bits long
    reg [23:0] regfile [31:0];
    initial begin
        regfile[0] = 24'b0;
    end
    
    // Writing write_data to register indicated by write_addr if write_enable is true
    always @(posedge clk) begin
        if(write_enable == 1) begin
            regfile[write_addr] = write_data;
        end
        // Performing read after write
        read_data1 = regfile[read_addr1];
        read_data2 = regfile[read_addr2];
    end

    
endmodule
