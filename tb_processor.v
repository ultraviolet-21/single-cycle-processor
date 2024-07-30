`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2024 03:15:21 PM
// Design Name: 
// Module Name: tb_processor
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


module tb_processor();
 /** Clock & reset **/
    reg clk , rst ;
    wire [31:0] tb_Result;
    
    processor processor_inst(.clk(clk), .reset(rst), .Result(tb_Result));
    
    always begin
        #10;
        clk = ~clk;
        end
        
    initial begin
        clk = 0;
        @( posedge clk );
        rst = 1;
        @( posedge clk );
        rst = 0;
        end
        
     initial begin
        $dumpfile("test.vcd");
        $dumpvars;
        end
    
    integer point =0;
    
    always @(*)
        begin
        #20;
        if (tb_Result == 32'h00000000) // and
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000001) // addi
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000002) // addi
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000004) // addi
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000005) // addi
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000007) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000008) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h0000000b) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000003) 
            point = point + 1;
        #20;
        if (tb_Result == 32'hfffffffe) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000000) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000005) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000001) 
            point = point + 1;
        #20;
        if (tb_Result == 32'hfffffff4) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h000004d2) 
            point = point + 1;
        #20;
        if (tb_Result == 32'hfffff8d7) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000001) 
            point = point + 1;
        #20;
        if (tb_Result == 32'hfffffb2c) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000030) 
            point = point + 1;
        #20;
        if (tb_Result == 32'h00000030) 
            point = point + 1;
            
        $display("%s%d","The number of correct test cases is:" , point);
    end
    
    initial begin
    #430;
    $finish;
    end
endmodule
