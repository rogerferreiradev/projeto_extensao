CREATE TABLE autores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE editoras (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);

CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

CREATE TABLE livros (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor_id INTEGER REFERENCES autores(id),
    ano_publicacao INTEGER,
    genero VARCHAR(50),
    disponivel BOOLEAN NOT NULL DEFAULT TRUE,
    editora_id INTEGER REFERENCES editoras(id)
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE emprestimos (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(id),
    livro_id INTEGER REFERENCES livros(id),
    data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    data_devolucao DATE
);

CREATE TABLE livros_categorias (
    livro_id INTEGER REFERENCES livros(id) ON DELETE CASCADE,
    categoria_id INTEGER REFERENCES categorias(id) ON DELETE CASCADE,
    PRIMARY KEY (livro_id, categoria_id)
);

INSERT INTO autores (nome, nacionalidade) VALUES 
('José da Silva', 'Brasileira'),
('Maria de Souza', 'Portuguesa'),
('Paulo Pereira', 'Brasileira');

INSERT INTO editoras (nome, endereco, telefone) VALUES 
('Editora Tecnologia', 'Rua A, 123', '81990000001'),
('Editora Educação', 'Rua B, 456', '81990000002');

INSERT INTO categorias (nome, descricao) VALUES 
('Tecnologia', 'Livros relacionados à tecnologia e informática'),
('Educação', 'Livros sobre métodos e teorias educacionais'),
('Ficção', 'Livros de literatura ficcional e romances');

INSERT INTO livros (titulo, autor_id, ano_publicacao, genero, editora_id) VALUES 
('Banco de Dados: Teoria e Prática', 1, 2020, 'Tecnologia', 1),
('Aventuras na Programação', 2, 2018, 'Educação', 2),
('Segurança em Sistemas', 3, 2021, 'Tecnologia', 1);

INSERT INTO usuarios (nome, email, telefone) VALUES 
('Ana Silva', 'ana.silva@email.com', '81990000000'),
('Bruno Costa', 'bruno.costa@email.com', '81990000001'),
('Carla Souza', 'carla.souza@email.com', '81990000002');

INSERT INTO livros (titulo, autor_id, ano_publicacao, genero, editora_id) VALUES 
('Banco de Dados: Teoria e Prática', 1, 2020, 'Tecnologia', 1),
('Aventuras na Programação', 2, 2018, 'Educação', 2),
('Segurança em Sistemas', 3, 2021, 'Tecnologia', 1);

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM livros WHERE id = 2 AND disponivel = TRUE) THEN
        INSERT INTO emprestimos (usuario_id, livro_id) VALUES (1, 2);
        UPDATE livros SET disponivel = FALSE WHERE id = 2;
    END IF;
END $$;

SELECT * FROM usuarios;
SELECT * FROM livros WHERE disponivel = TRUE;
SELECT * FROM emprestimos WHERE usuario_id = 1;
