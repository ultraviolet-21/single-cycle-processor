`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2024 03:25:05 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem(MemRead, MemWrite, addr, write_data, read_data);
    input MemRead, MemWrite;
    input [8:0] addr;
    input [31:0] write_data;
    output reg [31:0] read_data;
    
    reg [31:0] memory [0:127];
    
    always @(*)
    begin
        if (MemWrite)
            memory[addr] = write_data;
        if (MemRead)
            read_data = memory[addr];
        else
            read_data = 32'b0;
    end
            
endmodule
