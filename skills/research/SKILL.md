---
name: research
description: Research and compare references or libraries.
disable-model-invocation: true
---

Research the given topic and compare options.

## Steps

### 1. Confirm the subject
- If the topic is clear, start immediately without asking
- If unclear, infer from the conversation and propose a focus ("Should I focus on X?")
- Never stop with an empty question like "What should I research?"

### 2. Pick candidates
- Select 2 to 4 main options
- Gather information from official docs, GitHub, npm, PyPI, and similar

### 3. Compare
Build a table on these criteria:

| Criterion | Meaning |
|-----------|---------|
| Fit | how well it meets the requirements |
| Maturity | release history, community size, stars |
| Maintenance | recent updates, issue response time |
| Learning curve | adoption difficulty |
| Ecosystem | plugins, integrations, documentation quality |
| Performance | benchmarks (if applicable) |

### 4. Recommend
- A recommendation based on the comparison
- Clear reasoning
- Trade-offs included

## Rules

- Compare on current information; exclude deprecated options
- Evidence over opinion
- Recommend in the context of the project of the user
