# 生成Dirty表
output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_dirty/way0_dirty.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        file.write('0\n')

output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_dirty/way1_dirty.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        file.write('0\n')

