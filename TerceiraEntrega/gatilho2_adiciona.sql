.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--Se o cartaoCliente tiver pontos, estes sao usados	
CREATE TRIGGER IF NOT EXISTS aplicaDesconto
after insert on entrouPromocao
for each row
begin
	update produto
	set preco = preco - (select desconto from promocao where promocao.idPromocao = New.idPromocao)/100.0
	where produto.codigoProduto = New.codigoProduto;
end;