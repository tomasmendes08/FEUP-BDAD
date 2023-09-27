.mode		columns
.headers	on
.nullvalue	NULL

-- 3. 2o Cliente que mais gastou

select nome, count(nome) as NrFaturas, sum(preco) as TotalGasto
from cliente join fatura join pessoa
where cliente.nif = pessoa.nif and cliente.nif = fatura.nifCliente
group by nome
order by TotalGasto desc, NrFaturas desc
limit 1 offset 1