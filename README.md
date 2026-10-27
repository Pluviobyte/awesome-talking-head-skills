# Awesome Talking Head Skills

把做得好的口播（talking head）博主的出镜方式，拆成 AI Agent 能直接用的 Skill：手势词汇表、节拍规则、表情、机位、开头结构和禁止动作。

用 Agent 加视频模型做口播数字人时，最常见的问题是手乱比划、崩手、表情和内容对不上。只写「自然讲解、手势丰富」，模型就真的给你「丰富」。这个仓库做的事，是把真人博主的动作规律逐帧数出来，翻译成模型能执行的文字。

> English: A collection of Agent Skills that describe how top Chinese talking-head creators move on camera (gesture vocabulary, timing, framing, opening structure), so AI agents can write precise motion specs for digital-human videos. Only motion patterns are documented; no footage, likeness or transcripts are included.

## 一个共同规律

拆了五位博主之后，结论很统一：好看的口播手势跟多少无关。每个人都只用 3–7 个固定手势，手的活动范围固定在胸口到脸颊之间，动作都卡在台词重音上。数字人乱比划，缺的就是这三样：**词汇表、范围、节拍**。

## 已收录

| 博主 | 平台 | 风格类型 | 开头 20 秒真人全屏 | 数字人难度 | Skill |
|---|---|---|---|---|---|
| 秋芝2046 | [抖音](https://www.douyin.com/user/MS4wLjABAAAAwbbVuf1W2DdgRe0xCa0oxg1ZIHbzuiTzyjq3NcOVgBuu6qIidYlMYqbL3ZFY2swu) | 高能手势型 | 35%–50% | 高 | [talking-head-qiuzhi2046](skills/talking-head-qiuzhi2046/SKILL.md) |
| 李一帆 | [抖音](https://www.douyin.com/user/MS4wLjABAAAAyi85GGeS9GCLBpS4JAJ-r4Kz0cPVz-b0wIiYaeg_icU) | 表情主导型 | 25%–45% | 低 | [talking-head-li-yifan](skills/talking-head-li-yifan/SKILL.md) |
| 木子不写代码 | [抖音](https://www.douyin.com/user/MS4wLjABAAAAy_5W-LNi-cp7QbySyzEm3PskTDnDMUF34XijUKmZvywSej4Pm4UtLhQHiY_7Fryj) | 人物常驻型 | 约 95% | 中 | [talking-head-muzi](skills/talking-head-muzi/SKILL.md) |
| 小Lin说 | [抖音](https://www.douyin.com/user/MS4wLjABAAAAunpkE2IXyHAxm4A24G5d1Cf5141pnZy8HwNR5f2-6pI_GYBVR-Pv23uFyfMPB_9I) | 情绪造型手势型 | 20%–35% | 高 | [talking-head-xiaolin](skills/talking-head-xiaolin/SKILL.md) |
| 大师的AI小灶 | [抖音](https://www.douyin.com/user/MS4wLjABAAAAohe8JB4RvITJitJ69b7cV4NTaYTMYrVI43C-3SUnPPc) | 证据先行、真人插针型 | 15%–30% | 低 | [talking-head-dashi](skills/talking-head-dashi/SKILL.md) |

想拆一位新博主：用 [talking-head-analyzer](skills/talking-head-analyzer/SKILL.md)，里面有流程、抽帧脚本和 Skill 模板。

每条样本的链接、发布日期和采集时点赞数见 [`data/samples.csv`](data/samples.csv)。

## 怎么选

- **第一次做数字人，或参考图里手不在画面内**：李一帆（表情主导）或大师（证据先行）
- **要有活力的开场**：用李一帆或大师的机位，只借秋芝的 3–4 个标志手势（挥手、双食指、双拳）
- **长教程的目录式开场**：木子，开场 4 秒手势单独生成，列举段手出画，信息卡在剪辑层贴到人物两侧
- **财经、商业、讲故事**：借小Lin说的结构（素材冷开场 + 小窗配音 + 情绪句回全屏），手势只用单手侧掌

### 手势风险分档

| 档位 | 动作 | 例子 |
|---|---|---|
| 低 | 手不入画；单手从画面下沿低位抬起；只靠表情 | 李一帆、大师 |
| 中 | 双手对称地张开、外抛、捧框，手指不需要精确形状 | 木子的开场、秋芝的挥手 |
| 高 | 双食指、指尖捏合、五指张开特写、十指弯曲虚捧 | 秋芝的双食指、小Lin说的大部分手势 |

### 开头结构两大类

- **先人后证据**：人直接开口（秋芝、木子、小Lin说的年度片）
- **先证据后人**：成果或素材冷开场，人插针进来下判断（李一帆、大师、小Lin说的常规片）。对数字人更友好：第一帧就是成果，人物镜头短，切走的地方正好盖住生成接缝

## 安装

每个 `skills/<name>/` 都是一个独立的 Agent Skill，复制到你的 Agent 读取 Skill 的目录即可：

```bash
# Claude Code（个人级）
cp -r skills/talking-head-li-yifan ~/.claude/skills/

# 项目级（Claude Code / Codex 等读取 .claude/skills 或 .agents/skills 的 Agent）
cp -r skills/talking-head-li-yifan <你的项目>/.claude/skills/
```

然后对 Agent 说：「用李一帆风格，给这段台词写一份数字人动作说明书」，再把台词和参考图给它。

## 收录原则

- 只提炼动作节奏和结构，不收录博主的原视频、截图、长相或完整逐字稿
- 每条样本只记录公开链接和基本数据，原片请到原平台观看
- Skill 里的文字描述是给 Agent 用的。**不要把原视频当参考视频喂给生成模型**，否则对方的脸、衣服、背景可能串进成片
- 参考图只用自己或已获授权的形象；发布时按平台要求标注 AI 生成内容
- 本仓库与所列博主无合作关系。如果你是被收录的创作者，希望修改或移除，请提 issue

## 贡献

欢迎补充新的博主。按 [talking-head-analyzer](skills/talking-head-analyzer/SKILL.md) 的流程拆解，提交时附上 `skills/talking-head-<slug>/` 目录、`data/samples.csv` 的新增行和本 README 表格的新增行。

## License

MIT
