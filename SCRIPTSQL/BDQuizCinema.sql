CREATE DATABASE IF NOT EXISTS quiz_cinema_db;
USE quiz_cinema_db;


/* Armazena cada participação/entrevistado e as respostas das 8 questões (valores de 1 a 4) */
CREATE TABLE IF NOT EXISTS participacoes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome_entrevistado VARCHAR(120) NOT NULL,
    q1 INT NOT NULL CHECK (q1 BETWEEN 1 AND 4),
    q2 INT NOT NULL CHECK (q2 BETWEEN 1 AND 4),
    q3 INT NOT NULL CHECK (q3 BETWEEN 1 AND 4),
    q4 INT NOT NULL CHECK (q4 BETWEEN 1 AND 4),
    q5 INT NOT NULL CHECK (q5 BETWEEN 1 AND 4),
    q6 INT NOT NULL CHECK (q6 BETWEEN 1 AND 4),
    q7 INT NOT NULL CHECK (q7 BETWEEN 1 AND 4),
    q8 INT NOT NULL CHECK (q8 BETWEEN 1 AND 4),
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB ;

