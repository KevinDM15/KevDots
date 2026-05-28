---
name: sdd
description: Spec-Driven Development workflow. Use when the user wants to implement a new feature, component, or system with a structured explore→propose→specify→design→implement chain. Prevents "ask and pray" coding by requiring an approved spec before any code is written.
---

# Spec-Driven Development (SDD)

A 5-phase chain that ensures high-quality code through rigorous specification before implementation.

## When to use
- Any new feature that touches more than 2 files
- New screens, components with complex state, or API integrations
- Any time the user says "build X" without prior exploration
- When the user explicitly requests spec-driven mode

## The 5 Phases

### Phase 1: EXPLORE
**Goal:** Understand the codebase before proposing anything.

Use the `Explore` subagent:
```
- Read relevant existing code (similar features, shared utilities, types)
- Identify constraints: existing patterns, naming conventions, dependencies
- Map the affected surface area (files that will change)
- Note any gotchas or non-obvious dependencies
```

Output: A concise exploration report (what exists, what's relevant, what to watch out for).

### Phase 2: PROPOSE
**Goal:** Present 2–3 implementation approaches with tradeoffs.

```
For each option:
- Name: [short label]
- Approach: [1–2 sentences]
- Pros: [bullet list]
- Cons: [bullet list]
- Complexity: Low / Medium / High
- Recommended: Yes/No + reason
```

**Do not proceed without user selecting an approach.**

### Phase 3: SPECIFY (OpenSpec)
**Goal:** Write a precise, unambiguous spec for the selected approach.

Use the OpenSpec format — see `references/openspec-template.md`.

Cover:
- Functional requirements (what it must do)
- Non-functional requirements (performance, security, UX)
- Data model / API contracts
- Edge cases and error handling
- Out of scope (explicit)

**Do not proceed without user approving the spec.**

### Phase 4: DESIGN
**Goal:** Translate spec into a concrete implementation plan.

```
- File-by-file breakdown of changes
- New files to create
- Interfaces/types to define first
- Implementation order (dependencies first)
- Testing strategy
```

User reviews and approves. Then — and only then — implement.

### Phase 5: IMPLEMENT
**Goal:** Code exactly what was specified. No scope creep.

Rules:
- Follow the spec. If reality diverges, pause and flag it.
- If a decision not covered by the spec arises, stop and ask.
- Mark each spec item as done in real-time.
- Final check: does the implementation match the spec 1:1?

## Triggering SDD
User says any of:
- "build X" / "implement X" / "create X" (for non-trivial features)
- "spec-driven" / "/sdd"
- "explorar antes de implementar"
