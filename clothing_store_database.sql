CREATE DATABASE clothing_store_database;
USE clothing_store_database;

/* Tabela de Fornecedores */ 
CREATE TABLE Fornecedores (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    CNPJ VARCHAR(18) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    DESCRICAO VARCHAR(255) NOT NULL
)COMMENT '';

/* Tabela de Produtos */ 
CREATE TABLE Produtos (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    nome VARCHAR(100) NOT NULL,
    preco_de_venda DECIMAL(10, 2) NOT NULL,
    tamanho VARCHAR(20) NOT NULL,
    cor VARCHAR(50) NOT NULL,
    tipo_de_produto VARCHAR(50) NOT NULL,
    fornecedor_id INT NOT NULL,
    preco_de_compra_fornecedor DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedores(id)
)COMMENT '';

/* Tabela de Funcionarios */ 
CREATE TABLE Funcionarios(  
    id int(3) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Nome VARCHAR(255) NOT NULL,
    Salario DECIMAL(7,2) NOT NULL,
    CPF VARCHAR(14) NOT NULL
) COMMENT '';

/* Tabela de Clientes */ 
CREATE TABLE Clientes (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    CPF VARCHAR(15) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    id_produto_comprado int NOT NULL,
    FOREIGN KEY (id_produto_comprado) REFERENCES Produtos(id)
)COMMENT '';

/* Tabela de Compras */ 
CREATE TABLE Compras (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    forma_de_pagamento VARCHAR(50) NOT NULL,
    data_de_compra DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
)COMMENT '';

/* Tabela de Despesas */ 
CREATE TABLE Despesas (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
)COMMENT '';

/* Tabela de Saldo em Conta */
CREATE TABLE Saldo_em_Conta (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    data DATE NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    tipo_transacao ENUM('lucro', 'despesa') NOT NULL,
    saldo_atual DECIMAL(10, 2) NOT NULL
) COMMENT 'Tabela que registra o saldo da loja após cada transação';

/* Trigger para atualizar o saldo após uma compra */
DELIMITER //
CREATE TRIGGER after_compra_insert
AFTER INSERT ON Compras
FOR EACH ROW
BEGIN
    DECLARE saldo DECIMAL(10,2);
    SET saldo = (SELECT saldo_atual FROM Saldo_em_Conta ORDER BY id DESC LIMIT 1);
    IF saldo IS NULL THEN
        SET saldo = 0;
    END IF;
    INSERT INTO Saldo_em_Conta (data, descricao, valor, tipo_transacao, saldo_atual)
    VALUES (NEW.data_de_compra, NEW.descricao, NEW.valor, 'lucro', saldo + NEW.valor);
END//
DELIMITER ;

/* Trigger para atualizar o saldo após uma despesa */
DELIMITER //
CREATE TRIGGER after_despesa_insert
AFTER INSERT ON Despesas
FOR EACH ROW
BEGIN
    DECLARE saldo DECIMAL(10,2);
    SET saldo = (SELECT saldo_atual FROM Saldo_em_Conta ORDER BY id DESC LIMIT 1);
    IF saldo IS NULL THEN
        SET saldo = 0;
    END IF;
    INSERT INTO Saldo_em_Conta (data, descricao, valor, tipo_transacao, saldo_atual)
    VALUES (CURDATE(), NEW.descricao, NEW.valor, 'despesa', saldo - NEW.valor);
END//
DELIMITER ;

/* Tabela de Cancelamento (Reembolso)*/
CREATE TABLE Cancelamento_compra (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    descricao VARCHAR(255) NOT NULL,
    compras_id INT NOT NULL,
    FOREIGN KEY (compras_id) REFERENCES Compras(id)
)COMMENT '';

DELIMITER //
CREATE TRIGGER after_cancelamento_insert
AFTER INSERT ON Cancelamento_compra
FOR EACH ROW
BEGIN
    DECLARE saldo_loja DECIMAL(10,2);
    DECLARE valor_compra DECIMAL(10,2);

    -- Recupera o valor da compra associada ao cancelamento
    SELECT valor INTO valor_compra FROM Compras WHERE id = NEW.compras_id;

    -- Recupera o saldo atual da loja
    SET saldo_loja = (SELECT saldo_atual FROM Saldo_em_Conta ORDER BY id DESC LIMIT 1);
    IF saldo_loja IS NULL THEN
        SET saldo_loja = 0;
    END IF;

    -- Atualiza o saldo da loja
    INSERT INTO Saldo_em_Conta (data, descricao, valor, tipo_transacao, saldo_atual)
    VALUES (CURDATE(), CONCAT('Cancelamento: ', NEW.descricao), -valor_compra, 'despesa', saldo_loja - valor_compra);
END//
DELIMITER ;

/* Não haverá mais troca
CREATE TABLE Solicitacoes_Troca (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    descricao VARCHAR(255) NOT NULL,
    cliente_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id)
)COMMENT '';
*/