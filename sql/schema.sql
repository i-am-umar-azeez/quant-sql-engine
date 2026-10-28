-- trade_logs: one row per trade. MOCK DATA ONLY.
DROP TABLE IF EXISTS trade_logs;
 
CREATE TABLE trade_logs (
    trade_id      INTEGER PRIMARY KEY,
    trade_date    TEXT    NOT NULL,
    asset         TEXT    NOT NULL,
    side          TEXT    NOT NULL CHECK (side IN ('BUY','SELL')),
    quantity      INTEGER NOT NULL CHECK (quantity > 0),
    price         REAL    NOT NULL CHECK (price > 0),
    fee           REAL    NOT NULL DEFAULT 0,
    strategy      TEXT    NOT NULL,
    realized_pnl  REAL    NOT NULL DEFAULT 0
);
 
INSERT INTO trade_logs
    (trade_id, trade_date, asset, side, quantity, price, fee, strategy, realized_pnl)
VALUES
    (1,  '2026-01-05', 'AAPL', 'BUY',  100, 185.20, 1.00, 'TREND',    0.00),
    (2,  '2026-01-05', 'MSFT', 'BUY',   50, 402.10, 1.00, 'TREND',    0.00),
    (3,  '2026-01-06', 'NVDA', 'BUY',   40, 540.30, 1.00, 'BREAKOUT', 0.00),
    (4,  '2026-01-06', 'AAPL', 'SELL', 100, 187.90, 1.00, 'TREND',    270.00),
    (5,  '2026-01-07', 'TSLA', 'BUY',   60, 215.50, 1.00, 'BREAKOUT', 0.00),
    (6,  '2026-01-07', 'SPY',  'BUY',   80, 475.00, 1.00, 'MEANREV',  0.00),
    (7,  '2026-01-08', 'MSFT', 'SELL',  50, 398.40, 1.00, 'TREND',   -185.00),
    (8,  '2026-01-08', 'NVDA', 'SELL',  40, 552.80, 1.00, 'BREAKOUT', 500.00),
    (9,  '2026-01-09', 'TSLA', 'SELL',  60, 208.90, 1.00, 'BREAKOUT',-396.00),
    (10, '2026-01-09', 'SPY',  'SELL',  80, 477.30, 1.00, 'MEANREV',  184.00),
    (11, '2026-01-12', 'AAPL', 'BUY',  120, 186.00, 1.00, 'TREND',    0.00),
    (12, '2026-01-12', 'NVDA', 'BUY',   30, 561.00, 1.00, 'BREAKOUT', 0.00),
    (13, '2026-01-13', 'AAPL', 'SELL', 120, 189.40, 1.00, 'TREND',    408.00),
    (14, '2026-01-13', 'TSLA', 'BUY',   70, 210.20, 1.00, 'BREAKOUT', 0.00),
    (15, '2026-01-14', 'NVDA', 'SELL',  30, 548.20, 1.00, 'BREAKOUT',-384.00),
    (16, '2026-01-14', 'SPY',  'BUY',  100, 478.10, 1.00, 'MEANREV',  0.00),
    (17, '2026-01-15', 'TSLA', 'SELL',  70, 218.60, 1.00, 'BREAKOUT', 588.00),
    (18, '2026-01-15', 'SPY',  'SELL', 100, 476.20, 1.00, 'MEANREV', -190.00),
    (19, '2026-01-16', 'MSFT', 'BUY',   40, 405.00, 1.00, 'TREND',    0.00),
    (20, '2026-01-16', 'AAPL', 'BUY',   90, 190.10, 1.00, 'TREND',    0.00),
    (21, '2026-01-19', 'MSFT', 'SELL',  40, 411.50, 1.00, 'TREND',    260.00),
    (22, '2026-01-19', 'AAPL', 'SELL',  90, 188.30, 1.00, 'TREND',   -162.00),
    (23, '2026-01-20', 'NVDA', 'BUY',   35, 555.00, 1.00, 'BREAKOUT', 0.00),
    (24, '2026-01-20', 'SPY',  'BUY',   90, 477.00, 1.00, 'MEANREV',  0.00),
    (25, '2026-01-21', 'NVDA', 'SELL',  35, 571.40, 1.00, 'BREAKOUT', 574.00),
    (26, '2026-01-21', 'SPY',  'SELL',  90, 480.30, 1.00, 'MEANREV',  297.00);

-- asset_master: one row per watchlist asset (lookup table). MOCK DATA ONLY.
DROP TABLE IF EXISTS asset_master;
 
CREATE TABLE asset_master (
    asset    TEXT PRIMARY KEY,
    company  TEXT,
    sector   TEXT
);
 
INSERT INTO asset_master VALUES
    ('AAPL', 'Apple Inc.',      'Technology'),
    ('MSFT', 'Microsoft Corp.', 'Technology'),
    ('NVDA', 'NVIDIA Corp.',    'Technology'),
    ('TSLA', 'Tesla Inc.',      'Automotive'),
    ('SPY',  'S&P 500 ETF',     'Index Fund'),
    ('AMZN', 'Amazon.com Inc.', 'Consumer');

-- broker_positions: the broker's statement of shares held. MOCK DATA ONLY.
DROP TABLE IF EXISTS broker_positions;
 
CREATE TABLE broker_positions (
    asset       TEXT PRIMARY KEY,
    broker_qty  INTEGER
);
 
INSERT INTO broker_positions VALUES
    ('AAPL', 0),
    ('MSFT', 5),
    ('NVDA', 0),
    ('TSLA', 0),
    ('SPY', 10),
    ('AMZN', 0);
