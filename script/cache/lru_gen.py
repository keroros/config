# 生成LRU表
output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_ram/way0_lru.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        file.write('1\n')

output_file = '/home/qidc/Nutstore/Project/riscv/test/cache_ram/way1_lru.txt'

with open(output_file, 'w') as file:
    for i in range(256):
        file.write('0\n')

