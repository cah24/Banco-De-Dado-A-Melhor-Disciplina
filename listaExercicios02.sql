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

CREATE PROCEDURE sp_LivrosAteAno
@AnoPublicacao INT
AS
BEGIN
    SELECT * FROM Livros WHERE AnoPublicacao <= @AnoPublicacao;
END
EXEC sp_LivrosAteAno 2000;

CREATE PROCEDURE sp_TitulosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    DECLARE @Titulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Titulo FROM Livros WHERE Categoria = @Categoria;
    OPEN cur;
    FETCH NEXT FROM cur INTO @Titulo;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @Titulo;
        FETCH NEXT FROM cur INTO @Titulo;
    END
    CLOSE cur;
    DEALLOCATE cur;
END

EXEC sp_TitulosPorCategoria 'Suspense';
