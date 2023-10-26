CREATE TRIGGER trg_Auditoria_Insert_Cliente
ON clientes
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES ('Um novo cliente foi inserido em ' + CONVERT(VARCHAR, GETDATE()))
END

CREATE TRIGGER trg_Auditoria_Delete_Cliente
ON clientes
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO Auditoria (mensagem)
    SELECT 'Alguém tentou excluir o cliente ' + nome + ' em ' + CONVERT(VARCHAR, GETDATE())
    FROM deleted
END
CREATE TRIGGER trg_Auditoria_Update_Cliente
ON clientes
AFTER UPDATE
AS
BEGIN
    IF UPDATE (nome)
    BEGIN
        INSERT INTO Auditoria (mensagem)
        SELECT 'O nome do cliente foi alterado de ' + d.nome + ' para ' + i.nome + ' em ' + CONVERT(VARCHAR, GETDATE())
        FROM inserted i INNER JOIN deleted d ON i.id = d.id
    END
END
CREATE TRIGGER trg_Validar_Nome_Cliente
ON clientes
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE nome = '' OR nome IS NULL)
    BEGIN
        INSERT INTO Auditoria (mensagem)
        SELECT 'Alguém tentou atualizar o nome do cliente ' + d.nome + ' para uma string vazia ou NULL em ' + CONVERT(VARCHAR, GETDATE())
        FROM inserted i INNER JOIN deleted d ON i.id = d.id 
        WHERE i.nome = '' OR i.nome IS NULL
    END 
    ELSE 
    BEGIN 
    END 
END 
CREATE TRIGGER trg_Atualizar_Estoque_Produto
ON Pedidos
AFTER INSERT 
AS 
BEGIN 
    UPDATE p SET estoque = estoque - i.quantidade 
    FROM Produtos p INNER JOIN inserted i ON p.id = i.produto_id 

    INSERT INTO Auditoria (mensagem) 
    SELECT 'O estoque do produto ' + p.nome + ' ficou abaixo de 5 unidades em ' + CONVERT(VARCHAR, GETDATE()) 
    FROM Produtos p INNER JOIN inserted i ON p.id = i.produto_id 
    WHERE p.estoque < 5 
END 
