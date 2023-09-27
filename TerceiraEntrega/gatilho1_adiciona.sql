.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--Quando é adicionado um produto a uma fatura o seu preço aumenta	
drop trigger if exists aumentaValorRecibo;
CREATE TRIGGER IF NOT EXISTS aumentaValorRecibo
after insert on produtoFatura
for each row
	begin
	update fatura
	set preco = preco + (select preco from produto where produto.codigoProduto = New.codigoProduto)
	where nrFatura = New.nrFatura;
	end;