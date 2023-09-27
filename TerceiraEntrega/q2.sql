.mode		columns
.headers	on
.nullvalue	NULL

-- 2. Top 3 dos produtos mais vendido

select marca, tipo, preco, count(produto.codigoProduto) as Quantidade
from produto inner join produtoFatura
where produtoFatura.codigoProduto = produto.codigoProduto
group by marca, tipo 
order by Quantidade desc limit 3