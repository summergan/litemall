---
name: user-story-intake
description: Turn raw requirements, PRDs, user stories, bug reports, or workshop prompts into a scoped, source-backed Story Card before acceptance criteria and test design.
---

# User Story Intake

## Purpose

Structure an informal request without inventing business behavior. Skip this
Skill when an approved Story Card or equivalent requirement already exists.

## Workflow

1. Read the supplied requirement and authoritative product sources.
2. Identify actor, trigger, goal, value, scope, impacted objects, and known
   business chain.
3. Record applicable risks from the feature rather than a fixed domain list.
4. Separate confirmed facts, assumptions, and open questions.
5. Stop when a missing rule would materially change intended behavior.

Read project test inventories only when they help identify an impacted feature;
do not derive requirements from tests.

## Output

```markdown
## Story Card
- story_id:
- title:
- actor:
- trigger:
- user_story: As a ..., I want ..., so that ...
- business_value:
- in_scope:
- out_of_scope:
- source_evidence:
- impacted_objects:
- risk_tags:
- assumptions:
- open_questions:

## Handoff
- next_skill: acceptance-criteria
```

A Story Card is ready only when its scope and source are clear enough to write
observable acceptance criteria without guessing hidden rules.
