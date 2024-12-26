def hex_to_signed_int(hex_str, bit_width):
    """
    将十六进制字符串转换为有符号整数
    """
    value = int(hex_str, 16)
    # 检查最高位是否为1（负数）
    if value & (1 << (bit_width - 1)):
        # 如果是负数，进行符号扩展
        value -= 1 << bit_width
    return value

def signed_int_to_hex(value, bit_width):
    """
    将有符号整数转换为指定位宽的十六进制字符串
    """
    # 确保值在指定位宽范围内
    mask = (1 << bit_width) - 1
    value &= mask
    return hex(value)

def hex_multiply(hex1, hex2):
    # 将十六进制字符串转换为有符号整数
    try:
        int1 = hex_to_signed_int(hex1, 31)  # 第一个数位宽为31
        int2 = hex_to_signed_int(hex2, 35)  # 第二个数位宽为35
    except ValueError:
        raise ValueError("输入的不是有效的十六进制数")
    
    # 计算乘积
    product = int1 * int2
    
    # 将乘积转换为65位有符号十六进制字符串
    hex_product = signed_int_to_hex(product, 65)
    
    return hex_product

# 获取用户输入
hex1 = input("请输入第一个31位有符号十六进制数（例如 0x7FFFFFFF）：")
hex2 = input("请输入第二个35位有符号十六进制数（例如 0x7FFFFFFFF）：")

try:
    # 计算乘积
    result = hex_multiply(hex1, hex2)
    # 输出结果
    print("乘积的十六进制表示:", result)
except ValueError as e:
    print("错误:", e)
