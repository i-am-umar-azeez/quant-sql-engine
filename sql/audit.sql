-- most recent trade by stock
with ranked as (
select asset, trade_id, trade_date, side, quantity, price,
row_number() over ( PARTITION by asset order by trade_date desc, trade_id desc) as rn
from trade_logs
)
select asset, trade_id, trade_date, side, quantity, price
from ranked where rn = 1
order by asset;

-- broker reconciliation
with internal as ( select asset,
sum( case when side = 'BUY' then quantity else - quantity end)
as internal_qty 
from trade_logs 
group by asset),

compared as (
select b.asset, coalesce(i.internal_qty, 0) as internal_qty, 
b.broker_qty, coalesce(i.internal_qty, 0) - b.broker_qty as difference
from broker_positions as b
left join internal as i
on i.asset = b.asset)

select asset, internal_qty, broker_qty, difference,
case when difference = 0 then 'MATCH' else 'BREAK' end as status
from compared order by abs(difference) desc, asset;
