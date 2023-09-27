.headers	on
.nullvalue	NULL

-- 9. Numero de Faturas com pelo menos um Artigo da marca 'Dulce'

select count(*) as Total
from fatura f
inner join produtoFatura pf
on f.nrFatura = pf.nrFatura
inner join produto p
on pf.codigoProduto = p.codigoProduto
where p.marca = 'Dulce'
