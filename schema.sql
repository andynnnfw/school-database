CREATE DATABASE escola;
USE escola;

-- =========================================
-- 2. CRIAR AS TABELAS (DDL)
-- =========================================
CREATE TABLE professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    email        VARCHAR(100) UNIQUE,
    telefone     VARCHAR(20)
);

CREATE TABLE curso (
    id_curso      INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    carga_horaria INT
);

CREATE TABLE aluno (
    id_aluno        INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    email           VARCHAR(100),
    id_curso        INT NOT NULL
);

CREATE TABLE curso_professor (
    id_curso     INT NOT NULL,
    id_professor INT NOT NULL,
    PRIMARY KEY (id_curso, id_professor)
);

-- =========================================
-- 3. CRIAR OS RELACIONAMENTOS (DDL)
-- =========================================

ALTER TABLE aluno
    ADD CONSTRAINT fk_aluno_curso
    FOREIGN KEY (id_curso) REFERENCES curso (id_curso);

ALTER TABLE curso_professor
    ADD CONSTRAINT fk_cp_curso
    FOREIGN KEY (id_curso) REFERENCES curso (id_curso);

ALTER TABLE curso_professor
    ADD CONSTRAINT fk_cp_professor
    FOREIGN KEY (id_professor) REFERENCES professor (id_professor);

-- =========================================
-- INSERIR DADOS (DML)
-- =========================================
INSERT INTO professor (nome, email, telefone) VALUES
('Jonathan',      'jonathan@escola.com',      '(11) 99999-1111'),
('Fabio Claret',  'fabio.claret@escola.com',  '(11) 99999-2222'),
('Paulo Rogerio', 'paulo.rogerio@escola.com', '(11) 99999-3333');

INSERT INTO curso (nome, carga_horaria) VALUES
('Banco de Dados',  80),
('Programação Web', 120);


INSERT INTO curso_professor (id_curso, id_professor) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);

INSERT INTO aluno (nome, data_nascimento, email, id_curso) VALUES
('Anderson', '2005-03-12', 'anderson@email.com', 1),
('Emanuel',  '2004-07-25', 'emanuel@email.com',  1),
('Matheus',  '2005-11-02', 'matheus@email.com',  2),
('Luis',     '2004-01-30', 'luis@email.com',     2),
('Fabricio', '2005-09-18', 'fabricio@email.com', 1);

-- =========================================
-- 4. CONSULTA: ALUNOS COM CURSO E PROFESSORES (DML)
-- =========================================
SELECT
    a.nome AS aluno,
    c.nome AS curso,
    GROUP_CONCAT(p.nome ORDER BY p.id_professor SEPARATOR ' e ') AS professores
FROM aluno a
INNER JOIN curso c            ON a.id_curso      = c.id_curso
INNER JOIN curso_professor cp ON c.id_curso      = cp.id_curso
INNER JOIN professor p        ON cp.id_professor = p.id_professor
GROUP BY a.id_aluno, a.nome, c.nome
ORDER BY a.nome;