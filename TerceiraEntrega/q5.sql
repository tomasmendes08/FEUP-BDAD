.mode		columns
.headers	on
.nullvalue	NULL

-- 5. Supermercado mais lucrativo em 3 meses

select totalMensal.idSupermercado, avg(valor) as MediaSupermercado, MediaTotal, avg(valor) - MediaTotal as Diferenca
from (select avg(valor) as MediaTotal from totalMensal), totalMensal
where ano = '2020' and mes between 3 and 6
group by totalMensal.idSupermercado
order by Diferenca desc