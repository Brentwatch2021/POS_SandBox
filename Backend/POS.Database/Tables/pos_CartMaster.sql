
````````sql
CREATE TABLE [dbo].[pos_CartMaster] (
    [CartMasterId]                  BIGINT  IDENTITY (1, 1) PRIMARY KEY,
    [UserId]                        INT     NOT NULL,
    [CartMasterStatusId]            TINYINT NOT NULL,
    [CartMasterStatus]              AS CASE [CartMasterStatusId]
                                        WHEN 1 THEN 'Pending'
                                        WHEN 2 THEN 'Completed'
                                        WHEN 3 THEN 'Voided'
                                        ELSE 'Unknown'
                                    END,
    [SubTotal]                      MONEY       NOT NULL DEFAULT 0,
    [VatTotal]                      MONEY       NOT NULL DEFAULT 0,
    [GrandTotal]                    MONEY       NOT NULL DEFAULT 0,
    [CartMasterCreatedAt]           DATETIME    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT FK_CartMaster_Users FOREIGN KEY (UserId) REFERENCES pos_User(UserId)
);
GO
