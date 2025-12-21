# Grove Foundation Loop

A structured sprint planning methodology for software development that produces 8 planning artifacts, embeds automated testing, and enables clean handoff to execution agents.

## What It Does

The Foundation Loop transforms chaotic development into systematic sprints:

1. **Repository Audit** → Understand current state
2. **Specification** → Define goals and acceptance criteria
3. **Architecture** → Design target state
4. **Migration Map** → Plan file-by-file changes
5. **Decisions** → Document "why" with ADRs
6. **Stories** → Break into executable tasks
7. **Execution Prompt** → Create self-contained handoff
8. **Testing** → Validate critical paths
9. **Execution** → Track progress

## Quick Start

Initialize a new sprint:
```bash
node scripts/init-sprint.js my-feature-v1 --path ./docs/sprints
```

This creates all 8 artifact templates ready to fill in.

## Skill Structure

```
grove-foundation-loop-skill/
├── SKILL.md                    # Core methodology
├── references/
│   ├── templates.md            # All artifact templates
│   ├── testing-requirements.md # Test pyramid, requirements
│   ├── health-report.md        # Diagnostic system design
│   └── examples.md             # Real sprint examples
└── scripts/
    └── init-sprint.js          # Sprint initializer
```

## Key Principles

1. **Plan before coding** — Artifacts save more time than they cost
2. **Test critical paths** — Impact over coverage percentage
3. **Document decisions** — Future you will thank present you
4. **Health checks mandatory** — Human-readable status at all times
5. **Sprints are replayable** — EXECUTION_PROMPT is self-contained

## Using as a Claude Skill

This is designed as a skill for Claude. The SKILL.md file contains frontmatter that tells Claude when to use this methodology:

> Use when the user wants to plan a sprint, refactor code, add features, or execute any multi-phase development work.

## License

MIT
