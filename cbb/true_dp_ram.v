// +FHDR----------------------------------------------------------------------------
// Project Name  : Common Building Blocks
// Author        : Qidc
// Email         : qidc@stu.pku.edu.cn
// Created On    : 2024/10/21 09:33
// Last Modified : 2024/12/31 12:08
// File Name     : true_dp_ram.v
// Description   : 真双端口ram，两个端口可以同时读或写，但每个端口不能同时进行
// 读写
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

module true_dp_ram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
) (
    input  wire                  clka,   // a口写时钟
    input  wire                  ena,    // a端口使能
    input  wire                  wea,    // a口写使能
    input  wire [ADDR_WIDTH-1:0] addra,  // a口写地址
    input  wire [DATA_WIDTH-1:0] dina,   // a口写数据
    input  wire                  clkb,   // b口读时钟
    input  wire                  enb,    // b端口使能
    input  wire                  web,    // b口写使能
    input  wire [ADDR_WIDTH-1:0] addrb,  // b口读地址
    input  wire [DATA_WIDTH-1:0] dinb,   // b口写数据
    output wire [DATA_WIDTH-1:0] douta,  // a口读数据
    output wire [DATA_WIDTH-1:0] doutb   // b口读数据
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    reg [DATA_WIDTH-1:0] douta_r;
    reg [DATA_WIDTH-1:0] doutb_r;

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

    always @(posedge clkb) begin
        if (enb && web) begin
            mem[addrb] <= dinb;
        end
    end

    always @(posedge clkb) begin
        if (enb && ~web) begin
            doutb_r <= mem[addrb];
        end
    end

    assign douta = douta_r;
    assign doutb = doutb_r;

endmodule
