.headers	on
.nullvalue	NULL

-- 6. 10% dos funcionários mais bem pagos

select nome, idSupermercado, salario, count(*) as Total
from funcionario inner join pessoa
on funcionario.nif = pessoa.nif
group by nome
order by salario desc
limit (select count(*)/10 from funcionario) 