# quant-sql-engine

A SQL analytics and audit suite for a trade log: performance reports, a trade blotter, sector roll-ups, broker reconciliation and data-health checks, written in SQLite.

> **All data in this repo is mock data.** No real trades, accounts or broker statements are used.

## Project structure

```text
quant-sql-engine/
├── README.md
└── sql/
    ├── schema.sql        -- builds 3 tables and loads the mock data
    ├── analytics.sql     -- performance, blotter and sector reports
    ├── audit.sql         -- latest trades and broker reconciliation
    └── validation.sql    -- PASS/FAIL data health check
```

## Setup

1. Open DB Browser for SQLite and create a new, empty database.
2. Run `sql/schema.sql`. Expected: 26 trades, 6 assets, 6 broker positions.
3. Run `sql/validation.sql`. Every column should read `PASS`.
4. Run `sql/analytics.sql` and `sql/audit.sql` to produce the reports.

## Scripts

| File | What it delivers |
|---|---|
| `schema.sql` | `trade_logs`, `asset_master` and `broker_positions` with mock rows. Safe to re-run. |
| `analytics.sql` | Asset performance summary, per-asset trade blotter, sector summary. |
| `audit.sql` | Latest trade per asset, and a reconciliation of our positions against the broker. |
| `validation.sql` | Four tests: row count, join integrity, orphan trades, total net PnL. |

## Key results (mock data)

- **Winners:** between 7 and 21 January 2026, only NVDA (685.0) and SPY (285.0) had at least 5 trades and a positive net PnL after fees.
- **Best sector:** Technology led with 1,265.0 net PnL across 16 trades.
- **Reconciliation:** the broker statement disagrees with our books on two assets, SPY (difference of -10 shares) and MSFT (-5 shares). The other four match.

## Skills demonstrated

| Script | Skills |
|---|---|
| `analytics.sql` | Aggregation, `HAVING`, window functions (`ROW_NUMBER`, `LAG`), joins |
| `audit.sql` | CTEs, subqueries, `LEFT JOIN`, `COALESCE`, `CASE WHEN`, reconciliation logic |
| `validation.sql` | Scalar subqueries, `CASE WHEN`, join row-count and orphan checks |

## My learning journey

This is the Phase 1 capstone of a five-phase plan to become a fintech and quantitative data analyst. I built it with an AI tutor that sent me realistic requests written as a hedge fund CFO, one problem at a time, and reviewed every query I submitted. The capstone collects the work from four topics:

1. **Aggregations and `HAVING`.** My first query had the right idea but the clauses in the wrong order, and a `> 5` where the request said "at least 5". That quietly dropped NVDA from the result. Since then I read the wording of every filter before choosing the operator.
2. **Window functions.** Ranking and comparing trades within each stock (`PARTITION BY`, `LAG`, `LEAD`). The lesson was consistency: every window in a query needs the same partition and ordering, and rounding must wrap the whole calculation, not the pieces.
3. **CTEs and subqueries.** Breaking one opaque query into named steps. Nested parentheses were my hardest syntax problem. Reading the database's error message and fixing one error at a time fixed it.
4. **Joins and conditional aggregation.** I learned the difference between `INNER JOIN` and `LEFT JOIN` by watching a stock with no trades vanish from a report. For reconciliation I aggregate first, then join, so no row is counted twice.

What I took from it:

- A query that runs is not the same as a query that answers the question. The column names, order and rounding in the request are part of the answer.
- Every report needs a check. `validation.sql` exists because a join that silently duplicates rows produces wrong totals with no error.
- Debugging is a method, not a mood: run it, read the error, fix one thing, run it again.

Next up is Phase 2, moving the same data into Python with NumPy and Pandas in `quant-data-pipeline`.