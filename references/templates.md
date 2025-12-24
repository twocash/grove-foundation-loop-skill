# Artifact Templates

## REPO_AUDIT.md Template

```markdown
# Repository Audit — {Sprint Name}

## Audit Date: {YYYY-MM-DD}

## Current State Summary
{Brief description of what exists today and why this sprint is needed}

## File Structure Analysis

### Key Files
| File | Purpose | Lines |
|------|---------|-------|
| {path} | {purpose} | {count} |

### Dependencies
{List relevant dependencies and versions}

## Architecture Assessment

### DEX Compliance
| Area | Status | Notes |
|------|--------|-------|
| Declarative config | ✅/⚠️/❌ | {what's in config vs hardcoded} |
| Capability agnostic | ✅/⚠️/❌ | {engine vs domain logic} |
| Single source of truth | ✅/⚠️/❌ | {duplicated definitions?} |

### Violations Found
{List any hardcoded handlers, conditionals, or non-declarative patterns}

## Test Coverage Assessment

### Current Test State
| Category | Files | Tests | Coverage |
|----------|-------|-------|----------|
| Unit | {count} | {count} | {areas covered} |
| Integration | {count} | {count} | {areas covered} |
| E2E | {count} | {count} | {areas covered} |

### Test Quality
- [ ] Tests verify behavior (not implementation)
- [ ] Tests use semantic queries
- [ ] Tests report to Health system

### Test Gaps
{What's not tested that should be}

## Technical Debt
{What needs fixing, what patterns are problematic}

## Risk Assessment
| Area | Current Risk | Notes |
|------|--------------|-------|
| {area} | High/Medium/Low | {explanation} |

## Recommendations
1. {Recommendation 1}
2. {Recommendation 2}
```

---

## SPEC.md Template

```markdown
# Specification — {Sprint Name}

## Overview
{One paragraph summary of what this sprint accomplishes}

## Goals
1. {Primary goal}
2. {Secondary goal}

## Non-Goals
- {What we're explicitly NOT doing}
- {Scope boundary}

## Success Criteria
After this sprint:
1. {Measurable outcome 1}
2. {Measurable outcome 2}

## Acceptance Criteria

### Functional Requirements
- [ ] AC-1: {Specific, testable criterion}
- [ ] AC-2: {Another criterion}

### Test Requirements (MANDATORY)
- [ ] AC-T1: E2E tests verify user-visible behavior
- [ ] AC-T2: Tests use behavior assertions (`toBeVisible()`, `toBeEnabled()`)
- [ ] AC-T3: No implementation-detail tests (`toHaveClass()`, state checks)
- [ ] AC-T4: All tests pass: `npm test && npx playwright test`
- [ ] AC-T5: Health check passes: `npm run health`

### DEX Compliance
- [ ] AC-D1: New behavior defined in config, not hardcoded
- [ ] AC-D2: No new `handle*` callbacks for domain logic
- [ ] AC-D3: Non-technical user can modify behavior via config

## Dependencies
| Package | Purpose | Version |
|---------|---------|---------|
| {name} | {why needed} | {version} |

## Risks
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| {risk} | High/Med/Low | High/Med/Low | {mitigation} |

## Out of Scope
- {Explicit exclusion 1}
- {Explicit exclusion 2}
```

---

## ARCHITECTURE.md Template

```markdown
# Architecture — {Sprint Name}

## Overview
{High-level description of the target architecture}

## System Diagram
```
{ASCII diagram showing components and data flow}
```

## DEX Stack Design

### Configuration Layer
{What behavior is defined in config}

```json
// Example config structure
{
  "feature": {
    "behavior": "defined here, not in code"
  }
}
```

### Engine Layer
{What interprets the config}

### Behavior Layer
{What users experience}

## Data Structures

### {Entity Name}
```typescript
interface EntityName {
  id: string;
  // fields with types and comments
}
```

## File Organization
```
{directory structure showing new/modified files}
```

## Test Architecture

### Test Categories
| Category | Location | Purpose |
|----------|----------|---------|
| Unit | `tests/unit/` | Pure logic validation |
| Integration | `tests/integration/` | API contracts |
| E2E | `tests/e2e/` | User behavior |

### Behavior Tests Needed
| User Action | Expected Outcome | Test File |
|-------------|------------------|-----------|
| {action} | {outcome} | {file.spec.ts} |

### Health Integration
{How tests report to Health system}

## API Contracts

### {Endpoint Name}
- **Method:** GET/POST/PUT/DELETE
- **Path:** /api/{path}
- **Request:** {shape}
- **Response:** {shape}

## Configuration
{Any configuration files or environment variables}

## Integration Points
{How this integrates with existing systems}
```

---

## MIGRATION_MAP.md Template

```markdown
# Migration Map — {Sprint Name}

## Overview
{Summary of what's being migrated/changed}

## Files to Create

### `{path/to/file.ts}`
**Purpose:** {what this file does}
**Depends on:** {other files that must exist first}
**Tests:** {what tests verify this file}
**Content summary:** {brief description}

---

## Files to Modify

### `{path/to/existing.ts}`
**Lines:** {start}-{end}
**Change Type:** Add/Modify/Remove
**Before:**
```typescript
{current code}
```
**After:**
```typescript
{new code}
```
**Reason:** {why this change}
**Tests:** {what tests verify this change}

---

## Files to Delete
- `{path}` — {reason for deletion}

---

## Test Changes

### Tests to Create
| Test File | Tests | Verifies |
|-----------|-------|----------|
| {file.spec.ts} | {test names} | {behavior verified} |

### Tests to Update
| Test File | Change | Reason |
|-----------|--------|--------|
| {file.spec.ts} | {change} | {reason} |

### Tests to Deprecate
| Test File | Reason | Action |
|-----------|--------|--------|
| {file.spec.ts} | {reason} | Move to deprecated/, skip |

---

## Execution Order
1. {First step}
2. {Verify: test command}
3. {Second step}
4. {Verify: test command}
5. {Continue...}

## Build Gates
After each phase:
```bash
npm run build
npm test
npx playwright test
npm run health
```

## Rollback Plan

### If {specific failure}:
1. {Recovery step}
2. {Verification}

### Full rollback:
```bash
{commands to undo all changes}
```

## Verification Checklist
- [ ] All tests pass
- [ ] Health check passes
- [ ] No regressions in existing behavior
```

---

## DECISIONS.md Template

```markdown
# Architectural Decision Records — {Sprint Name}

## ADR-001: {Decision Title}

### Status
Accepted | Proposed | Deprecated | Superseded by ADR-XXX

### Context
{Why we need to make this decision. What forces are at play.}

### Options Considered
1. **{Option A}** — {brief description}
2. **{Option B}** — {brief description}
3. **{Option C}** — {brief description}

### Decision
{What we decided to do}

### Rationale
{Why we chose this option over the alternatives}

### Consequences

**Positive:**
- {Benefit 1}
- {Benefit 2}

**Negative:**
- {Tradeoff 1}
- {Tradeoff 2}

**Neutral:**
- {Side effect}

---

## ADR-XXX: Testing Strategy (REQUIRED)

### Status
Accepted

### Context
Every sprint needs a testing strategy that verifies behavior without coupling to implementation.

### Decision
{Testing approach for this sprint}

### Test Categories
| Category | Tests | Purpose |
|----------|-------|---------|
| E2E | {count} | Behavior verification |
| Integration | {count} | API contracts |
| Unit | {count} | Logic validation |

### Behavior Test Principles
- Test user-visible outcomes
- Use semantic queries (`getByRole`, `getByText`)
- Avoid implementation assertions (`toHaveClass`, state checks)
- Tests report to Health system

---

## ADR-XXX: DEX Compliance (REQUIRED for Grove)

### Status
Accepted

### Context
Grove follows declarative architecture; new features must not introduce hardcoded behavior.

### Decision
{How this sprint maintains declarative patterns}

### Compliance Checklist
- [ ] No new `handle*` callbacks for domain logic
- [ ] Behavior defined in config, not code
- [ ] Engine interprets config at runtime
- [ ] Non-developer can modify behavior
```

---

## SPRINTS.md Template

```markdown
# Sprint Stories — {Sprint Name}

## Epic 1: {Epic Name} (Priority: Critical/High/Medium/Low)

### Story 1.1: {Story Title}
**Task:** {What to do}
**File:** {path/to/file} or Create `{path}`
**Tests:**
- Behavior test: `tests/e2e/{file}.spec.ts`
- Verify: `npx playwright test -g '{test name}'`
**Acceptance:** {How to verify completion}
**Commit:** `{type}: {message}`

### Story 1.2: Write tests for {feature}
**Task:** Add behavior-focused E2E tests
**File:** Create `tests/e2e/{feature}.spec.ts`
**Test Checklist:**
- [ ] Test user-visible behavior, not implementation
- [ ] Use `toBeVisible()`, `toBeEnabled()`, `getByRole()`
- [ ] Avoid `toHaveClass()`, internal state checks
**Commit:** `test: add {feature} behavior tests`

### Build Gate (Epic 1)
```bash
npm run build
npm test
npx playwright test tests/e2e/{feature}.spec.ts
npm run health
```

---

## Epic 2: {Next Epic}
{Repeat format with test requirements}

---

## Commit Sequence
```
1. {type}: {message}
2. test: {test message}
3. {type}: {message}
...
```

## Build Gates Summary
| After | Command | Expected |
|-------|---------|----------|
| Epic 1 | `npx playwright test {feature}` | X tests pass |
| Epic 2 | `npx playwright test {feature}` | Y tests pass |
| Final | `npm run test:all && npm run health` | All pass |

## Smoke Test Checklist
- [ ] {Manual verification 1}
- [ ] {Manual verification 2}
- [ ] All tests pass: `npm run test:all`
- [ ] Health check passes: `npm run health`
```

---

## EXECUTION_PROMPT.md Template

```markdown
# Execution Prompt — {Sprint Name}

## Context
{Why this sprint exists, what problem it solves}

## Documentation
Sprint documentation in `docs/sprints/{sprint-name}/`:
- `REPO_AUDIT.md` — {one-line summary}
- `SPEC.md` — {one-line summary}
- `ARCHITECTURE.md` — {one-line summary}
- `MIGRATION_MAP.md` — {one-line summary}
- `DECISIONS.md` — {one-line summary}
- `SPRINTS.md` — {one-line summary}

## Repository Intelligence
Key locations:
- {Important file 1}: `{path}` (lines {X}-{Y})
- {Important file 2}: `{path}`

## DEX Compliance Rules
- NO new `handle*` callbacks for domain logic
- Behavior in config, engine interprets
- Test behavior, not implementation

## Execution Order

### Phase 1: {Phase Name}
```bash
{commands}
```

{Code samples if helpful}

**Verify:**
```bash
npm test
npx playwright test -g '{relevant tests}'
```

### Phase 2: {Next Phase}
{Repeat format}

---

## Test Verification

### After Each Phase
```bash
npm run build
npm test
npx playwright test
npm run health
```

### Test Requirements
- Tests verify user-visible behavior
- Use `toBeVisible()`, not `toHaveClass()`
- Tests report to Health system (if configured)

## Success Criteria
- [ ] {Criterion 1}
- [ ] {Criterion 2}
- [ ] All tests pass: `npm run test:all`
- [ ] Health check: `npm run health`
- [ ] No new hardcoded handlers

## Forbidden Actions
- Do NOT add `handle*` callbacks for domain behavior
- Do NOT test implementation details (CSS classes, state shape)
- Do NOT hardcode conditionals (`if type === 'foo'`)
- Do NOT {other thing to avoid}

## Troubleshooting

### If tests fail
1. Check test is behavior-focused
2. Verify no implementation coupling
3. Run `npx playwright test --debug`

### If health check fails
1. Run `npm run health` for details
2. Check referenced tests pass
3. Verify data integrity
```

---

## DEVLOG.md Template

```markdown
# Dev Log — {Sprint Name}

## Sprint: {sprint-name}
## Started: {YYYY-MM-DD}
## Status: {Planning | In Progress | Complete | Blocked}

---

## Session Log

### Session 1: {Date} — {Focus Area}

**Completed:**
- [x] {Task 1}
- [x] {Task 2}

**Tests:**
- [x] Added: `tests/e2e/{test}.spec.ts`
- [x] Passing: X tests

**Blocked:**
- {Blocker description}

**Next:**
- {Next task}

---

## Test Results

### E2E Tests
| File | Tests | Passing | Notes |
|------|-------|---------|-------|
| {file.spec.ts} | {count} | {count} | {notes} |

### Health Check
```
{Health check output}
```

---

## Execution Log

### Phase 1: {Phase Name}
- [ ] {Step 1}
- [ ] {Step 2}
- [ ] Verified: `{command}` ✅

### Phase 2: {Phase Name}
{Repeat}

---

## Issues Encountered

### Issue 1: {Title}
**Symptom:** {What happened}
**Cause:** {Root cause}
**Resolution:** {How it was fixed}
**Test Added:** {Test to prevent recurrence}

---

## Final Checklist
- [ ] All acceptance criteria met
- [ ] Tests verify behavior, not implementation
- [ ] All tests pass: `npm run test:all`
- [ ] Health check passes: `npm run health`
- [ ] No new hardcoded handlers
- [ ] Documentation updated
- [ ] Ready for deploy
```
