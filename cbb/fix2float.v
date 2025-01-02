// +FHDR----------------------------------------------------------------------------
// Project Name  : Tiny RISC-V
// Author        : Qidc
// Email         : qidc@stu.pku.edu.cn
// Created On    : 2025/01/02 11:02
// Last Modified : 2025/01/02 16:41
// File Name     : fix2float.v
// Description   :
//         
// Copyright (c) 2025 Peking University.
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
// 2025/01/02   Qidc            1.0                     Original
// -FHDR----------------------------------------------------------------------------


module fix2float #(
    parameter INT_BITS  = 4,    // 整数位的宽度，默认值为 4
    parameter FRAC_BITS = 30    // 小数位的宽度，默认值为 30
) (
    input  wire [INT_BITS+FRAC_BITS:0] fixed_i,
    output reg  [31:0] float_o
);

    parameter TOTAL_BITS = INT_BITS + FRAC_BITS + 1;    // 默认35

    reg                  sign;      // 符号位
    reg [7:0]            exp;       // 指数位
    reg [22:0]           mant;      // 尾数位
    reg [TOTAL_BITS-2:0] abs_fixed; // 定点数的绝对值，默认34
    reg [TOTAL_BITS-2:0] norm_mant; // 去除高位0后的尾数

    integer lead_zero; // 前导零的数量
    integer i;

    always @(*) begin
        sign = fixed_i[TOTAL_BITS-1];     // 提取符号位

        if (fixed_i[TOTAL_BITS-2:0] == 0) begin
            float_o = {sign, 31'b0};  // 根据IEEE754标准，对输入全0作特殊处理，输出 +0 或 -0
        end else begin
            abs_fixed = sign ? -fixed_i[TOTAL_BITS-2:0] : fixed_i[TOTAL_BITS-2:0];  // 取绝对值

            lead_zero = 0;          // 找到最高位的1，确定指数
            for (i = TOTAL_BITS-2; i > 0; i = i - 1) begin
                if (abs_fixed[i] == 1'b1) begin
                    lead_zero = TOTAL_BITS-2 - i;
                    break;
                end
            end

            exp = 127 + i - FRAC_BITS;    // 计算指数

            norm_mant = abs_fixed << (lead_zero + 1'b1);    // 规范化尾数
            mant = norm_mant[TOTAL_BITS-2:TOTAL_BITS-24];   // 取高23位

            float_o = {sign, exp, mant}; // 组合符号位、指数位和尾数位
        end
    end


endmodule

