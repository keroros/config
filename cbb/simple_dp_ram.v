// +FHDR----------------------------------------------------------------------------
// Project Name  : Common Building Blocks
// Author        : Qidc
// Email         : qidc@stu.pku.edu.cn
// Created On    : 2024/10/21 09:47
// Last Modified : 2024/12/31 19:39
// File Name     : simple_dp_ram.v
// Description   : 简单双端口ram，只能a端口读b端口写，读写可以同时进行
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

module simple_dp_ram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
) (
    input  wire                  clka,   // 写时钟
    input  wire                  ena,    // 写端口使能
    input  wire                  wea,    // 写使能
    input  wire [ADDR_WIDTH-1:0] addra,  // 写地址
    input  wire [DATA_WIDTH-1:0] dina,   // 写数据
    input  wire                  clkb,   // 读时钟
    input  wire                  enb,    // 读端口使能
    input  wire [ADDR_WIDTH-1:0] addrb,  // 读地址
    output wire [DATA_WIDTH-1:0] doutb   // 读数据
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    reg [DATA_WIDTH-1:0] doutb_r;

    always @(posedge clka) begin
        if (ena && wea) begin
            mem[addra] <= dina;
        end
    end

    always @(posedge clkb) begin
        if (enb) begin
            doutb_r <= mem[addrb];
        end
    end

    assign doutb = doutb_r;

endmodule
