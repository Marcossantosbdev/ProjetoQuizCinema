-- Banco de dados do projeto ProjPesqQuiz
-- Execute no phpMyAdmin (aba SQL) ou no MySQL Workbench antes de rodar o projeto.

CREATE DATABASE IF NOT EXISTS quizbd
    CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE quizbd;

CREATE TABLE IF NOT EXISTS participacao (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    r1   TINYINT NOT NULL,
    r2   TINYINT NOT NULL,
    r3   TINYINT NOT NULL,
    r4   TINYINT NOT NULL,
    r5   TINYINT NOT NULL,
    r6   TINYINT NOT NULL,
    r7   TINYINT NOT NULL,
    r8   TINYINT NOT NULL,
    CHECK (r1 BETWEEN 1 AND 4), CHECK (r2 BETWEEN 1 AND 4),
    CHECK (r3 BETWEEN 1 AND 4), CHECK (r4 BETWEEN 1 AND 4),
    CHECK (r5 BETWEEN 1 AND 4), CHECK (r6 BETWEEN 1 AND 4),
    CHECK (r7 BETWEEN 1 AND 4), CHECK (r8 BETWEEN 1 AND 4)
);

-- (opcional) dados de exemplo para testar os relatórios
INSERT INTO participacao (nome,r1,r2,r3,r4,r5,r6,r7,r8) VALUES
    ('Ana Souza',      2,3,2,3,2,4,1,2),
    ('Bruno Lima',     2,3,1,3,2,4,2,1),
    ('Carla Mendes',   1,3,2,1,2,4,1,2),
    ('Diego Ferreira', 2,2,2,3,3,4,1,2);
