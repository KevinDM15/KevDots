---
name: orchestrator
description: Orchestrator pattern for complex multi-step tasks. Divide & conquer using subagents with clean context windows. Use when a task requires multiple independent investigations or implementations that would saturate a single context window.
---

# Orchestrator Pattern

## Core Principle
The orchestrator **coordinates and delegates** — it never drowns in implementation details. Each subagent gets a clean context, a focused task, and returns a precise summary.

## When to Orchestrate
- Task requires reading 5+ unrelated files
- Multiple independent investigations needed simultaneously
- Long-running task that would fill the context window
- Codebase exploration before implementation

## Subagent Types Available

| Type | Use for |
|---|---|
| `Explore` | Quick codebase search, find files, grep patterns |
| `general-purpose` | Multi-step research, complex investigations |
| `Plan` | Architecture design, implementation planning |

## Orchestration Template

```
Task: [high-level goal]

Subtasks (run in parallel where independent):
1. [Subagent A] — Explore: Find all files related to X
2. [Subagent B] — Explore: Understand how Y works
3. [Subagent C] — general-purpose: Research approach for Z

After all complete:
- Synthesize findings
- Present to user
- Proceed to implementation (or SDD spec)
```

## Parallel vs Sequential

**Parallel** (independent work):
- Exploring different parts of the codebase
- Running tests while reading docs
- Multiple grep searches

**Sequential** (dependent work):
- Explore → then Plan → then Implement
- Read file → then Edit file

## Clean Context Rules
1. Each subagent prompt is self-contained — include all necessary context
2. Subagents return summaries, not raw file dumps
3. Orchestrator synthesizes — never re-reads what subagents already covered
4. If a subagent's work reveals a blocker, pause and surface to user

## Anti-Patterns to Avoid
- Giving one subagent all the files to read (defeats the purpose)
- Running subagents sequentially when they're independent
- Having the orchestrator also do implementation work
- Deep-nesting orchestrators (max 2 levels: orchestrator → subagent)
