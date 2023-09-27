.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--Quando é adicionado um produto ao armazem a sua taxa de ocupacao aumenta	
CREATE TRIGGER IF NOT EXISTS validaCompra
before insert on fatura
for each row
begin
select case
when ((select count(*) from Funcionario, caixa where New.nifFuncionario = caixa.nif) = 0 or New.preco <= 0)
then raise(abort, 'Funcionario Invalido!')
end;
end;