# Paperclip for Code Factory: use, ignore, build

Synthesis of `paperclip-analysis.md` (commit 2c17d3ca, v0.3.1, 2026-10-14) against the Founder's requirements, `session-patterns-claude.md`, `rules-and-other-runtimes.md`, and `vps-and-hermes-facts.md`. Terms follow `CONTEXT.md`.

## Shape and health

- TypeScript monorepo, Node >= 24.11, Express + React + PostgreSQL (embedded real Postgres or external `DATABASE_URL`). MIT.
- About 1.35M source lines and 281 tables; about 25 tables form the core loop.
- About 150 commits per week, 61% by one author; about 3,060 open issues. Top bug themes: stalled/hung runs and recovery, Hermes adapter, memory leaks and OOM (open report of ~1.35 GB/h growth), embedded DB lifecycle, upgrade regressions.
- Peripheral features are clean at the schema level (leaf tables) but entangled in a few monolithic files (`issues.ts` 13.7k lines, `routes/issues.ts` >8k, `routes/agents.ts` >7.3k). Removing features means "leave off", not delete. Forking core is expensive; extending through plugins, external adapters, agent instructions, and REST is cheap.

## Use as-is (the core the Founder needs)

| Capability | Why it matters to the Founder |
|---|---|
| Task tree with atomic checkout, parent woken when children finish | Lead decomposes work and gets reports without the Founder routing between sessions |
| Per-agent runtime + model config (Claude Code, Codex, opencode, Hermes) | Model routing per role becomes configuration, not a memory note agents forget |
| Review/approval stages enforced by the server, executor excluded from reviewing itself | The plan -> review -> implement -> code review loop the Founder runs by hand today |
| Per-(agent, task) session resume + continuation summary | Replaces manual `/compact` and handoff docs |
| Queued comments with interrupt; transcripts viewable; continue by comment | Live steering and dropping into an executor's run (not a live terminal) |
| Crash/orphan recovery, opt-in task watchdog | Base for "nobody needs to be poked" |
| Attention inbox, decisions with options, Telegram Accept/Reject | Decisions come as options; one-tap confirmations |
| Per-company isolation | Corporate vs personal |
| Plugins, external adapters, MCP, REST, CLI, routines (cron) | Where the gaps get filled without forking |

## Ignore (leave off) and why

| Feature | Why it is not for the Founder |
|---|---|
| Paperclip Cloud, customer-success broker | Hosted multi-tenant product; the Founder self-hosts. Inert when unconfigured, entangled in code, so just leave it dormant |
| ClipHub marketplace, company templates/portability, onboarding wizard, CEO-first company seed | "Zero-human company" packaging. The Founder has a few projects and one lead each. Exception: the teams catalog can install CTO/QA/coder packs once |
| Pipelines + cases | CRM/content kanban, not the dev loop |
| Slack, Teams, Discord, iMessage, voice/phone, email channels | The Founder uses only Telegram |
| Invites, join requests, multi-human roles | Solo Founder |
| Skills store social features (stars, comments, public share) | Marketplace features; the skill registry itself is core and stays |
| Announcements, feedback export/telemetry | Product marketing and telemetry to the vendor |
| Dot runner, Grok bot, Browser Use, smoke lab | Hosted runners and harnesses unrelated to the Founder's runtimes |
| Fast responses, decision models, AI router/pools, provider billing import | Cost plumbing for the optional features above; the cost ledger itself stays |
| Native Paperclip Runner (Rust) | Experimental; it is where same-turn steering and evidence checks live, so revisit later, not in v1 |
| Agents hiring agents without approval (default on) | Risk, not just noise: matches the Founder's past cost incidents (65-agent run, ~3,400 calls in a night). Keep a fixed roster |

## Build (gaps against the Founder's requirements)

| Gap | Why | Likely route |
|---|---|---|
| Deploy/delete gate that actually holds | CLI agents run with permissions skipped (`claude_local` default, codex bypass, hermes `--yolo`); a raw `git push`, deploy, or `rm -rf` in an agent shell is not intercepted | Agents never hold prod credentials; deploy runs as a separate task with a Founder approval stage, executed by a gated tool or by the Founder |
| Default review policy | No company/project default; the lead must stamp stages on every subtask | Lead instructions first; small core/plugin change later |
| Evidence-enforced verifier | Server stores only a comment; it never checks evidence | Verifier agent + instructions now; hard gate is a few hundred lines in the stage-transition guard |
| Stalls wake the lead, hung runs get killed | Recovery escalates to the board (Founder); silent-run watchdog only informs; `timeoutSec=0` lets hung runs live forever except Codex | Per-agent timeouts + task watchdog per tree now; recovery-owner routing is a medium core change |
| Pushed plain-language status | Dashboard is counters; chat connectors are experimental (public webhook, one bot = one agent) | Notifier plugin on run/approval events, or routine-driven digest |
| Feed of significant decisions agents made | Activity log is complete but undifferentiated | Convention (lead writes decision records) or a small plugin |
| Merge orchestration for parallel executors | Worktrees exist (flags default off); no merge queue or conflict handling | Integrator agent with instructions |
| omp adapter | No omp support; `pi_local` is pi-mono, not oh-my-pi | External adapter plugin (~2.5k lines, copy of pi-local) after a headless test of omp |
| Small-VPS fit | Default 20 concurrent runs per agent, no memory ceiling, open leak/OOM reports | Lower concurrency, systemd `MemoryHigh`, external Postgres, measure before committing |
