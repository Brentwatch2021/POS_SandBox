CREATE TABLE [dbo].[pos_StockLedger] (
    [StoreId]                           INT NOT NULL,
    [StockMasterId]                     INT NOT NULL,
    [StockMasterMovementTypeId]         TINYINT NOT NULL, 
    [StockMasterMovementType]           AS CASE [StockMasterMovementTypeId]
                                        WHEN 1 THEN 'Sale'
                                        WHEN 2 THEN 'Void'
                                        WHEN 2 THEN 'GRV'
                                        ELSE 'Unknown'
                                        END,
    [QuantityChange]                    INT NOT NULL,
    [CartDetailId]                      BIGINT NOT NULL,
    [CreatedByUserId]                   INT,
    [StockLedgerCreatedAt]              DATETIME NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT FK_pos_StockLedger_pos_Store FOREIGN KEY (StoreId) REFERENCES pos_StockMaster(StockMasterId),
    CONSTRAINT FK_pos_StockLedger_pos_StockMaster FOREIGN KEY (StockMasterId) REFERENCES pos_StockMaster(StockMasterId),
    CONSTRAINT FK_pos_StockLedger_pos_CartDetail  FOREIGN KEY (CartDetailId) REFERENCES pos_CartDetail(CartDetailId)
);
GO
