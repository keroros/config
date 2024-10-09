#!/bin/bash

# 设置仓库目录的路径
REPO_DIRS=(
    "/home/qidc/Nutstore/dotfiles"
    "/home/qidc/Nutstore/Project/gysc"
    "/home/qidc/Nutstore/Project/riscv"
    "/home/qidc/Nutstore/Project/config"
)

# 遍历每个仓库目录
for repo in "${REPO_DIRS[@]}"; do
    echo "Pushing changes in $repo"
    cd "$repo" || continue
    git add .
    git commit -m "Automated commit"
    git push origin main
done
