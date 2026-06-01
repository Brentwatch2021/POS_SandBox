CREATE TABLE [dbo].[pos_User] (
    [UserId]                INT             IDENTITY    (1, 1)      PRIMARY KEY,
    [StoreID]               INT             NOT NULL,
    [Username]              NVARCHAR(50)    NOT NULL UNIQUE,
    [PasswordHash]          VARBINARY(32)   NOT NULL,
    [FullName]              NVARCHAR(100)   NOT NULL,
    [IsUserActive]          BIT             NOT NULL CONSTRAINT DF_pos_User_IsUserActive  DEFAULT 1,
    [UserCreatedAt]         DATETIME        NOT NULL CONSTRAINT DF_pos_User_UserCreatedAt DEFAULT GETUTCDATE(),
    CONSTRAINT              FK_Users_Store  FOREIGN KEY (StoreId)                         REFERENCES pos_Store(StoreId)
);
go