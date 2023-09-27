.headers	on
.nullvalue	NULL

-- 8. Melhores pares de produtos
drop view if exists pares;
create view pares as select * from (select marca as Marca1, tipo as Tipo1, produto.codigoProduto as Cod1, nrFatura as Fatura1 from produtoFatura
inner join produto
on produtoFatura.codigoProduto = produto.codigoProduto) as Prod1
cross join    
(select marca as Marca2, tipo as Tipo2, produto.codigoProduto as Cod2, nrFatura as Fatura2 from produtoFatura
inner join produto
on produtoFatura.codigoProduto = produto.codigoProduto) as Prod2
on ((Prod1.Tipo1 <> Prod2.Tipo2 or Prod1.Marca1 <> Prod2.Marca2) and Prod1.Cod1 < Prod2.Cod2)
group by Prod1.Tipo1, Prod1.Marca1, Prod2.Tipo2, Prod2.Marca2;

drop view if exists prods;
create view prods as select T1.nrFatura as Prod1Fat, T1.marca as MarcaProd1, T1.tipo as TipoProd1, T1.codigoProduto as CodProd1, T2.nrFatura as Prod2Fat, T2.marca as MarcaProd2, T2.tipo as TipoProd2, T2.codigoProduto as CodProd2 from (select * from (select fatura.nrFatura, marca, tipo, produto.codigoProduto from fatura
inner join produtoFatura
on fatura.nrFatura = produtoFatura.nrFatura
inner join produto
on produtoFatura.codigoProduto = produto.codigoProduto
group by fatura.nrFatura, marca, tipo)) as T1
cross join
(select * from (select fatura.nrFatura, marca, tipo, produto.codigoProduto from fatura
inner join produtoFatura
on fatura.nrFatura = produtoFatura.nrFatura
inner join produto
on produtoFatura.codigoProduto = produto.codigoProduto
group by fatura.nrFatura, marca, tipo)) as T2
where T1.nrFatura = T2.nrFatura and (MarcaProd1 <> MarcaProd2 or TipoProd1 <> TipoProd2) and CodProd1 < CodProd2;

drop view if exists ordenados;
create view ordenados as select distinct * from pares
inner join
prods
where (Marca1 == MarcaProd1 and Tipo1 == TipoProd1 and Marca2 == MarcaProd2 and Tipo2 == TipoProd2)
or (Marca2 == MarcaProd1 and Tipo2 == TipoProd1 and Marca1 == MarcaProd2 and Tipo1 == TipoProd2);

select Marca1, Tipo1, Marca2, Tipo2, count(*) as QuantidadeVezes from pares
cross join
prods
where (Marca1 == MarcaProd1 and Tipo1 == TipoProd1 and Marca2 == MarcaProd2 and Tipo2 == TipoProd2)
or (Marca1 == MarcaProd2 and Tipo1 == TipoProd2 and Marca2 == MarcaProd1 and Tipo2 == TipoProd1) and Fatura1 == Fatura2
group by Marca1, Tipo1, Marca2, Tipo2