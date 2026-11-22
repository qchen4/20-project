import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const OUT_DIR = join(".pi", "jj-history");
const SNAPSHOT_DIR = "snapshots";

interface ExecLike {
  stdout: string;
  stderr: string;
  code: number;
}

interface CommitRecord {
  commit: string;
  change: string;
  author: string;
  time: string;
  subject: string;
  bookmarks: string;
  tags: string;
  parents: string[];
  flags: string[];
}

interface Snapshot {
  generatedAt: string;
  cwd: string;
  jjRoot: string;
  revset: string;
  limit: number;
  commands: Record<string, string[]>;
  status: string;
  rawLog: string;
  records: CommitRecord[];
}

function parseCommandArgs(args: string): { limit: number; revset: string; open: boolean } {
  let text = args.trim();
  const open = /(?:^|\s)--open(?:\s|$)/.test(text);
  text = text.replace(/(?:^|\s)--open(?:\s|$)/g, " ").trim();

  let limit = 80;
  const limitMatch = text.match(/(?:^|\s)(?:--limit|-n)\s+(\d+)(?:\s|$)/);
  if (limitMatch) {
    limit = Math.max(1, Math.min(5000, Number(limitMatch[1])));
    text = text.replace(limitMatch[0], " ").trim();
  } else {
    const bareLimit = text.match(/^(\d+)(?:\s+|$)/);
    if (bareLimit) {
      limit = Math.max(1, Math.min(5000, Number(bareLimit[1])));
      text = text.slice(bareLimit[0].length).trim();
    }
  }

  const revsetMatch = text.match(/(?:^|\s)(?:--revset|-r)\s+(.+)$/);
  const revset = (revsetMatch?.[1] ?? text ?? "").trim() || "all()";
  return { limit, revset, open };
}

async function mustExec(
  pi: ExtensionAPI,
  command: string,
  args: string[],
  cwd: string,
  signal?: AbortSignal,
): Promise<string> {
  const result = (await pi.exec(command, args, {
    cwd,
    signal,
    timeout: 15000,
    maxBuffer: 64 * 1024 * 1024,
  })) as ExecLike;
  if (result.code !== 0) {
    const rendered = [
      `$ ${command} ${args.join(" ")}`,
      result.stdout.trim(),
      result.stderr.trim(),
    ].filter(Boolean).join("\n");
    throw new Error(rendered);
  }
  return result.stdout;
}

function parseRecords(text: string): CommitRecord[] {
  return text
    .split("\x1e")
    .map((record) => record.trim())
    .filter(Boolean)
    .map((record) => {
      const fields = record.split("\x1f");
      const flags = (fields[8] ?? "").trim().split(/\s+/).filter(Boolean);
      return {
        commit: fields[0] ?? "",
        change: fields[1] ?? "",
        author: fields[2] ?? "",
        time: fields[3] ?? "",
        subject: fields[4] ?? "",
        bookmarks: fields[5] ?? "",
        tags: fields[6] ?? "",
        parents: (fields[7] ?? "").split(",").map((x) => x.trim()).filter(Boolean),
        flags,
      };
    });
}

function escapeHtml(value: string): string {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

function jsonForScript(value: unknown): string {
  return JSON.stringify(value).replaceAll("</script", "<\\/script");
}

function renderHtml(snapshot: Snapshot, snapshotName: string): string {
  const cards = snapshot.records.map((record, index) => {
    const flagSet = new Set(record.flags);
    const classes = [
      "commit",
      flagSet.has("working-copy") ? "current" : "",
      flagSet.has("empty") ? "empty" : "",
      flagSet.has("conflict") ? "conflict" : "",
    ].filter(Boolean).join(" ");
    const subject = record.subject || "(no description set)";
    const badges = [
      flagSet.has("working-copy") ? '<span class="badge current">@ working copy</span>' : "",
      flagSet.has("empty") ? '<span class="badge empty">empty</span>' : "",
      flagSet.has("conflict") ? '<span class="badge conflict">conflict</span>' : "",
      record.bookmarks ? `<span class="badge bookmark">${escapeHtml(record.bookmarks)}</span>` : "",
      record.tags ? `<span class="badge">tag ${escapeHtml(record.tags)}</span>` : "",
    ].filter(Boolean).join("\n");
    const searchable = [record.commit, record.change, record.author, record.time, subject, record.bookmarks, record.tags, record.parents.join(" "), record.flags.join(" ")].join(" ").toLowerCase();
    return `
      <article class="${classes}" data-search="${escapeHtml(searchable)}">
        <div class="node">${flagSet.has("working-copy") ? "@" : "◆"}</div>
        <div>
          <p class="subject ${record.subject ? "" : "empty-desc"}">${escapeHtml(subject)}</p>
          <div class="commit-meta">
            <span class="badge">#${index + 1}</span>
            <span class="badge">commit ${escapeHtml(record.commit)}</span>
            <span class="badge">change ${escapeHtml(record.change)}</span>
            <span class="badge">${escapeHtml(record.author || "unknown")}</span>
            <span class="badge">${escapeHtml(record.time)}</span>
            ${badges}
          </div>
          <div class="parents">parents: ${record.parents.length ? record.parents.map(escapeHtml).join(", ") : "none"}</div>
        </div>
      </article>`;
  }).join("\n");

  return `<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jj history · ${escapeHtml(snapshot.jjRoot)}</title>
  <link rel="stylesheet" href="jj-history.css">
</head>
<body>
  <header>
    <h1>jj history visualizer</h1>
    <div class="meta">
      <span class="pill">root: ${escapeHtml(snapshot.jjRoot)}</span>
      <span class="pill">revset: ${escapeHtml(snapshot.revset)}</span>
      <span class="pill">limit: ${snapshot.limit}</span>
      <span class="pill">records: ${snapshot.records.length}</span>
      <span class="pill">snapshot: ${escapeHtml(snapshotName)}</span>
      <span class="pill">generated: ${escapeHtml(snapshot.generatedAt)}</span>
    </div>
    <div class="controls">
      <input id="search" type="search" placeholder="搜索 commit / change / 作者 / 描述 / bookmark...">
      <button id="toggle-status" type="button">切换 status</button>
      <button id="toggle-raw" type="button">切换 ground truth log</button>
    </div>
  </header>

  <main>
    <section class="panel" id="ground-truth">
      <h2>Ground truth：本地 jj 记录</h2>
      <p class="ground-truth-note">左侧内容直接来自本地命令输出并随 snapshot JSON 一起保存；右侧 CSS 卡片只按这些本地记录渲染。</p>
      <pre class="status-pre" id="status-pre">${escapeHtml(snapshot.status.trim() || "clean")}</pre>
      <pre class="raw-log" id="raw-log">${escapeHtml(snapshot.rawLog)}</pre>
    </section>

    <section class="panel">
      <h2>CSS timeline</h2>
      <div class="timeline" id="timeline">
        ${cards}
      </div>
    </section>
  </main>

  <footer>
    数据源命令：<code>${escapeHtml(Object.values(snapshot.commands).map((cmd) => cmd.join(" ")).join("; "))}</code>
  </footer>

  <script type="application/json" id="snapshot-data">${jsonForScript(snapshot)}</script>
  <script>
    const search = document.getElementById('search');
    const cards = [...document.querySelectorAll('.commit')];
    search.addEventListener('input', () => {
      const q = search.value.trim().toLowerCase();
      cards.forEach((card) => card.classList.toggle('hidden', q && !card.dataset.search.includes(q)));
    });
    document.getElementById('toggle-status').addEventListener('click', () => {
      const el = document.getElementById('status-pre');
      el.hidden = !el.hidden;
    });
    document.getElementById('toggle-raw').addEventListener('click', () => {
      const el = document.getElementById('raw-log');
      el.hidden = !el.hidden;
    });
  </script>
</body>
</html>
`;
}

async function maybeOpen(pi: ExtensionAPI, filePath: string, cwd: string, signal?: AbortSignal): Promise<void> {
  const url = pathToFileURL(filePath).href;
  if (process.platform === "win32") {
    await pi.exec("cmd.exe", ["/c", "start", "", url], { cwd, signal, timeout: 5000 });
  } else if (process.env.WSL_DISTRO_NAME) {
    await pi.exec("explorer.exe", [url], { cwd, signal, timeout: 5000 });
  } else if (process.platform === "darwin") {
    await pi.exec("open", [url], { cwd, signal, timeout: 5000 });
  } else {
    await pi.exec("xdg-open", [url], { cwd, signal, timeout: 5000 });
  }
}

async function buildHistory(
  pi: ExtensionAPI,
  cwd: string,
  opts: { limit: number; revset: string; open?: boolean; signal?: AbortSignal },
): Promise<{ htmlPath: string; snapshotPath: string; snapshot: Snapshot }> {
  const limit = Math.max(1, Math.min(5000, Math.floor(opts.limit || 80)));
  const revset = opts.revset || "all()";
  const outDir = join(cwd, OUT_DIR);
  const snapshotDir = join(outDir, SNAPSHOT_DIR);
  await mkdir(snapshotDir, { recursive: true });

  const jjRoot = (await mustExec(pi, "jj", ["root"], cwd, opts.signal)).trim();
  const statusArgs = ["status", "--no-pager"];
  const rawLogArgs = ["log", "--no-pager", "--color", "never", "-r", revset, "--limit", String(limit)];
  const recordTemplate = [
    'commit_id.short(12)', '"\\x1f"',
    'change_id.short(12)', '"\\x1f"',
    'author.name()', '"\\x1f"',
    'author.timestamp().format("%Y-%m-%d %H:%M:%S %Z")', '"\\x1f"',
    'description.first_line()', '"\\x1f"',
    'bookmarks', '"\\x1f"',
    'tags', '"\\x1f"',
    'parents.map(|c| c.commit_id().short(12)).join(",")', '"\\x1f"',
    'if(current_working_copy, "working-copy", "")',
    'if(empty, " empty", "")',
    'if(conflict, " conflict", "")',
    '"\\x1e"',
  ].join(" ++ ");
  const recordArgs = ["log", "-G", "--no-pager", "--color", "never", "-r", revset, "--limit", String(limit), "-T", recordTemplate];

  const [status, rawLog, structured] = await Promise.all([
    mustExec(pi, "jj", statusArgs, cwd, opts.signal),
    mustExec(pi, "jj", rawLogArgs, cwd, opts.signal),
    mustExec(pi, "jj", recordArgs, cwd, opts.signal),
  ]);

  const snapshot: Snapshot = {
    generatedAt: new Date().toISOString(),
    cwd,
    jjRoot,
    revset,
    limit,
    commands: {
      status: ["jj", ...statusArgs],
      rawLog: ["jj", ...rawLogArgs],
      records: ["jj", ...recordArgs],
    },
    status,
    rawLog,
    records: parseRecords(structured),
  };

  const stamp = snapshot.generatedAt.replace(/[:.]/g, "-");
  const snapshotName = `${stamp}.json`;
  const snapshotPath = join(snapshotDir, snapshotName);
  const htmlPath = join(outDir, "index.html");
  const css = await readFile(join(here, "jj-history.css"), "utf8");

  await Promise.all([
    writeFile(snapshotPath, JSON.stringify(snapshot, null, 2), "utf8"),
    writeFile(join(outDir, "latest.json"), JSON.stringify(snapshot, null, 2), "utf8"),
    writeFile(join(outDir, "jj-history.css"), css, "utf8"),
    writeFile(htmlPath, renderHtml(snapshot, snapshotName), "utf8"),
  ]);

  if (opts.open) {
    await maybeOpen(pi, htmlPath, cwd, opts.signal);
  }

  return { htmlPath, snapshotPath, snapshot };
}

export default function (pi: ExtensionAPI) {
  pi.registerCommand("jj-history", {
    description: "生成当前 jj 历史的本地 CSS 可视化（数据以本地 snapshot 为 ground truth）",
    handler: async (args, ctx) => {
      try {
        const opts = parseCommandArgs(args ?? "");
        const result = await buildHistory(pi, ctx.cwd, { ...opts, signal: ctx.signal });
        ctx.ui.notify(
          `jj history 已生成：${result.htmlPath}（${result.snapshot.records.length} 条，ground truth: ${result.snapshotPath}）`,
          "info",
        );
        ctx.ui.setWidget("jj-history", [
          `jj history: ${result.snapshot.records.length} records`,
          `HTML: ${result.htmlPath}`,
          `Ground truth: ${result.snapshotPath}`,
        ], { placement: "belowEditor" });
      } catch (error) {
        ctx.ui.notify(`jj-history 失败：${error instanceof Error ? error.message : String(error)}`, "error");
      }
    },
  });

  pi.registerTool({
    name: "jj_history_visualize",
    label: "Visualize jj history",
    description: "Generate a local CSS/HTML visualization of the current jj history and save raw local jj records as ground truth.",
    parameters: Type.Object({
      revset: Type.Optional(Type.String({ description: "jj revset to render, default all()" })),
      limit: Type.Optional(Type.Number({ description: "maximum revisions to render, default 80" })),
      open: Type.Optional(Type.Boolean({ description: "open the generated HTML in the system browser" })),
    }),
    async execute(_toolCallId, params, signal, _onUpdate, ctx) {
      const result = await buildHistory(pi, ctx.cwd, {
        revset: params.revset ?? "all()",
        limit: params.limit ?? 80,
        open: params.open ?? false,
        signal,
      });
      return {
        content: [{
          type: "text",
          text: [
            `Generated jj history visualization: ${result.htmlPath}`,
            `Ground truth snapshot: ${result.snapshotPath}`,
            `Records: ${result.snapshot.records.length}`,
          ].join("\n"),
        }],
        details: {
          htmlPath: result.htmlPath,
          snapshotPath: result.snapshotPath,
          records: result.snapshot.records.length,
          revset: result.snapshot.revset,
          limit: result.snapshot.limit,
        },
      };
    },
  });
}
