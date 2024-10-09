`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2024/8/16
// Author: QiDC
// Project Name: TinyRISC-V
// File Name: std_bram.v
// Versions: v3.2
// Description: 符合赛灵思FPGA规格的BRAM标准单元 
// 
//////////////////////////////////////////////////////////////////////////////////

`include "../core/defines.v"

// 简单双口BRAM，只能A端口写B端口读
module dual_port_bram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
) (
    input  wire                  rst_n,  // 复位
    input  wire                  clka,   // 写时钟
    input  wire                  ena,    // 写使能
    input  wire [ADDR_WIDTH-1:0] addra,  // 写地址
    input  wire [DATA_WIDTH-1:0] dina,   // 写数据
    input  wire                  clkb,   // 读时钟
    input  wire                  enb,    // 读使能
    input  wire [ADDR_WIDTH-1:0] addrb,  // 读地址
    output wire [DATA_WIDTH-1:0] doutb   // 读数据
);

    reg [DATA_WIDTH-1:0] mem[0:1<<ADDR_WIDTH];
    reg [DATA_WIDTH-1:0] doutb_r;

    always @(posedge clka) begin
        if (rst_n && ena) begin
            mem[addra] <= dina;
        end
    end

    always @(posedge clkb) begin
        if (rst_n && enb) begin
            doutb_r <= mem[addrb];
        end
    end

    assign doutb = doutb_r;

endmodule
