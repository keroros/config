// +FHDR----------------------------------------------------------------------------
// Project Name  : Common Building Blocks
// Author        : Qidc
// Email         : qidc@stu.pku.edu.cn
// Created On    : 2024/10/21 09:14
// Last Modified : 2024/11/08 15:02
// File Name     : sp_ram.v
// Description   : 单端口ram，只有一个口读写，且不能同时读写，wea为1时写，
// wea为0时读
//         
// Copyright (c) 2024 Peking University.
// ALL RIGHTS RESERVED
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2024/10/21   Qidc            1.0                     Original
// -FHDR----------------------------------------------------------------------------

module sp_ram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
) (
    input  wire                  clka,   // 写时钟
    input  wire                  ena,    // 端口使能
    input  wire                  wea,    // 写使能
    input  wire [ADDR_WIDTH-1:0] addra,  // 写地址
    input  wire [DATA_WIDTH-1:0] dina,   // 写数据
    output wire [DATA_WIDTH-1:0] douta   // 读数据
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    reg [DATA_WIDTH-1:0] douta_r;

    always @(posedge clka) begin
        if (ena && wea) begin
            mem[addra] <= dina;
        end
    end

    always @(posedge clka) begin
        if (ena && ~wea) begin
            douta_r <= mem[addra];
        end
    end

    assign douta = douta_r;

endmodule
