create schema login;
use login;

-- 1. Criação da tabela tb_login
CREATE TABLE tb_login (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    is_admin TINYINT(1) NOT NULL
);

-- 2. Criação da tabela administrador
CREATE TABLE administrador (
    ID_Administrador INT(11) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    is_admin TINYINT(1) NOT NULL
);

-- 3. Criação da tabela veiculo
CREATE TABLE veiculo (
    ID_Veiculo INT(11) AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT(11),
    Preço DECIMAL(10,2),
    Foto VARCHAR(255), 
    Status ENUM('Disponível', 'Vendido', 'Reservado'),
    id_administrador INT(11),
    FOREIGN KEY (id_administrador) REFERENCES administrador(ID_Administrador)
);

INSERT INTO veiculo (Nome, Marca, Modelo, Ano, Preço, Foto, Status, id_administrador) VALUES
('Audi Supra TT', 'Audi', 'Supra TT', 2024, 350000.00,'https://editorial.pxcrush.net/carsales/general/editorial/2024-audi-tt_11587.jpg?width=1024&height=682', 'Disponível', 1),
('BMW X5', 'BMW', 'X5', 2024, 400000.00, 'https://cdn.motor1.com/images/mgl/1ZkqgW/s1/2023-bmw-x5.jpg', 'Disponível', 1),
('Mercedes-Benz C-Class', 'Mercedes-Benz', 'C-Class', 2024, 300000.00, 'https://vehicle-images.dealerinspire.com/f2f3-110008839/W1KAF4HB5RR230485/ce03fdf5cba4c37aa54713cf1bef908d.jpg', 'Disponível', 1),
('Toyota Corolla', 'Toyota', 'Corolla', 2024, 120000.00, 'https://cdn.motor1.com/images/mgl/6ZzYpG/s3/toyota-corolla-hybrid-2024.jpg', 'Disponível', 1),
('Ford Mustang', 'Ford', 'Mustang', 2024, 300000.00, 'https://cdn.motor1.com/images/mgl/mMPmzP/306:0:4885:3666/2024-ford-mustang-gt-exterior-front-quarter.webp', 'Disponível', 1),
('Chevrolet Tracker', 'Chevrolet', 'Tracker', 2024, 150000.00, 'https://cdn.motor1.com/images/mgl/6ZKQOe/s3/2024-chevrolet-trax-activ-front-angle.jpg', 'Disponível', 1),
('Honda Civic', 'Honda', 'Civic', 2024, 140000.00, 'https://www.otempo.com.br/content/dam/otempo/editorias/autotempo/2023/9/autotempo-honda-civic-hibrido-ficou-r-15-mil-mais-caro-no-brasil-1708386463.jpeg', 'Disponível', 1),
('Nissan Kicks', 'Nissan', 'Kicks', 2024, 130000.00, 'https://cdn.motor1.com/images/mgl/zx907W/s1/nissan-kicks-exclusive-2024.jpg', 'Disponível', 1),
('Jeep Compass', 'Jeep', 'Compass', 2024, 200000.00, 'https://cdn.motor1.com/images/mgl/P3gRkX/s3/jeep-compass-2024---europa.jpg', 'Disponível', 1),
('Volkswagen Gol', 'Volkswagen', 'Gol', 2024, 80000.00, 'https://cdn.wheel-size.com/automobile/body/volkswagen-gol-2019-2024-1711082687.6563342.jpg', 'Disponível', 1),
('Fiat Argo', 'Fiat', 'Argo', 2024, 90000.00, 'https://s3.agsistema.net/5704/vehicles/1743191/photos/0ro6EmbCGrsfGj7PxKoaWRegtCsRg8WowqEQ.jpg?partner=dealersites', 'Disponível', 1),
('Hyundai Creta', 'Hyundai', 'Creta', 2024, 190000.00, 'https://mundodoautomovelparapcd.com.br/wp-content/uploads/2022/06/creta-n-line-5.jpg', 'Disponível', 1);



-- 4. Criação da tabela carrinho
CREATE TABLE carrinho (
    id_carrinho INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_veiculo INT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES tb_login(id),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(ID_Veiculo)
);

CREATE TABLE AgendaTestDrive (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_veiculo INT NOT NULL,
    data_test_drive DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES tb_login(id), 
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(ID_Veiculo)
);

CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    total_compra DECIMAL(10, 2) NOT NULL,
    data_compra DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tb_login(id)
);

CREATE TABLE avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    avaliacao ENUM('like', 'dislike') NOT NULL,
    data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES tb_login(id)
);



-- 5. Atualizando o is_admin
SET SQL_SAFE_UPDATES = 0; -- Desativa para permitir atualizações
UPDATE tb_login
SET is_admin = TRUE
WHERE email = 'sieiroryan123@gmail.com';
SET SQL_SAFE_UPDATES = 1; -- Reativa após a atualização

-- 6. Inserção em administrador
INSERT INTO administrador (Nome, Email, Senha)
VALUES ('Admin Nome', 'admin@exemplo.com', 'senha123');

-- 8. Criar a trigger
DELIMITER //

CREATE TRIGGER after_tb_login_insert
AFTER INSERT ON tb_login
FOR EACH ROW
BEGIN
    -- Verifica se o usuário é um administrador
    IF NEW.is_admin = 1 THEN
        -- Insere os dados na tabela administrador
        INSERT INTO administrador (nome, email, senha, is_admin)
        VALUES (NEW.nome, NEW.email, NEW.senha, NEW.is_admin);
    END IF;
END;

//

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_tb_login_update
AFTER UPDATE ON tb_login
FOR EACH ROW
BEGIN
    -- Verifica se o is_admin foi alterado para 1
    IF NEW.is_admin = 1 AND OLD.is_admin = 0 THEN
        -- Insere os dados na tabela administrador
        INSERT INTO administrador (nome, email, senha, is_admin)
        VALUES (NEW.nome, NEW.email, NEW.senha, NEW.is_admin);
    END IF;
END;
//

DELIMITER ;


-- 9. Exibir triggers
SHOW TRIGGERS;

-- 10. Limpeza e exclusão de tabelas
SET FOREIGN_KEY_CHECKS = 0; -- Desativa verificação de chaves estrangeiras
DROP TRIGGER IF EXISTS after_tb_login_insert;
DROP TABLE IF EXISTS carrinho;
DROP TABLE IF EXISTS veiculo;
DROP TABLE IF EXISTS administrador;
DROP TABLE IF EXISTS tb_login;
DROP TABLE IF EXISTS AgendaTestDrive;
SET FOREIGN_KEY_CHECKS = 1; -- Reativa verificação de chaves estrangeiras
DROP DATABASE login;

SELECT * FROM tb_login;
SELECT * FROM administrador;
SELECT * FROM veiculo;
SELECT * FROM veiculo WHERE Status = 'Disponivel';
SELECT * FROM carrinho;
SELECT * FROM AgendaTestDrive;
SELECT * FROM avaliacoes;


TRUNCATE TABLE administrador;
TRUNCATE TABLE tb_login;
TRUNCATE TABLE veiculo;
truncate table carrinho;
truncate table AgendaTestDrive;
truncate table Avaliacoes;
truncate table compras;

INSERT INTO tb_login (nome, email, senha, is_admin)
VALUES ('Admin Teste', 'admin@teste.com', 'senha123', 1);

ALTER TABLE tb_login
ADD CONSTRAINT unique_email UNIQUE (email);

SELECT v.*, a.Nome AS AdminNome 
FROM veiculo v 
LEFT JOIN administrador a ON v.id_administrador = a.ID_Administrador;

INSERT INTO carrinho (id_cliente, id_veiculo) 
VALUES (1, 2); 