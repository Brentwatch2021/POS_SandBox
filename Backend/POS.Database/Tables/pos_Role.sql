CREATE TABLE [dbo].[pos_Role] (
    [RoleId]                INT             IDENTITY    (1, 1)      PRIMARY KEY,
    [RoleName]              NVARCHAR(50)    NOT NULL, 
    [IsRoleActive]          BIT             NOT NULL CONSTRAINT DF_pos_Role_IsRoleActive DEFAULT 1,
    [RoleCreatedAt]         DATETIME        NOT NULL CONSTRAINT DF_pos_Role_RoleCreatedAt DEFAULT    GETUTCDATE(),
);
go
