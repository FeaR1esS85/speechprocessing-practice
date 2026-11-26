# Mac 本地自动同步 GitHub 设置指南

## 第一步：本地初始化（只做一次）

```bash
# 1. 解压后进入目录
cd speechbrain-practice

# 2. 初始化 git 仓库
git init -b main
git add .
git commit -m "init: 项目骨架"
```

## 第二步：GitHub 端准备（只做一次）

1. 登录 GitHub，点右上角 `+` → `New repository`
2. 仓库名填 `speechbrain-practice`，选 **Private**（学习笔记阶段建议私有）
3. **不要**勾选 "Add a README"（避免和本地冲突），点 Create

## 第三步：配置 SSH 密钥（只做一次，以后推送免密）

```bash
# 1. 检查是否已有密钥
ls ~/.ssh/id_ed25519.pub

# 2. 没有的话生成一个（一路回车）
ssh-keygen -t ed25519 -C "你的GitHub邮箱"

# 3. 复制公钥内容
cat ~/.ssh/id_ed25519.pub
```

把输出内容粘贴到 GitHub → Settings → SSH and GPG keys → New SSH key。

验证：`ssh -T git@github.com`，看到 "Hi 用户名!" 即成功。

## 第四步：关联远程仓库（只做一次）

```bash
git remote add origin git@github.com:你的用户名/speechbrain-practice.git
git push -u origin main
```

## 第五步：日常使用 —— 每次推进完敲一行

```bash
bash sync.sh "跑通 GSC 基线，acc 96.2%"
```

脚本会自动完成：提交全部改动 → 拉取远程 → 推送。

## 可选：彻底自动化（定时同步）

如果希望即使忘记手动执行也能自动同步，用 Mac 自带的 launchd：

```bash
# 创建定时任务配置
cat > ~/Library/LaunchAgents/com.speechbrain.sync.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key><string>com.speechbrain.sync</string>
    <key>ProgramArguments</key>
    <array><string>/bin/bash</string><string>仓库完整路径/sync.sh</string></array>
    <key>StartInterval</key><integer>3600</integer>
    <key>StandardOutPath</key><string>/tmp/speechbrain-sync.log</string>
    <key>StandardErrorPath</key><string>/tmp/speechbrain-sync.log</string>
</dict>
</plist>
EOF

# 记得把上面"仓库完整路径"替换成实际路径（比如 /Users/你/speechbrain-practice）

# 加载任务（每小时自动同步一次）
launchctl load ~/Library/LaunchAgents/com.speechbrain.sync.plist

# 想停掉的话：
# launchctl unload ~/Library/LaunchAgents/com.speechbrain.sync.plist
```

## 建议的工作节奏

- 每次推进：改代码 → 写 `journal/` 日志 → `bash sync.sh "一句话描述"`
- 定时同步只是兜底，手动 sync + 有意义的提交信息才是记录的核心
