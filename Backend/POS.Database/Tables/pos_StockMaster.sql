CREATE TABLE [dbo].[pos_StockMaster] (
    [StockMasterId]           INT                 IDENTITY (1,1)                                      PRIMARY KEY,
    [StockMasterName]         VARCHAR(200)        NOT NULL,
    [CurrentPrice]            MONEY               NOT NULL CONSTRAINT DF_StockMaster_CurrentPrice            DEFAULT 0,
    [VatRate]                 DECIMAL(5,2)        NOT NULL CONSTRAINT DF_StockMaster_VatRate                 DEFAULT 0,
    [IsStockMasterActive]     BIT                 NOT NULL CONSTRAINT DF_StockMaster_IsStockMasterActive     DEFAULT 1,
    [StockMasterCreatedAt]    DATETIME            NOT NULL CONSTRAINT DF_StockMaster_StockMasterCreatedAt    DEFAULT GETUTCDATE()

);
GO
