# OpenSpec Template

Use this format for Phase 3 (SPECIFY) of SDD.

---

## OpenSpec: [Feature Name]

**Version:** 1.0
**Status:** Draft / Approved
**Author:** [user/claude]
**Date:** [YYYY-MM-DD]

---

### 1. Overview
One paragraph describing what this feature does and why it exists.

### 2. Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| FR-01 | [Must do X] | Must-have |
| FR-02 | [Must handle Y] | Must-have |
| FR-03 | [Should support Z] | Nice-to-have |

### 3. Non-Functional Requirements
- **Performance:** [e.g., list renders < 16ms per frame]
- **Security:** [e.g., all inputs sanitized, no PII in logs]
- **Accessibility:** [e.g., WCAG AA, screen reader support]
- **Compatibility:** [e.g., iOS 16+, Android 13+]

### 4. Data Model / API Contract

```typescript
// Types, interfaces, or API shapes
interface FeatureData {
  id: string
  // ...
}
```

### 5. Component / Module Breakdown

```
src/
  features/
    [feature-name]/
      index.ts          — public exports
      [Feature].tsx     — main component
      use[Feature].ts   — hook with business logic
      [feature].types.ts
      __tests__/
```

### 6. State & Data Flow
Describe how data flows: where it comes from, where it goes, how it's transformed.

### 7. Error States & Edge Cases

| Scenario | Expected Behavior |
|---|---|
| Network offline | Show cached data + offline indicator |
| Empty state | Show empty state component |
| API error | Show error with retry action |

### 8. Out of Scope
Explicit list of things this spec does NOT cover:
- [Thing A] — deferred to v2
- [Thing B] — handled by existing system

### 9. Acceptance Criteria
- [ ] FR-01 implemented and tested
- [ ] FR-02 implemented and tested
- [ ] Edge cases handled per section 7
- [ ] No TypeScript errors
- [ ] Tests passing

---
**Approved by:** _____________  **Date:** _____________
