.mode		columns
.headers	on
.nullvalue	NULL

-- 10. Funcionarios que mais compraram nos supermercados

select nome, pessoa.nif, sum(preco) as TotalGasto from pessoa
inner join funcionario
on pessoa.nif = funcionario.nif
inner join fatura
on fatura.nifCliente = funcionario.nif
order by TotalGasto desc