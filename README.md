# SpeechBrain 实战练习项目

基于 [SpeechBrain](https://github.com/speechbrain/speechbrain) 的语音处理学习与实战记录。

## 目录结构

| 目录 | 用途 |
|---|---|
| `journal/` | 每次推进的工作日志（按日期命名） |
| `recipes/` | 各任务的训练配置与改动代码 |
| `notebooks/` | Colab / Jupyter 探索笔记 |
| `results/` | 实验结果摘要（指标、loss 曲线截图） |
| `scripts/` | 通用小工具脚本 |

## 进度总表

| 日期 | 任务 | 关键结果 | 日志 |
|---|---|---|---|
| 待填 | - | - | - |

## 学习路线

- [ ] Google Speech Commands 关键词识别（基线）
- [ ] Fluent Speech Commands 意图识别
- [ ] Voicebank 语音增强
- [ ] TIMIT 音素识别
- [ ] LibriSpeech 微调预训练 ASR（Whisper / Wav2Vec2）
- [ ] VoxCeleb1 说话人验证

## 环境

- Python + PyTorch + SpeechBrain（具体版本见各次日志）
- 运行方式：所有 recipe 统一 `python train.py hparams/train.yaml`
