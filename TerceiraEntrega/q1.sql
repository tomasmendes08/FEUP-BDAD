.mode		columns
.headers	on
.nullvalue	NULL

-- 1. Produto mais caro em cada supermercado

select marca, tipo, preco, idSupermercado
from produto
group by marca, tipo
order by preco desc limit 3;