--BANCO DE DADOS OFICINA - ORÇAMENTO E CONSULTAS

-- Tabela de Mecânicos
CREATE TABLE "mecanino" (
	"mecanicoID"	INTEGER,
	"mecaninoNome"	TEXT NOT NULL,
	"mecanincoEspeciallidade"	TEXT,
	PRIMARY KEY("mecanicoID" AUTOINCREMENT)
)

SELECT * FROM mecanino;

INSERT INTO mecanino (mecanicoID, mecaninoNome, mecanincoEspeciallidade) VALUES (4, "Zé Mecanico", "Suspensão");

CREATE TABLE "cliente" (
	"clienteID"	INTEGER,
	"clienteNome"	TEXT NOT NULL,
	"clienteEndereco"	TEXT,
	"clienteCelular"	TEXT,
	PRIMARY KEY("clienteID" AUTOINCREMENT)
)

INSERT INTO cliente VALUES (3, "Carlos Cliente", "Casa do Carlos", "6333333333");

CREATE TABLE "carro" (
	"carroID"	INTEGER,
	"carroClienteID"	INTEGER,
	"carroMarca"	TEXT NOT NULL,
	"carroModelo"	TEXT NOT NULL,
	"carroAno"	INTEGER NOT NULL,
	"carroPlaca"	INTEGER NOT NULL,
	PRIMARY KEY("carroID" AUTOINCREMENT),
	CONSTRAINT "fk_carro_cliente" FOREIGN KEY("carroClienteID") REFERENCES "cliente"("clienteID")
)

INSERT INTO carro VALUES (3, 3, "Toyota", "Corolla", "1999", "COROLLA12");

CREATE TABLE "pecas" (
	"pecaID"	INTEGER,
	"pecaModeloCarro"	TEXT,
	"pecaAnoCarro"	INTEGER,
	"pecaNome"	INTEGER,
	"pecaPreco"	INTEGER,
	PRIMARY KEY("pecaID" AUTOINCREMENT),
)

INSERT INTO pecas VALUES (3, "Toyotta", "2024", "Disco de Freio", 270.98);

CREATE TABLE "servicos" (
	"servicoID"	INTEGER,
	"servicoTipo"	INTEGER NOT NULL,
	"servicoNome"	INTEGER NOT NULL,
	"servicoPreco"	INTEGER,
	PRIMARY KEY("servicoID" AUTOINCREMENT)
)

INSERT INTO servicos VALUES (1, "Mecânica", "Troca do disco de freio", 100.00);

CREATE TABLE "orcamento" (
	"orcamentoID"	INTEGER,
	"orcamentoCarroID"	INTEGER,
	"orcamentoServicoID"	INTEGER,
	"orcamentoPecaID"	INTEGER,
	"orcamentoPecaQtde"	INTEGER,
	"orcamentoStatus"	TEXT,
	PRIMARY KEY("orcamentoID" AUTOINCREMENT),
	CONSTRAINT "fk_orcamento_carro" FOREIGN KEY("orcamentoCarroID") REFERENCES "carro"("carroID"),
	CONSTRAINT "fk_orcamento_peca" FOREIGN KEY("orcamentoPecaID") REFERENCES "pecas"("pecaID"),
	CONSTRAINT "fk_orcamento_servico" FOREIGN KEY("orcamentoServicoID") REFERENCES "servicos"("servicoID"),
	CONSTRAINT "check_orcamento_status" CHECK(orcamentoStatus IN("Em análise", "Aprovado", "Recusado", "Em execução", "Finalizado"))
)

INSERT INTO orcamento VALUES (3, 3, 1, 1, 2, "Em análise");

SELECT * FROM orcamento;

SELECT * FROM orcamento WHERE orcamentoPecaQtde > 1;

SELECT 
	orcamentoID AS "ID", 
	servicoNome AS "Serviço", 
	pecaNome "Peça", 
	ROUND(servicoPreco) AS "Preço Serviço", 
	ROUND(pecaPreco) AS "Preço peça",
	orcamentoPecaQtde AS "Peça qtde",
	ROUND((pecaPreco * orcamentoPecaQtde)) AS "Valor peças",
	ROUND(((pecaPreco * orcamentoPecaQtde) + servicoPreco)) AS "Valor total",
	ROUND((((pecaPreco * orcamentoPecaQtde) + servicoPreco)*0.95)) AS "Valor Pix (-5%)",
	ROUND(((((pecaPreco * orcamentoPecaQtde) + servicoPreco)*1.12)/12)) AS "Valor Parcelado (+12% em 12X)"
FROM orcamento, servicos, pecas
ORDER BY "Valor Parcelado (+12% em 12X)" DESC;

SELECT clienteNome, carroModelo, carroAno FROM cliente LEFT JOIN carro ON clienteID = carroClienteID;