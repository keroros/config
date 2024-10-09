`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2024/6/23
// Author: QiDC
// Project Name: TinyRISC-V
// File Name: std_dffs.v
// Versions: v3.2
// Description: 标准DFF模块，用于产生DFF信号
// 
//////////////////////////////////////////////////////////////////////////////////

`include "../core/defines.v"

// 不带复位信号的标准DFF
module dff #(
    parameter WIDTH = 32
) (
    input  wire             clk,
    input  wire [WIDTH-1:0] data_i,
    output wire [WIDTH-1:0] data_o
);

    reg [WIDTH-1:0] data;

    always @(posedge clk) begin
        data <= data_i;
    end

    assign data_o = data;

endmodule

// 带复位信号的标准DFF
module dff_rs #(
    parameter WIDTH = 32
) (
    input  wire             clk,
    input  wire             rst_n,
    input  wire [WIDTH-1:0] rst_data,
    input  wire [WIDTH-1:0] data_i,
    output wire [WIDTH-1:0] data_o
);

    reg  [WIDTH-1:0] data;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin 
            data <= rst_data;
        end else begin
            data <= data_i;
        end
    end

    assign data_o = data;

endmodule

// 带复位和加载使能的标准DFF
module dff_rs_ld #(
    parameter WIDTH = 32
) (
    input  wire             clk,
    input  wire             rst_n,
    input  wire             load_en,
    input  wire [WIDTH-1:0] rst_data,
    input  wire [WIDTH-1:0] data_i,
    output wire [WIDTH-1:0] data_o
);

    reg [WIDTH-1:0] data;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            data <= rst_data;
        end else if (load_en == `LOAD_ENABLE) begin
            data <= data_i;
        end
    end

    assign data_o = data;

endmodule
