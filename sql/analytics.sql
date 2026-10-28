--- Asset overview
select asset,
count(*) as trade_count, 
sum(quantity) as vol, 
sum(fee) as total_fee, 
sum(realized_pnl) as gross_pnl, 
round(sum(realized_pnl - fee), 2) as net_pnl , 
avg(realized_pnl - fee) as average_pnl
from trade_logs
where trade_date between  '2026-01-07' AND '2026-01-21'
group by asset
having count(*) >= 5 and net_pnl > 0
order by net_pnl desc

--- Blotter
select trade_id, asset, trade_date, side, price,
row_number() over ( partition by asset order by trade_date, trade_id) as trade_seq,
lag(price) over ( partition by asset order by trade_date, trade_id) as prev_price,
round(
price - lag(price) over ( PARTITION by asset order by trade_date, trade_id) , 2
) as price_change
from trade_logs
order by asset, trade_seq

--- Performance by sector
select m.sector, sum(t.realized_pnl - t.fee) as net_pnl, 
count(*) as trade_count
from trade_logs as t
left join asset_master as m
on t.asset = m.asset
group by m.sector
order by net_pnl desc