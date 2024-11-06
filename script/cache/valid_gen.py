# 生成Valid表
output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_valid/way0_valid.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        file.write('1\n')

output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_valid/way1_valid.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        file.write('1\n')

