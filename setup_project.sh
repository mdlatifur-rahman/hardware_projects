#!/usr/bin/env bash
# =======================================================
# Script: setup_project.sh
# Purpose: Create a SystemVerilog design+verification
#          folder tree for a new project, with Markdown templates
# Usage:   ./setup_project.sh <project_name>
# Example: ./setup_project.sh project2_fifo
# =======================================================

set -e

# -------- Check input --------
if [ -z "$1" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

PROJECT=$1

# -------- Make directories --------
echo "Creating project structure for: $PROJECT"

mkdir -p "$PROJECT/design"
mkdir -p "$PROJECT/verification/tb"
mkdir -p "$PROJECT/verification/sim"
mkdir -p "$PROJECT/verification/ref"
mkdir -p "$PROJECT/docs"
mkdir -p "$PROJECT/scripts"
mkdir -p "$PROJECT/results/logs"
mkdir -p "$PROJECT/results/waves"

# -------- Placeholders you wanted to keep --------
touch "$PROJECT/design/${PROJECT}.sv"
touch "$PROJECT/verification/tb/tb_${PROJECT}.sv"
touch "$PROJECT/verification/sim/run.f"
touch "$PROJECT/scripts/format.sh"
touch "$PROJECT/Makefile"
touch "$PROJECT/.gitignore"

# -------- Auto-populated Markdown templates --------

# Design spec (under design/)
cat > "$PROJECT/design/${PROJECT}_DESIGN_SPEC.md" <<EOF
# ${PROJECT} — Design Specification

## 1. Overview
Briefly describe what this module/design does, the problem it solves, and the performance/area/power goals.

## 2. Interface Specification
| Signal | Dir | Width | Reset | Description |
|--------|-----|-------|-------|-------------|
| clk    |  I  | 1     | —     | Rising-edge system clock |
| rst_n  |  I  | 1     | 0     | **Active-low synchronous** reset |
| ...    |     |       |       | (add interface signals here) |

### Timing
- Throughput: (items/cycle)
- Latency: (cycles)
- Reset behavior: (what values, for how long)
- Back-pressure/handshake: (ready/valid/etc., if any)

## 3. Functional Description
- Cycle-accurate behavior (what happens on each clock)
- Edge cases (all-zeros, all-ones, empty frames, back-to-back requests, etc.)
- Error handling / illegal inputs

## 4. Micro-Architecture
- Block-level diagram and short description (datapath, control, FIFOs, arbiters)
- Pipelining stages and cut points
- Clock/reset domain notes (CDC if present)
- Power/clock gating strategy (if any)

## 5. Parameters & Configuration
| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| WIDTH     | 32      |       | Example parameter; remove/rename |

## 6. Implementation Notes
- Synthesis hints (RAM/ROM inference, DSP usage, keep attributes)
- Coding style constraints (no latches, blocking vs non-blocking rules)
- Tool/version assumptions

## 7. Performance Targets
- Fmax target(s) on (tech/fpga)
- Area guidance (e.g., LUTs/FFs/BRAMs/DSPs) if known
- Power expectations or budgets (if applicable)

## 8. Verification Hooks
- Assertions (SVA) to include
- Reference model / scoreboard expectations
- Coverage points to expose

## 9. Known Limitations & TODOs
- What is not supported (by design)
- Future improvements

## 10. References
- Protocol specs, papers, tickets, or related repos
EOF

# Project README (under docs/)
cat > "$PROJECT/docs/README.md" <<EOF
# ${PROJECT}

## Description
Short summary of this project (what it implements and why).

## Directory Structure
- \`design/\` — RTL sources and design spec (\`design/${PROJECT}_DESIGN_SPEC.md\`)
- \`verification/\` — Testbenches, sim configs, reference models
- \`docs/\` — Documentation and verification plan
- \`results/\` — Simulation outputs (logs, waves) — usually gitignored

## Quickstart
### Xcelium (example)
\`\`\`bash
cd $PROJECT/verification/sim
xrun -sv -f run.f -R +define+DUMP_VCD
\`\`\`

### VCS (example)
\`\`\`bash
cd $PROJECT/verification/sim
vcs -sverilog -f run.f -R +define+DUMP_VCD
\`\`\`

## Links
- Design Spec: \`design/${PROJECT}_DESIGN_SPEC.md\`
- Verification Plan: \`docs/VERIFICATION_PLAN.md\`
EOF

# Verification plan (under docs/)
cat > "$PROJECT/docs/VERIFICATION_PLAN.md" <<EOF
# Verification Plan — ${PROJECT}

## 1. Objectives
- Prove functional correctness vs. spec
- Validate reset behavior and corner cases
- Achieve target code & functional coverage

## 2. Environment
- Self-checking testbench in \`verification/tb/\`
- Reference/golden model in \`verification/ref/\` (if applicable)
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
EOF

# Reference area README (under verification/ref/)
cat > "$PROJECT/verification/ref/README.md" <<EOF
# Reference Models — ${PROJECT}

Place high-level golden models here (SV/Python/C++).
Document interfaces, assumptions, and known deltas vs RTL.
EOF

# -------- Confirmation --------
echo "✅ Project '$PROJECT' created successfully!"
echo "Tree:"
tree "$PROJECT" || ls -R "$PROJECT"
