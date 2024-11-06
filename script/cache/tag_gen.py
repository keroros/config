# 生成tag表

output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_ram/way0_tag.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        hex_str = f'{i:02x}'
        line = f'00{hex_str}0\n'
        file.write(line)

output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_ram/way1_tag.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        hex_str = f'{i:02x}'
        line = f'01{hex_str}0\n'
        file.write(line)

