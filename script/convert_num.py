from tabulate import tabulate

def convert_number(base, number):
    # 将输入的字符串数字转换为整数
    if base == 2:
        num = int(number, 2)
        bit_length = len(number)
    elif base == 8:
        num = int(number, 8)
        bit_length = len(number) * 3
    elif base == 10:
        num = int(number, 10)
        bit_length = len(bin(num)) - 2
    elif base == 16:
        num = int(number, 16)
        bit_length = len(number) * 4
    else:
        return "Unsupported base!"

    # 处理补码，如果是负数
    if num >= 2 ** (bit_length - 1):
        num_signed = num - 2 ** bit_length
    else:
        num_signed = num

    # 将整数转换为其他进制的表示（去掉前缀）
    bin_result = bin(num)[2:]   # 去掉 "0b"
    oct_result = oct(num)[2:]   # 去掉 "0o"
    dec_result_unsigned = str(num)       # 十进制不需要修改
    dec_result_signed = str(num_signed)  # 有符号的十进制表示
    hex_result = hex(num)[2:]   # 去掉 "0x"
    
    # 准备表格数据
    table = [
        ["Base", "Value"],
        [f"Input ({base})", number],
        ["Binary (2)", bin_result],
        ["Octal (8)", oct_result],
        ["Decimal (10)", f"{dec_result_unsigned} (unsigned)"],
        ["Decimal (10)", f"{dec_result_signed} (signed)"],
        ["Hex (16)", hex_result],
    ]
    
    # 输出表格
    print(tabulate(table, headers="firstrow", tablefmt="grid"))

if __name__ == "__main__":
    # 获取用户输入的进制和数字
    base = int(input("Enter the base of the input number (2, 8, 10, 16): "))
    number = input(f"Enter the number in base {base}: ")
    
    # 调用转换函数并显示结果
    convert_number(base, number)
