PRAGMA foreign_keys = ON;

.mode columns
.headers on	
.nullvalue NULL

-- Table: ProdutoFatura
DROP TABLE IF EXISTS produtoFatura;
CREATE TABLE produtoFatura (
	codigoProduto INTEGER REFERENCES produto(codigoProduto),
	nrFatura INTEGER REFERENCES fatura(nrFatura),
	CONSTRAINT produtoFatura_pk PRIMARY KEY (codigoProduto, nrFatura)
);

-- Table: ProdutoArmazem
DROP TABLE IF EXISTS produtoArmazem;
CREATE TABLE produtoArmazem (
	produto INTEGER REFERENCES produto(codigoProduto),
	supermercado INTEGER,
	armazem INTEGER,
	CONSTRAINT produtoArmazem_pk PRIMARY KEY (produto, supermercado, armazem),
	CONSTRAINT produtoArmazem_fk FOREIGN KEY (supermercado, armazem) REFERENCES  armazem(idSupermercado, idArmazem)
);

-- Table: ForneceuSupermercado
DROP TABLE IF EXISTS precosSupermercados;
CREATE TABLE precosSupermercados (
	idSupermercado INTEGER REFERENCES supermercado(idSupermercado),
	nifFornecedor INTEGER REFERENCES fornecedor(nif),
	codigoProduto INTEGER REFERENCES produto(codigoProduto),
	preco INTEGER NOT NULL,
	CONSTRAINT precosSupermercados_pk PRIMARY KEY (nifFornecedor, codigoProduto, idSupermercado)
);


-- Table: totalMensal
DROP TABLE IF EXISTS totalMensal;
CREATE TABLE totalMensal (
	mes INTEGER CHECK (mes >= 1 AND mes <= 12) NOT NULL,
	ano INTEGER CHECK (ano >= 2020) NOT NULL,
	idSupermercado INTEGER,
	valor INTEGER NOT NULL,
	CONSTRAINT totalMensal_pk PRIMARY KEY (mes, ano, idSupermercado),
	CONSTRAINT totalMensal_fk FOREIGN KEY (idSupermercado) REFERENCES supermercado(idSupermercado)
);

-- Table: Fatura
DROP TABLE IF EXISTS fatura;
CREATE TABLE fatura (
	nrFatura INTEGER,
	dataFatura DATE,
	nifCliente INTEGER REFERENCES cliente(nif),
	nifFuncionario INTEGER,
	idSupermercado INTEGER,
	preco INTEGER,
	CONSTRAINT fatura_pk PRIMARY KEY (nrFatura),
	CONSTRAINT fatura_fk FOREIGN KEY (nifFuncionario, idSupermercado) REFERENCES caixa(nif, idSupermercado)
);


-- Table: CartaoCliente
DROP TABLE IF EXISTS cartaoCliente;
CREATE TABLE cartaoCliente (
	nif INTEGER REFERENCES cliente(nif),
	pontos INTEGER CHECK (pontos >= 0) NOT NULL,
	CONSTRAINT cartaoCliente_pk PRIMARY KEY (nif)
);

-- Table: EntrouPromocao
DROP TABLE IF EXISTS entrouPromocao;
CREATE TABLE entrouPromocao (
	idSupermercado INTEGER REFERENCES supermercado(idSupermercado),
	idPromocao INTEGER REFERENCES promocao(idPromocao),
	codigoProduto INTEGER REFERENCES produto(codigoProduto),
	CONSTRAINT entrouPromocao_pk PRIMARY KEY (idSupermercado, idPromocao, codigoProduto)
);

-- Table: Promocao
DROP TABLE IF EXISTS promocao;
CREATE TABLE promocao (
	idPromocao INTEGER NOT NULL,
	desconto INTEGER CHECK (desconto > 0),
	descricao VARCHAR2(128),
	CONSTRAINT promocao_pk PRIMARY KEY (idPromocao)
);

-- Table: Produto	
DROP TABLE IF EXISTS produto;
CREATE TABLE produto (
	codigoProduto INTEGER,
	idSupermercado INTEGER REFERENCES supermercado(idSupermercado),
	marca VARCHAR2(64) NOT NULL,
	tipo VARCHAR2(64) NOT NULL,
	validade DATE,
	preco INTEGER NOT NULL CHECK (preco > 0),
	CONSTRAINT produto_pk PRIMARY KEY (codigoProduto)
);

-- Table: Departamento
DROP TABLE IF EXISTS departamento;
CREATE TABLE departamento (
	idDepartamento INTEGER,
	seccao VARCHAR2(64) NOT NULL,
	idSupermercado INTEGER,
	idFuncionario INTEGER,
	nif INTEGER,
	CONSTRAINT departamento_pk PRIMARY KEY (idDepartamento),
	CONSTRAINT departamento_fk FOREIGN KEY (nif, idSupermercado) REFERENCES funcionario(nif, idSupermercado),
	CONSTRAINT idS_idF CHECK (idSupermercado = idFuncionario)
);

DROP TABLE IF EXISTS gerente;
CREATE TABLE gerente (
	nif INTEGER,
	idSupermercado INTEGER,
	CONSTRAINT gerente_pk PRIMARY KEY (nif, idSupermercado),
	CONSTRAINT gerente_fk FOREIGN KEY (nif, idSupermercado) REFERENCES funcionario(nif, idSupermercado)
);

DROP TABLE IF EXISTS caixa;
CREATE TABLE caixa (
	nif INTEGER,
	idSupermercado INTEGER,
	CONSTRAINT caixa_pk PRIMARY KEY (nif, idSupermercado),
	CONSTRAINT caixa_fk FOREIGN KEY (nif, idSupermercado) REFERENCES funcionario(nif, idSupermercado)
);

DROP TABLE IF EXISTS repositor;
CREATE TABLE repositor (
	nif INTEGER,
	idSupermercado INTEGER,
	CONSTRAINT repositor_pk PRIMARY KEY (nif, idSupermercado),
	CONSTRAINT repositor_fk FOREIGN KEY (nif, idSupermercado) REFERENCES funcionario(nif, idSupermercado)
);

DROP TABLE IF EXISTS limpeza;
CREATE TABLE limpeza (
	nif INTEGER,
	idSupermercado INTEGER,
	CONSTRAINT limpeza_pk PRIMARY KEY (nif, idSupermercado),
	CONSTRAINT limpeza_fk FOREIGN KEY (nif, idSupermercado) REFERENCES funcionario(nif, idSupermercado)
);

-- Table: Funcionario
DROP TABLE IF EXISTS funcionario;
CREATE TABLE funcionario (
	nif INTEGER REFERENCES pessoa(nif),
	idSupermercado INTEGER REFERENCES supermercado(idSupermercado),
	salario INTEGER CHECK (salario >= 635),
	turno INTEGER REFERENCES turno(idTurno) NOT NULL,
	CONSTRAINT funcionario_pk PRIMARY KEY (nif, idSupermercado)
);

--Table: Turno
DROP TABLE IF EXISTS turno;
CREATE TABLE turno(
	idTurno INTEGER,
	horario_inicio TIME NOT NULL,
	horario_fim TIME NOT NULL,
	CONSTRAINT turno_pk PRIMARY KEY (idTurno)
);

-- Table: Fornecedor
DROP TABLE IF EXISTS fornecedor;
CREATE TABLE fornecedor (
	nif INTEGER REFERENCES pessoa(nif),
	telefone INTEGER CHECK ((telefone BETWEEN 910000000 AND 929999999) OR (telefone BETWEEN 930000000 AND 939999999) OR (telefone BETWEEN 960000000 AND 969999999) OR (telefone BETWEEN 210000000 AND 299999999)),
	email VARCHAR2(64) UNIQUE,
	CONSTRAINT fornecedor_pk PRIMARY KEY (nif)
);	

-- Table: Cliente
DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
	nif INTEGER REFERENCES pessoa(nif),
	telefone INTEGER CHECK ((telefone BETWEEN 910000000 AND 929999999) OR (telefone BETWEEN 930000000 AND 939999999) OR (telefone BETWEEN 960000000 AND 969999999) OR (telefone BETWEEN 210000000 AND 299999999)),
	CONSTRAINT cliente_pk PRIMARY KEY (nif)	
);


--Table: Pessoa
DROP TABLE IF EXISTS pessoa;
CREATE TABLE pessoa (
	nif INTEGER CHECK (nif > 100000000) NOT NULL,
	nome VARCHAR2(64) NOT NULL,
	idade INTEGER CHECK (idade > 0),
	CONSTRAINT pessoa_pk PRIMARY KEY (nif)
);

-- Table: Armazém
DROP TABLE IF EXISTS armazem;
CREATE TABLE armazem (
	idSupermercado INTEGER REFERENCES supermercado(idSupermercado),
	idArmazem INTEGER CHECK (idArmazem > 0),
	capacidade INTEGER CHECK (capacidade > 0),
	taxaocupacao INTEGER CHECK (taxaocupacao >= 0),
	CONSTRAINT armazem_pk PRIMARY KEY (idSupermercado, idArmazem),
	CONSTRAINT ch_ca_to CHECK (capacidade >= taxaocupacao)
);

--Table: Supermercado
DROP TABLE IF EXISTS supermercado;
CREATE TABLE supermercado (
	idSupermercado INTEGER NOT NULL,
	localidade VARCHAR2(64),
	morada VARCHAR2(128),
	codPostal VARCHAR2(64),
	CONSTRAINT supermercado_pk PRIMARY KEY (idSupermercado)
);