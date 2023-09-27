.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Pontos antes da compra:'
.print ''

select * from produto where codigoProduto = 1;

INSERT INTO entrouPromocao VALUES (1, 1, 1);

.print ''
.print 'Pontos apos compra:'
.print ''	

select * from produto where codigoProduto = 1;