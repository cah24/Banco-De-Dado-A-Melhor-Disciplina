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
