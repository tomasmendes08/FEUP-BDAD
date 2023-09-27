.mode		columns
.headers	on
.nullvalue	NULL

-- 4. Qual o fornecedor que mais forneceu os supermercados

select nome, count(fornecedor.nif) as NrVezes, sum(preco) as PrecoTotal
from fornecedor inner join pessoa inner join precosSupermercados
where fornecedor.nif = pessoa.nif and fornecedor.nif = precosSupermercados.nifFornecedor
group by nome
order by NrVezes desc, PrecoTotal desc