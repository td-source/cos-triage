# Whiteboard Wash — Canonical Specification

**Author:** D Openclaw
**Captured:** May 17, 2026
**Status:** Authoritative spec for daily COS Window cleanup
**Owner:** D (4:55 AM daily run)
**Source:** `memory/cos-whiteboard-rules.md`, `MEMORY.md#L164`

---

## Purpose

Every day, the COS Window (00:00–02:00) on Tyler's Google Calendar accumulates real, often-unlabeled task events alongside the 8 canonical lane headers. The Whiteboard Wash is the daily ritual that:

1. Classifies and normalizes any unlabeled or malformed events
2. Moves all real (non-header) task events forward one day into the same COS Window slot
3. Leaves the previous day **header-only** and the new day with the carried-forward task stack
4. Verifies the result rather than assuming the script "ran"

The real job is not "did the script run." It is: **Is the board actually correct when Tyler looks at it?**

---

## The 8 Lanes (Source of Truth)

| Lane | Letter | Time Slot | Label | Emoji | Calendar |
|------|--------|-----------|-------|-------|----------|
| !1! | A | 00:00 | I Love God | 🙏🏽 | td@tylerrdow.com |
| !2! | B | 00:15 | I Love Others/Self | 💛 | td@tylerrdow.com |
| !3! | C | 00:30 | I Am Wise | 🦉 | td@tylerrdow.com |
| !4! | D | 00:45 | Org/Share | ✨ | c_5cc8be…@group |
| !5! | D1 | 01:00 | Solve | ✨🚀 | tyler@solve-technology.com |
| !6! | D2 | 01:15 | WET&DRy | ✨💧 | c_0bbc36…@group |
| !7! | D3 | 01:30 | ACRE Services | ✨⚖️ | c_ced359…@group |
| !8! | Bull | 01:45 | Bull Pin | 🐂 | c_68a9822…@group |

---

## Lane Inference Rules

When an event arrives unlabeled, infer its lane by **primary stewardship purpose**, not by keywords alone.

### Lane decision rules

**!1! A — God / consecration**
- Prayer
- Scripture
- Temple
- Church
- Spiritual commitments
- Repentance / covenant-centered actions

**!2! B — Relationships / people / family / self-care**
- Dana
- Children / grandchildren / parents
- Family connection
- Service to people
- Social follow-up
- Relational maintenance
- Personal care (when it protects !2!)

**!3! C — Wisdom / learning**
- Study
- Reading
- Courses
- Learning
- Reflection
- Skill-building
- Education / research for growth (not immediate delivery)

**!4! D — General organization / stewardship / admin**
- Organizing
- Finance
- Systems
- Admin
- Cleanup
- Planning
- Operations
- "Housekeeping" not tied to a specific venture

**!5! D1 — Solve**
- Solve work
- Clients
- Pipeline
- Proposals
- Revenue
- Nate / Spencer business execution
- Direct work tied to Solve Technology

**!6! D2 — WET&DRy**
- Water
- WET&DRy
- Utility / property systems
- Home systems
- Water Ledger / water-tech
- LEAP / DRY / Talking House / Artifact Vault type work
- Related venture items under WET&DRy stewardship

**!7! D3 — ACRE Service**
- ACRE Service
- Legal/service structure work
- Related professional service items

**!8! Bull — Bull Pin**
- Parked ideas
- Backlog
- Someday/maybe
- Real, but not active now

### Tie-breaker order

If an event could fit more than one lane, apply in order:

1. **Specific venture beats general admin.** Solve work → D1, not generic D.
2. **Relationship beats business.** If the main point is a person, → B.
3. **Spiritual beats everything else.** If covenant/spiritual is the core, → A.
4. **Parked/not active → Bull.** Even if conceptually elsewhere, if it's not active, park it.

### Examples

| Raw event | Inferred lane |
|---|---|
| "Call Dana about dinner" | !2! B |
| "Read conference talk" | !1! A (devotion) or !3! C (study) — depends on purpose |
| "Review Solve proposal" | !5! D1 |
| "Organize bank accounts" | !4! D |
| "Water Ledger follow-up" | !6! D2 |
| "ACRE service structure notes" | !7! D3 |
| "Idea for future app" | !8! Bull |

### Canonical title format

After classification, rewrite the title:

```
!2! B | 💛 Call Dana
!4! D | ✨ Clean up account structure
!5! D1 | ✨🚀 Follow up with client
```

---

## Daily Workflow — 12 Steps

### Step 1 — Auth gate

Before touching anything:
- Load Google credentials
- Refresh tokens if needed
- Verify read/write access to the Whiteboard calendars
- If auth is broken, **stop and report truthfully** — do not pretend success

### Step 2 — Pull source-day COS Window

Fetch all events in:
- Source day
- 00:00–02:00
- All Whiteboard lane calendars/containers needed

### Step 3 — Separate headers from tasks

For each event, decide:
- Is this a **recurring canonical lane header**? → keep in place
- Or is this a **non-header task event**? → candidate for cleanup + carryforward

### Step 4 — Audit every non-header task

For each task event, verify:
- Correct lane
- Correct slot time
- Correct calendar/container
- Correct lane number/prefix
- Correct emoji
- Correct summary/title syntax

### Step 5 — Classify unlabeled or malformed events

If unlabeled, mis-tagged, or ambiguous:
- Infer the lane (using rules above)
- Assign the proper lane
- Rename into canonical format

### Step 6 — Normalize placement

Move/fix the event to match the lane's fixed slot (per the lane table above).

### Step 7 — Preserve headers

- **Do not** delete the recurring lane headers
- **Do not** treat headers as carryforward tasks
- Repair header drift only if the header itself is malformed

### Step 8 — Carry forward real task items

For each non-header task:
- Move from source day to target day
- Keep: same lane, same slot, same calendar/container, same title/emoji/classification
- Only the **date/day** should change

**Critical implementation rule:**
- If the item stays in the same calendar/container, use **move/update**, NOT create/copy
- Do **not** clone same-calendar tasks into the next day
- Otherwise you get duplicate residue on the old day

### Step 9 — Re-fetch both days

After the moves:
- Fetch the **target day** again
- Fetch the **source day** again

**Do not trust that API success means reality is correct.**

### Step 10 — Run the completion gate

Compare exact non-header timed events:

- Every source task must now exist on target day
- No moved source task should remain on source day
- No recurring non-header residue should remain on source day if a next-day copy exists
- Source day should be **header-only** when finished

If any check fails:
- Do **not** report success
- Do **not** say "Whiteboard clean"
- Explicitly report what is missing or left behind

### Step 11 — Manual visual confirmation (when needed)

For recovery runs, screenshot-driven fixes, or audit-sensitive cleanups:
- Visually inspect the rendered Google Calendar view
- Confirm the live board matches the intended state

### Step 12 — Report outcome

Output one of two things:

**Either** a concise summary of:
- What was classified
- What was renamed
- What was moved
- What was cleaned
- What was blocked/failed

**Or** the literal string: `Whiteboard clean ✅`

Only say `Whiteboard clean ✅` if the completion gate actually passed.

---

## Pseudocode

```
WHITEBOARD_WASH():
    auth_ok = verify_auth_and_calendar_access()
    if not auth_ok:
        report("Blocked by auth")
        stop

    source_events = fetch_whiteboard_events(source_day, 00:00-02:00)

    headers = []
    tasks   = []
    for event in source_events:
        if is_canonical_header(event):
            headers.append(event)
        else:
            tasks.append(event)

    normalized_tasks = []
    for task in tasks:
        lane = infer_lane_if_needed(task)
        task = normalize_title_prefix_emoji(task, lane)
        task = move_to_correct_lane_slot_if_needed(task, lane)
        task = move_to_correct_calendar_if_needed(task, lane)
        normalized_tasks.append(task)

    for task in normalized_tasks:
        move_event_to_next_day_same_slot(task)  # update/move, not copy

    target_events        = fetch_whiteboard_events(target_day, 00:00-02:00)
    source_events_after  = fetch_whiteboard_events(source_day, 00:00-02:00)

    if not every_source_task_present_in_target(normalized_tasks, target_events):
        report_failure_with_missing_items()
        stop

    if any_non_header_tasks_remain_on_source(source_events_after):
        report_failure_with_leftover_items()
        stop

    if manual_or_visual_audit_needed:
        visually_confirm_rendered_calendar()

    if nothing_changed:
        report("Whiteboard clean ✅")
    else:
        report_cleanup_summary()
```

---

## Plain-English Operating Standard

Every morning the wash must:

- Label what is unlabeled
- Fix what is malformed
- Move every real task forward one day
- Leave only headers behind
- **Verify, not assume**

The real job is not "did the script run." It is: **Is the board actually correct when Tyler looks at it?**

---

## Relationship to COS Triage App

This spec lives next to the COS Triage app code but **is not yet implemented inside the app**. As of May 17, 2026:

- The Whiteboard Wash is owned and executed by **D** externally (4:55 AM daily run)
- COS Triage app reads from Google Calendar but does not run the wash
- Wave 4 candidate: bring wash execution into the app as a "Run Whiteboard Wash" button

Any agent or engineer modifying wash-adjacent logic in the app must read this spec first and confirm the change does not violate any of the 12 steps or the lane inference rules.
