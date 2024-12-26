def decimal_to_binary(decimal_value, bit_width):
    """
    将十进制数转换为指定位宽的二进制字符串。
    """
    if decimal_value < 0:
        # 如果是负数，计算其补码
        binary_str = bin((1 << bit_width) + decimal_value)[2:]
    else:
        # 如果是正数，直接转换为二进制
        binary_str = bin(decimal_value)[2:].zfill(bit_width)
    return binary_str


def binary_to_csd(binary_str):
    binary_list = list(map(int, list(binary_str)))  # 将二进制字符串转换为整数列表
    n = len(binary_list)
    i = 0
    csd_list = []

    while i < n:
        if i + 2 < n and binary_list[i] == 1 and binary_list[i+1] == 1 and binary_list[i+2] == 1:
            # 如果连续出现三个或以上的1，转换为100...0-1
            # 统计连续1的个数
            count = 0
            while i + count < n and binary_list[i + count] == 1:
                count += 1
            # 覆盖前面的位
            if len(csd_list) >= 1:
                csd_list[-1] = 1  # 覆盖前一个位
            else:
                csd_list.append(1)  # 如果列表为空，直接添加1
            # 添加中间的0
            csd_list.extend([0] * (count - 1))  # 添加 count - 1 个0
            csd_list.append(-1)  # 添加-1
            i += count  # 跳过已处理的连续1
        else:
            # 否则直接添加到CSD列表
            csd_list.append(binary_list[i])
            i += 1

    return csd_list


def generate_verilog(binary_str, input_var, output_var, input_width, output_width):
    # 去除输入中的下划线（如果有）
    binary_str = binary_str.replace("_", "")
    # 转换为CSD码
    csd_list = binary_to_csd(binary_str)
    n = len(csd_list)
    verilog_terms = []

    # 遍历CSD码，生成Verilog项
    for i in range(n):
        if csd_list[i] == 1:
            shift = n - i - 1
            if shift == 0:
                verilog_terms.append(f"+{{{input_var}}}")
            else:
                # 计算需要添加的符号位数
                total_bits = input_width + shift
                sign_bits = output_width - total_bits
                if sign_bits > 0:
                    verilog_terms.append(f"+{{{{{sign_bits}{{{input_var}[{input_width-1}]}}}}, {input_var}, {shift}'b0}}")
                else:
                    verilog_terms.append(f"+{{{input_var}, {shift}'b0}}")
        elif csd_list[i] == -1:
            shift = n - i - 1
            if shift == 0:
                verilog_terms.append(f"-{{{input_var}}}")
            else:
                # 计算需要添加的符号位数
                total_bits = input_width + shift
                sign_bits = output_width - total_bits
                if sign_bits > 0:
                    verilog_terms.append(f"-{{{{{sign_bits}{{{input_var}[{input_width-1}]}}}}, {input_var}, {shift}'b0}}")
                else:
                    verilog_terms.append(f"-{{{input_var}, {shift}'b0}}")

    # 生成Verilog的assign语句
    verilog_code = f"assign {output_var} = " + " ".join(verilog_terms) + ";"
    # 去掉第一个项前面的加号（如果存在）
    if verilog_code.startswith(f"assign {output_var} = +"):
        verilog_code = verilog_code.replace(f"assign {output_var} = +", f"assign {output_var} = ", 1)
    return verilog_code


# 用户输入
base_dir = "/home/qidc/Nutstore/Project/gysc/test/coefficient/"
file_name = input("请输入文件名（例如 test）: ")  # 用户只需输入文件名，不需要后缀
file_path = base_dir + file_name + ".txt"  # 自动添加 .txt 后缀
num_coeffs = int(input("请输入系数的个数（例如 3）: "))
bit_width = int(input("请输入二进制码的位宽（例如 31）: "))
input_width = int(input("请输入输入变量的位宽（例如 35）: "))
output_width = int(input("请输入输出变量的位宽（例如 65）: "))
input_prefix = input("请输入被乘数的变量名前缀（例如 x）: ")
output_prefix = input("请输入乘法结果的变量名前缀（例如 dat2）: ")

# 从文件中读取系数
with open(file_path, "r") as file:
    coefficients = [int(line.strip()) for line in file.readlines()[:num_coeffs]]

# 生成多行Verilog代码
for i in range(num_coeffs):
    # 生成变量名
    input_var = f"{input_prefix}[{i}]"  # 使用用户输入的前缀生成变量名
    output_var = f"{output_prefix}[{i}]"  # 使用用户输入的前缀生成变量名
    # 将十进制数转换为二进制字符串
    binary_str = decimal_to_binary(coefficients[i], bit_width)
    # 每4位添加下划线，方便阅读
    binary_str_formatted = "_".join([binary_str[j:j+4] for j in range(0, len(binary_str), 4)])
    # 转换为CSD码
    csd_list = binary_to_csd(binary_str)
    # 输出二进制系数和对应的CSD码
    # print(f"系数 {i} 的二进制表示: {binary_str_formatted}")
    # print(f"系数 {i} 的CSD码: {csd_list}")
    # 生成Verilog代码
    verilog_output = generate_verilog(binary_str, input_var, output_var, input_width, output_width)
    # 输出结果
    print(verilog_output)
