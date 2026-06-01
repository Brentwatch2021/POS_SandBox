CREATE TABLE [dbo].[pos_UserRole] (
    [UserID]                INT NOT NULL,
    [RoleID]                INT NOT NULL,
    PRIMARY KEY             (UserId, RoleId),
    [AssignedAt]            DATETIME        NOT NULL CONSTRAINT DF_pos_UserRole_AssignedAt DEFAULT GETUTCDATE(),
    CONSTRAINT FK_pos_UserRole_pos_User     FOREIGN KEY (UserId) REFERENCES pos_User(UserId),
    CONSTRAINT FK_pos_UserRoles_pos_Role    FOREIGN KEY (RoleId) REFERENCES pos_Role(RoleId)
);
go
