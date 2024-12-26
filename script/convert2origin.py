def complement_to_original(complement, bit_width=35):
    # 检查最高位是否为1，确认是否为负数
    if (complement >> (bit_width - 1)) & 1:
        # 对补码取反
        inverted = ~complement
        # 取反后加1得到原码
        original = (inverted + 1) & ((1 << bit_width) - 1)  # 确保结果在指定位宽内
        return original
    else:
        # 如果是正数，补码和原码相同
        return complement

# 获取用户输入
user_input = input("请输入一个35位的负数补码（十六进制形式，例如 0x1FFFFFFFFE）：")

try:
    # 将输入的十六进制字符串转换为整数
    complement_code = int(user_input, 16)

    # 转换为原码
    original_code = complement_to_original(complement_code, bit_width=35)

    # 输出结果（十六进制形式）
    print(f"补码: {hex(complement_code)}")
    print(f"原码: {hex(original_code)}")
except ValueError:
    print("输入的不是有效的十六进制数！")
