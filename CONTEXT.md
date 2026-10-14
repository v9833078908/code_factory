# Code Factory

A personal AI development organization: agents with roles and a reporting line do the work, and the single human owner steers through each project's CTO, reviews increments, and approves only gated actions.

## Language

### People and roles

**Founder**:
The single human owner who sets goals, reviews increments, and approves gated actions.
_Avoid_: user, admin, board, operator

**Agent**:
A persistent role identity with its own instructions, runtime, and place in the reporting line; it outlives any single run.
_Avoid_: session, bot, chat

**CTO**:
The agent responsible for one project; the Founder talks to it instead of to the rest of the team, and it supervises that team.
_Avoid_: lead, manager, CTO session, orchestrator

**Executor**:
Any agent below the CTO that receives work and reports back.
_Avoid_: worker, subagent, developer session

**Architect**:
The executor that turns a goal into a written plan.

**Staff Engineer**:
The executor that reviews plans as a second opinion on a different model.

**Software Engineer**:
The executor that implements a plan in its own isolated workspace.

**Code Reviewer**:
The executor that reviews code changes.

**QA Engineer**:
The executor that checks a claimed result against evidence before it reaches the CTO.
_Avoid_: tester, verifier

**Release Engineer**:
The executor that merges and, after the Founder agrees, deploys and checks production.
_Avoid_: deployer, DevOps

**Research Analyst**:
The executor that researches, reads data, and writes reference documents.

### Work

**Company**:
An isolation boundary with its own agents, projects, and context, such as corporate work versus personal projects.
_Avoid_: org, workspace, tenant

**Project**:
A body of work inside a company, owned by one CTO.
_Avoid_: repo, product

**Task**:
A unit of work assigned to one agent; it can be split into child tasks.
_Avoid_: issue, ticket, card

**Run**:
One execution of an agent on a piece of work through a runtime; disposable but resumable.
_Avoid_: session, chat, heartbeat

**Runtime**:
The agent program that carries out a run, such as Claude Code, Codex, opencode, or Hermes.
_Avoid_: harness, provider, adapter

**Model**:
The language model a runtime calls; one runtime can be paired with different models.
_Avoid_: provider, engine, LLM

**Plan**:
A written breakdown of one goal into tasks, accepted by the CTO; finishing it yields an increment.
_Avoid_: spec, roadmap

**Increment**:
A reviewable change that the Founder can run and check on their own machine.
_Avoid_: PR, release, result

### Oversight

**Decision**:
A choice between real alternatives that affects architecture, scope, cost, or user-visible behavior, recorded with the alternatives, the reason, who decided, and whether it is reversible.
_Avoid_: note, log entry, comment

**Gate**:
An action an agent may not take without the Founder's explicit approval.
_Avoid_: checkpoint, approval step
