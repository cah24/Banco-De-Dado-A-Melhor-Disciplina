CREATE PROCEDURE sp_ListarAutores
AS
BEGIN
    SELECT * FROM Autores;
END
EXEC sp_ListarAutores;

