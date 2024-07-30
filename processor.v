`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2024 10:59:38 AM
// Design Name: 
// Module Name: processor
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


module processor(clk, reset, Result);
    input clk, reset;
    output [31:0] Result;
    
    wire RegWrite, ALUSrc, MemtoReg, MemRead, MemWrite;
    wire [1:0] ALUOp;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire [3:0] operation;
    
    Controller ctrl (.Opcode(opcode), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
                    .MemRead(MemRead), .MemWrite(MemWrite), .ALUOp(ALUOp));
    
    ALUController alu_ctrl (.ALUOp(ALUOp), .Funct7(funct7), .Funct3(funct3), .Operation(operation));
    
    data_path dp (.clk(clk), .reset(reset),
                  .reg_write(RegWrite), .mem2reg(MemtoReg), .alu_src(ALUSrc), .mem_read(MemRead), .mem_write(MemWrite),
                  .alu_cc(operation),
                  .funct7(funct7), .funct3(funct3), .opcode(opcode), .alu_result(Result));
                  
endmodule
