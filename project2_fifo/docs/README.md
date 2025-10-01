# project2_fifo

## Description
Short summary of this project (what it implements and why).

## Directory Structure
- `design/` — RTL sources and design spec (`design/project2_fifo_DESIGN_SPEC.md`)
- `verification/` — Testbenches, sim configs, reference models
- `docs/` — Documentation and verification plan
- `results/` — Simulation outputs (logs, waves) — usually gitignored

## Quickstart
### Xcelium (example)
```bash
cd project2_fifo/verification/sim
xrun -sv -f run.f -R +define+DUMP_VCD
```

### VCS (example)
```bash
cd project2_fifo/verification/sim
vcs -sverilog -f run.f -R +define+DUMP_VCD
```

## Links
- Design Spec: `design/project2_fifo_DESIGN_SPEC.md`
- Verification Plan: `docs/VERIFICATION_PLAN.md`
