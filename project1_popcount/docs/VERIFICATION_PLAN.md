# Verification Plan — project1_popcount

## 1. Objectives
- Prove functional correctness vs. spec
- Validate reset behavior and corner cases
- Achieve target code & functional coverage

## 2. Environment
- Self-checking testbench in `verification/tb/`
- Reference/golden model in `verification/ref/` (if applicable)
- Tool(s): (Xcelium/VCS/Verilator), versions

## 3. Stimulus Strategy
### Directed
- Enumerate canonical scenarios (edge cases, boundary values)
### Random/Constrained
- Seeded random tests with constraints
- Min/Max values, bursty traffic, back-to-back sequences

## 4. Checkers & Assertions
- End-to-end checks (DUT output == reference)
- SVA for protocol, reset, range, illegal conditions
- X/Z propagation checks

## 5. Coverage
- **Code**: line/branch/toggle
- **Functional**: covergroups for:
  - Input classes / corner bins
  - Output ranges/flags
  - Reset entry/exit, back-to-back cases

## 6. Pass/Exit Criteria
- 0 test failures across regression
- Functional coverage goals met (define target %)
- Code coverage goals met (define target %)
