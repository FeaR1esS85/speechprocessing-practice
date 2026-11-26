#!/bin/bash
# 一键同步脚本：提交当天所有改动并推送到 GitHub
# 用法：bash sync.sh "本次做了什么的一句话描述"
# 示例：bash sync.sh "跑通 GSC 基线，acc 96.2%"

set -e
cd "$(dirname "$0")"

MSG="${1:-auto sync $(date '+%Y-%m-%d %H:%M')}"

# 有改动才提交
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "没有改动，无需提交。"
else
    git add .
    git commit -m "exp: $MSG"
fi

git pull --rebase origin main
git push origin main
echo "✅ 已同步到 GitHub：$MSG"
