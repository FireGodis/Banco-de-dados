CREATE TABLE dbo.TaskItem (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(160) NOT NULL,
    IsDone BIT NOT NULL CONSTRAINT DF_TaskItem_IsDone DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_TaskItem_CreatedAt DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.TaskItem (Title) VALUES (N'Documentar consultas SQL');

DECLARE @IsDone BIT = 0;
SELECT Id, Title, IsDone, CreatedAt
FROM dbo.TaskItem
WHERE IsDone = @IsDone
ORDER BY CreatedAt DESC;
