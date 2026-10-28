--Health check
select 
case when (select count(*) from trade_logs) = 26 then 'Pass' else 'Fail' end as trade_rows,
case when (select count(*) from trade_logs as t inner join asset_master as m on m.asset = t.asset) = 26 then 'Pass' else 'Fail' end as join_rows,
case when (select count(*) from trade_logs where asset not in (select asset from asset_master)) = 0 then 'Pass' else 'Fail' end as orphan_trades,
case when (select round(sum(realized_pnl - fee), 2) from trade_logs) = 1738 then 'Pass' else 'Fail' end as total_net_pnl