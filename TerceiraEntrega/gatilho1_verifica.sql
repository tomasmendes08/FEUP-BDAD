.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Estado atual das Faturas:'
.print ''

select * from fatura where nrFatura = 1;

INSERT INTO produtoFatura VALUES (5, 1);

.print ''
.print 'Estado depois do gatilho das Faturas:'
.print ''

select * from fatura where nrFatura = 1;