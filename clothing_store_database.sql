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

INSERT INTO Fornecedores (CNPJ, nome, DESCRICAO) VALUES 
('12.345.678/0001-90', 'Fornecedor A', 'Fornecedor de roupas casuais'),
('23.456.789/0001-80', 'Fornecedor B', 'Fornecedor de roupas esportivas'),
('34.567.890/0001-70', 'Fornecedor C', 'Fornecedor de roupas formais');

INSERT INTO Produtos (nome, preco_de_venda, tamanho, cor, tipo_de_produto, fornecedor_id, preco_de_compra_fornecedor) VALUES 
('Camiseta', 50.00, 'M', 'Azul', 'Camiseta', 1, 30.00),
('Calça Jeans', 120.00, 'G', 'Preto', 'Calça', 2, 80.00),
('Vestido', 200.00, 'P', 'Vermelho', 'Vestido', 3, 120.00),
('Blusa', 75.00, 'M', 'Branco', 'Blusa', 1, 50.00),
('Shorts', 60.00, 'P', 'Verde', 'Shorts', 2, 40.00);

INSERT INTO Funcionarios (Nome, Salario, CPF) VALUES 
('João da Silva', 3000.00, '123.456.789-10'),
('Maria Oliveira', 3500.00, '234.567.890-20'),
('Carlos Souza', 4000.00, '345.678.901-30'),
('Ana Pereira', 3200.00, '456.789.012-40'),
('Lucas Costa', 2800.00, '567.890.123-50');

INSERT INTO Clientes (CPF, Nome, id_produto_comprado) VALUES 
('789.012.345-60', 'Paula Lima', 1),
('890.123.456-70', 'Fernando Alves', 2),
('901.234.567-80', 'Juliana Martins', 3),
('012.345.678-90', 'Roberto Gonçalves', 4),
('123.456.789-00', 'Carla Nunes', 5);

INSERT INTO Compras (forma_de_pagamento, data_de_compra, valor, descricao, cliente_id) VALUES 
('Cartão de Crédito', '2024-01-15', 50.00, 'Compra de camiseta', 1),
('Dinheiro', '2024-01-20', 120.00, 'Compra de calça jeans', 2),
('Cartão de Débito', '2024-01-25', 200.00, 'Compra de vestido', 3),
('Boleto', '2024-01-30', 75.00, 'Compra de blusa', 4),
('Pix', '2024-02-05', 60.00, 'Compra de shorts', 5);

INSERT INTO Despesas (descricao, valor) VALUES 
('Pagamento de aluguel', 5000.00),
('Compra de materiais de escritório', 300.00),
('Manutenção de equipamentos', 150.00),
('Pagamento de conta de luz', 800.00),
('Marketing e publicidade', 2000.00);

INSERT INTO Saldo_em_Conta (data, descricao, valor, tipo_transacao, saldo_atual) VALUES 
('2024-01-01', 'Saldo inicial', 10000.00, 'lucro', 10000.00),
('2024-01-15', 'Compra de camiseta', 50.00, 'lucro', 10050.00),
('2024-01-20', 'Compra de calça jeans', 120.00, 'lucro', 10170.00),
('2024-01-25', 'Compra de vestido', 200.00, 'lucro', 10370.00),
('2024-01-30', 'Compra de blusa', 75.00, 'lucro', 10445.00),
('2024-02-05', 'Compra de shorts', 60.00, 'lucro', 10505.00),
('2024-02-10', 'Pagamento de aluguel', -5000.00, 'despesa', 5505.00),
('2024-02-15', 'Compra de materiais de escritório', -300.00, 'despesa', 5205.00),
('2024-02-20', 'Manutenção de equipamentos', -150.00, 'despesa', 5055.00),
('2024-02-25', 'Pagamento de conta de luz', -800.00, 'despesa', 4255.00),
('2024-02-28', 'Marketing e publicidade', -2000.00, 'despesa', 2255.00);

INSERT INTO Cancelamento_compra (descricao, compras_id) VALUES 
('Produto com defeito', 1),
('Troca por tamanho errado', 3);
