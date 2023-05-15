`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////
//                                                                                  //
// Name: Griffen Devino NetID: GXD190008                                            //
// Control module which implements the functions of the control module for          //
// add, branch on equal, store, load, and set on less than                          //
//////////////////////////////////////////////////////////////////////////////////////


module control(
    input [4:0] opcode,
    input clk,
    input reset,
    output reg memread,
    output reg memwrite,
    output reg data_not_instr,
    output reg [2:0] ir_write,
    output reg aluSrcA,
    output reg [1:0] aluSrcB,
    output reg mem_to_reg,
    output reg pc_write,
    output reg pc_write_cond,
    output reg [1:0] pc_source,
    output reg [1:0] aluOp,
    output reg reg_dest,
    output reg reg_write
    );
    // Instruction fetch state
    parameter STATE_IF0 = 1;
    parameter STATE_IF1 = 2;
    parameter STATE_IF2 = 3;
    parameter STATE_IF3 = 4;
    // Instruction decode state
    parameter STATE_ID = 5;
    // Memory address computation state
    parameter STATE_MEM_ADDR_COMP = 6;
    // Memory access for load instruction state
    parameter STATE_MEM_ACC_LOAD = 7;
    // Write back state
    parameter STATE_WRITE_BACK = 8;
    // Memory access for store instruction state
    parameter STATE_MEM_ACC_STORE = 9;
    // Execution state
    parameter STATE_EXEC = 10;
    // R-type completion state
    parameter STATE_R_COMP = 11;
    // Branch completion state
    parameter STATE_BRANCH_COMP = 12;
    // Starting state
    parameter STATE_START = STATE_IF0;
    
    // Registers to hold current state and next state of module
    reg [4:0] state;
    reg [4:0] next_state;
    
    always @(posedge clk) begin
        ir_write = next_ir_write;
    // Resets all signals and state if reset = 1
        if(reset) begin
                state = STATE_START;
                memread = 0;
                memwrite = 0;
                data_not_instr = 0;
                ir_write = 0;
                aluSrcA = 0;
                aluSrcB = 2'b00;
                mem_to_reg = 0;
                pc_write = 0;
                pc_write_cond = 0;
                pc_source = 2'b00;
                aluOp = 2'b00;
                reg_dest = 0;
            end
        else // If reset is 0 state moves on to next state
            state <= next_state;
            
        // Case statement which assigns next state and outputs
        case(state)
            STATE_IF0: begin
                         ir_write = 3'b001;
                         next_state = STATE_IF1;
                         memread = 1;
                         aluSrcA = 0;
                         data_not_instr = 0;
                         ir_write = 3'b001;
                         aluSrcB = 2'b01;
                         aluOp = 2'b00;
                         pc_write = 1;
                         pc_source = 2'b00;
                      end   
            STATE_IF1: begin
                         next_state = STATE_IF2;
                         ir_write = 3'b010;
                         memread = 1;
                         aluSrcA = 0;
                         data_not_instr = 0;
                         ir_write = 3'b010;
                         aluSrcB = 2'b01;
                         aluOp = 2'b00;
                         pc_write = 1;
                         pc_source = 2'b00;
                      end
            STATE_IF2: begin
                         next_state = STATE_IF3;
                         ir_write = 3'b011;
                         memread = 1;
                         aluSrcA = 0;
                         data_not_instr = 0;
                         aluSrcB = 2'b01;
                         aluOp = 2'b00;
                         pc_write = 1;
                         pc_source = 2'b00;
                       end
            STATE_IF3: begin
                         next_state = STATE_ID;
                         memread = 1;
                         aluSrcA = 0;
                         data_not_instr = 0;
                         ir_write = 3'b100;
                         aluSrcB = 2'b01;
                         aluOp = 2'b00;
                         pc_write = 1;
                         pc_source = 2'b00;  
                       end
            STATE_ID: begin
                        aluSrcA = 0;
                        aluSrcB = 2'b11;
                        aluOp = 2'b00; 
                        ir_write = 0;
                        case (opcode)
                            // Add instruction (R-type)
                            5'b00000: next_state = STATE_EXEC;
                            // Store instruction (I-type)
                            5'b00010: next_state = STATE_MEM_ADDR_COMP;
                            // Load instruction (I-type)
                            5'b00011: next_state = STATE_MEM_ADDR_COMP;
                            // Load immediate instruction (I-type)
                            5'b00100: next_state = STATE_MEM_ADDR_COMP;
                            // Branch on equal instruction (J-type)
                            5'b00101: next_state = STATE_BRANCH_COMP;
                            // Set on less than instruction (R-type)
                            5'b00110: next_state = STATE_EXEC;
                        endcase
                      end
            STATE_MEM_ADDR_COMP: begin
                                    aluSrcA = 1;
                                    aluSrcB = 2'b10;
                                    aluOp = 2'b00;
                                    // Assigns next state STATE_MEM_ACC_xxxxx based on if instruction is store or load
                                    if(opcode == 5'b00010)
                                        next_state = STATE_MEM_ACC_STORE;
                                    else
                                        next_state = STATE_MEM_ACC_LOAD;
                                 end
            STATE_MEM_ACC_LOAD: begin
                                    next_state = STATE_WRITE_BACK;
                                    memread = 1;
                                    data_not_instr = 1;
                                end
            STATE_WRITE_BACK: begin
                                    next_state = STATE_START;
                                    reg_dest = 0;
                                    reg_write = 1;
                                    mem_to_reg = 1;
                              end
            STATE_MEM_ACC_STORE: begin
                                    next_state = STATE_START;
                                    memwrite = 1;
                                    data_not_instr = 1;
                                 end
            STATE_EXEC: begin
                            next_state = STATE_R_COMP;
                            aluSrcA = 1;
                            aluSrcB = 2'b00;
                            // Assigning aluOp based on whether instruction is add or set on less than
                            case(opcode)
                                // Add instruction
                                5'b00000: aluOp = 01;
                                // Set on less than instruction
                                5'b00110: aluOp = 10;
                             endcase
                        end
            STATE_R_COMP: begin
                              next_state = STATE_START;
                              reg_dest = 1;
                              reg_write = 1;
                              mem_to_reg = 0;
                          end
            STATE_BRANCH_COMP: begin
                                    next_state = STATE_START;
                                    aluSrcA = 1;
                                    aluSrcB = 2'b00;
                                    aluOp = 2'b11;
                                    pc_write_cond = 1;
                                    pc_source = 2'b01;
                               end
         endcase
         
       end
                        
endmodule
