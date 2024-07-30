`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2024 10:01:05 AM
// Design Name: 
// Module Name: Datapath
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


module data_path #(parameter PC_W =8, parameter INS_W = 32, parameter RF_ADDRESS = 5,
                parameter DATA_W = 32, parameter DM_ADDRESS = 9, parameter ALU_CC_W = 4)
                (clk, reset, reg_write, mem2reg, alu_src, mem_write, mem_read, alu_cc, 
                opcode, funct7, funct3, alu_result);
                
    input clk, reset, reg_write, mem2reg, alu_src, mem_write, mem_read;
    input [ALU_CC_W-1:0] alu_cc;
    output [6:0] opcode, funct7;
    output [2:0] funct3;
    output [DATA_W-1:0] alu_result;
    
    wire [PC_W-1:0] next_pc, pc_out;
    wire [INS_W-1:0] instruction; //to be assigned to InstMem output
    wire [DATA_W-1:0] reg1, reg2, imm_out, data_mem_read;
    wire [DATA_W-1:0] write_back_data;
    wire [DATA_W:0] alu_input_2;
    wire carry_out, overflow, zero;
    wire wrt_addr, rd_addr1, rd_addr2;

    //Program Counter (PC)
    FlipFlop PC (.clk(clk), .reset(reset), .d(next_pc), .q(pc_out));
    
    //PC + 4
    assign next_pc = pc_out + 4;
    
    //Instruction Memory
    InstMem IM (.addr(pc_out), .instruction(instruction));
    
    //Instruction Decode
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    //Register File
    RegFile RF (.clk(clk), 
                .reset(reset), 
                .rg_wrt_en(reg_write), 
                .rg_wrt_addr(instruction[11:7]), 
                .rg_rd_addr1(instruction[19:15]),
                .rg_rd_addr2(instruction[24:20]), 
                .rg_wrt_data(write_back_data), 
                .rg_rd_data1(reg1), 
                .rg_rd_data2(reg2));
    
    //Immediate Generator
    ImmGen IG (.InstCode(instruction), .ImmOut(imm_out));
    
    
    
    //MUX 1
    Mux m1 (.D1(reg2), .D2(imm_out), .S(alu_src), .Y(alu_input_2));
    
    //ALU
    ALU alu (.A_in(reg1), .B_in(alu_input_2), .ALU_ctrl(alu_cc), .ALU_out(alu_result),
            .carry_out(carry_out), .zero(zero), .overflow(overflow));
    
    //Data Memory
    DataMem DM (.MemRead(mem_read), .MemWrite(mem_write), .addr(alu_result[DM_ADDRESS-1:0]), 
                .write_data(reg2), .read_data(data_mem_read));
    
    //MUX 2
    Mux m2 (.D1(alu_result), .D2(data_mem_read), .S(mem2reg), .Y(write_back_data));
    //assign write_back_data = mem2reg?data_mem_read:alu_result;
    
endmodule
