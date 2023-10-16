CREATE FUNCTION total_livros_por_genero(genero_nome VARCHAR) RETURNS INT
BEGIN
    DECLARE total INT;
    
    SELECT COUNT(*) INTO total
    FROM Livros
    WHERE Genero = genero_nome;
    
    RETURN total;
END;
CREATE FUNCTION listar_livros_por_autor(primeiro_nome VARCHAR, ultimo_nome VARCHAR) RETURNS TABLE
BEGIN
    DECLARE autor_id INT;
    
    SELECT AutorID INTO autor_id
    FROM Autores
    WHERE PrimeiroNome = primeiro_nome AND UltimoNome = ultimo_nome;
    
    RETURN (
        SELECT Livros.Titulo
        FROM Livro_Autor
        JOIN Livros ON Livro_Autor.LivroID = Livros.LivroID
        WHERE Livro_Autor.AutorID = autor_id
    );
END;

CREATE FUNCTION atualizar_resumos()
BEGIN
    DECLARE livro_id INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR
        SELECT LivroID
        FROM Livros;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO livro_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        UPDATE Livros
        SET Resumo = CONCAT(Resumo, ' Este é um excelente livro!')
        WHERE LivroID = livro_id;
    END LOOP;
    
    CLOSE cur;
END;
CREATE FUNCTION media_livros_por_editora() RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    
    SELECT COUNT(*) INTO total_livros FROM Livros;
    SELECT COUNT(DISTINCT Editora) INTO total_editoras FROM Livros;
    
    RETURN total_livros / total_editoras;
END;
CREATE FUNCTION autores_sem_livros() RETURNS TABLE
BEGIN
    RETURN (
        SELECT Autores.PrimeiroNome, Autores.UltimoNome
        FROM Autores
        WHERE AutorID NOT IN (SELECT AutorID FROM Livro_Autor)
    );
END;

