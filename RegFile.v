`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2024 03:21:23 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(clk, reset,
        rg_wrt_en, rg_wrt_addr,
        rg_rd_addr1, rg_rd_addr2,
        rg_wrt_data, 
        rg_rd_data1, rg_rd_data2);
        
    input clk, reset;
    input rg_wrt_en;
    input [4:0] rg_rd_addr1, rg_rd_addr2, rg_wrt_addr;
    input [31:0] rg_wrt_data;
    output [31:0] rg_rd_data1, rg_rd_data2;
    
    reg [31:0] memory [31:0];
    integer i;
    
    assign rg_rd_data1 = memory[rg_rd_addr1];
    assign rg_rd_data2 = memory[rg_rd_addr2];
    
    always @ (posedge clk or posedge reset) begin
        if (reset==1) begin
            for (i=0; i<32; i=i+1)
                memory[i]<=32'b0;
            end
              
        else if (rg_wrt_en) begin
            memory[rg_wrt_addr] <= rg_wrt_data;
            end
    end
    

endmodule

