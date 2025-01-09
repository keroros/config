// +FHDR----------------------------------------------------------------------------
// Project Name  : Tiny RISC-V
// Author        : Qidc
// Email         : qidc@stu.pku.edu.cn
// Created On    : 2024/12/31 12:08
// Last Modified : 2025/01/09 19:26
// File Name     : sync_fifo.v
// Description   :
//         
// Copyright (c) 2024 Peking University.
// ALL RIGHTS RESERVED
// 
// Local Variables: 
// verilog-library-directories:("/home/qidc/Nutstore/Project")
// verilog-library-directories-recursive:1
// End:
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/12/31   Qidc            1.0                     Original
// -FHDR----------------------------------------------------------------------------

module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    input wire clk,
    input wire rst_n,
    input wire rd_en,
    input wire wr_en,
    input wire [DATA_WIDTH-1:0] data_i,
    
    output wire empty,
    output wire full,
    output wire [DATA_WIDTH-1:0] data_o
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [ADDR_WIDTH:0] rd_ptr;
    reg [ADDR_WIDTH:0] wr_ptr;

    // 如果读使能且FIFO不空，读指针+1
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rd_ptr <= {DEPTH{1'b0}};
        end else if (rd_en && ~empty) begin
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    // 如果写使能且FIFO不满，写指针+1
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            wr_ptr <= {DEPTH{1'b0}};
        end else if (wr_en && ~full) begin
            wr_ptr <= wr_pt + 1'b1;
        end
    end

    assign empty = rd_ptr == wr_ptr;    // 读指针追上写指针，读空
    assign full = {~wr_ptr[ADDR_WIDTH], wr_ptr[ADDR_WIDTH-1:0]} == rd_ptr;  // 写指针反向追上读指针，即最高位不同，写满

    simple_dp_ram u_simple_dp_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) (
        .clka  ( clk    ),
        .ena   ( 1'b1   ), // Port enable
        .wea   ( wr_en  ),
        .addra ( wr_ptr ), // Write address
        .dina  ( data_i ),
        .clkb  ( clk    ),
        .enb   ( 1'b1   ), // Port enable
        .addrb ( rd_ptr ), // Read address
        .doutb ( data_o )
    );


endmodule

