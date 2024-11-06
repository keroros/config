# 执行所以生成Cache数据的脚本

import subprocess

# 定义要执行的脚本文件名列表
script_files = ["tag_gen.py", "valid_gen.py", "dirty_gen.py", "lru_gen.py", "data_gen.py"]

# 遍历每个脚本文件并执行
for script in script_files:
    try:
        # 使用 subprocess.run 执行脚本
        subprocess.run(["python3", script], check=True)
        print(f"{script} executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error executing {script}: {e}")

print("All scripts have been executed.")

