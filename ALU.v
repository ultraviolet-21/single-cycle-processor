`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2024 03:22:19 PM
// Design Name: 
// Module Name: ALU
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


module ALU(A_in, B_in, ALU_ctrl, ALU_out, carry_out, zero, overflow);
    input [31:0] A_in;
    input [31:0] B_in;
    input [3:0] ALU_ctrl;
    output reg [31:0] ALU_out;
    output reg carry_out;
    output reg zero;
    output reg overflow;
    reg [32:0] B_temp;
    reg [32:0] sum_temp;
    
    
    always @(*) begin
        carry_out = 1'b0;
        overflow = 1'b0;
        case (ALU_ctrl)
            4'b0000: begin
            //AND
            ALU_out = A_in & B_in;
            end
            4'b0001: begin
            //OR
            ALU_out = A_in | B_in;
            end
            4'b0010: begin
            //add
            sum_temp = A_in + B_in;
            ALU_out = sum_temp[31:0];
            carry_out = sum_temp[32];
            if ((A_in[31] & B_in[31] & ~ALU_out[31]) | (~A_in[31] & ~B_in[31] & ALU_out))
                overflow = 1'b1;
            else
                overflow = 1'b0;
            end
            4'b0110: begin
            //subtract 
            B_temp = ~B_in + 1; //two's complement of B_in
            sum_temp = A_in + B_temp;
            ALU_out = sum_temp[31:0];
            if ((A_in[31] & B_temp[31] & ~ALU_out[31]) | (~A_in[31] & ~B_temp[31] & ALU_out[31]))
                overflow = 1'b1;
            else
                overflow = 1'b0;
            end
            4'b0111: begin
            //set less than
            //ALU_out = (A_in < B_in) ? 1: 0;
            ALU_out = ($signed(A_in) < $signed(B_in))?32'd1:32'd0;
            end
            4'b1100: begin
            //NOR
            ALU_out = ~(A_in | B_in);
            end
            4'b1111: begin
            //equal comparison
            ALU_out = (A_in == B_in) ? 1: 0;
            end
            default: begin
            sum_temp = A_in + B_in;
            ALU_out = sum_temp[31:0];
            carry_out = sum_temp[32];
            if ((A_in[31] & B_in[31] & ~ALU_out[31]) | (~A_in[31] & ~B_in[31] & ALU_out))
                overflow = 1'b1;
            else
                overflow = 1'b0;
            end
        endcase
    //zero output
    zero = &(~ALU_out);
    end
endmodule