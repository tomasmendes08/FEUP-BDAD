.headers	on
.nullvalue	NULL

-- 7. Promocoes que contêm todos os produtos da marca 'Dulce'

select promocao.idPromocao, descricao from promocao
inner join entrouPromocao
on promocao.idPromocao = entrouPromocao.idPromocao
inner join produto
on entrouPromocao.codigoProduto = produto.codigoProduto
where marca = 'Dulce'
group by promocao.idPromocao, descricao
having count(*) - (select count(*) from produto where marca = 'Dulce') = 0