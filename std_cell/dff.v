`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2024/6/23
// Author: QiDC
// Project Name: std_cell
// File Name: dff.v
// Versions: v3.2
// Description: 标准DFF模块，用于产生DFF信号
// 
//////////////////////////////////////////////////////////////////////////////////

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

