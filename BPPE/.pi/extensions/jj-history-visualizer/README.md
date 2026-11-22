# jj history visualizer

Pi 项目本地插件：把当前仓库的 `jj log` 渲染成 CSS/HTML 时间线，并把生成时的本地 jj 输出保存为 ground truth。

## 使用

在 Pi 中执行：

```text
/jj-history
/jj-history 120
/jj-history --limit 200 --revset ancestors(@)
/jj-history --open
```

也注册了可被模型调用的工具：`jj_history_visualize`。

## 输出

生成文件位于仓库本地 `.pi/jj-history/`：

- `index.html`：可视化页面。
- `jj-history.css`：页面样式。
- `latest.json`：最近一次快照。
- `snapshots/*.json`：带时间戳的本地 ground-truth 快照。

页面左栏直接显示 `jj status` 和 `jj log --color never` 的原始输出；右栏 CSS timeline 只从同一快照里的结构化记录渲染。
