CREATE PROCEDURE sp_ListarAutores
AS
BEGIN
    SELECT * FROM Autores;
END
EXEC sp_ListarAutores;

CREATE PROCEDURE sp_LivrosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    SELECT * FROM Livros WHERE Categoria = @Categoria;
END
EXEC sp_LivrosPorCategoria 'Aventura';

CREATE PROCEDURE sp_ContarLivrosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    SELECT COUNT(*) AS 'Total' FROM Livros WHERE Categoria = @Categoria;
END
EXEC sp_ContarLivrosPorCategoria 'Romance';

CREATE PROCEDURE sp_VerificarLivrosCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Livros WHERE Categoria = @Categoria)
        PRINT 'Categoria possui livros.';
    ELSE
        PRINT 'Categoria não possui livros.';
END
EXEC sp_VerificarLivrosCategoria 'Ficção Científica';


