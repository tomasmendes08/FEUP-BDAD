.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print Fatura valida:
.print ''

INSERT INTO fatura VALUES (15, '03-27-2020', 230471277, 184389119, 3, 10);

.print ''
.print 'Fatura nao valida:'
.print ''

INSERT INTO fatura VALUES (20, '03-27-2020', 230471277, 171316770, 3, 10);