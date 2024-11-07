# 生成Data表

output_dir = '/home/qidc/Nutstore/Project/riscv/test/cache_data/'

# 定义所有行的内容列表
lines = [
    ['00000000', '00000000'],  # bank0
    ['01010101', '11111111'],  # bank1
    ['02020202', '22222222'],  # bank2
    ['03030303', '33333333']   # bank3
]

# 定义data_line变量
data_line = 2  # 你可以根据需要修改这个值

# 生成16个文件
for bank in range(4):
    for ram in range(4):
        output_file = output_dir + f'way0_bank{bank}_ram{ram}.txt'
        with open(output_file, 'w') as file:
            # 写入data_line行内容，注意顺序是ram3到ram0
            for i in range(data_line):
                file.write(lines[bank][i][(3-ram)*2:(3-ram+1)*2] + '\n')
            # 写入剩下的256-data_line行内容
            for _ in range(256 - data_line):
                file.write('00\n')

output_dir = '/home/qidc/Nutstore/Project/riscv/test/cache_data/'

# 定义所有行的内容列表
lines = [
    ['10101010', '00000000'],  # bank0
    ['11111111', '00000000'],  # bank1
    ['12121212', 'ffeeddcc'],  # bank2
    ['13131313', '00000000']   # bank3
]

# 定义data_line变量
data_line = 2  # 你可以根据需要修改这个值

# 生成16个文件
for bank in range(4):
    for ram in range(4):
        output_file = output_dir + f'way1_bank{bank}_ram{ram}.txt'
        with open(output_file, 'w') as file:
            # 写入data_line行内容，注意顺序是ram3到ram0
            for i in range(data_line):
                file.write(lines[bank][i][(3-ram)*2:(3-ram+1)*2] + '\n')
            # 写入剩下的256-data_line行内容
            for _ in range(256 - data_line):
                file.write('00\n')
