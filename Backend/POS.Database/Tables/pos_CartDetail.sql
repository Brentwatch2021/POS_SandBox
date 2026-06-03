CREATE TABLE [dbo].[pos_CartDetail] (
    [CartDetailId]                  BIGINT  IDENTITY (1, 1) PRIMARY KEY,
    [CartMasterId]                  BIGINT  NULL,
    [StockMasterId]                 INT     NOT NULL,
    [CartDetailStatusId]            TinyInt NOT NULL,
    [CartDetailStatus]              AS CASE [CartDetailStatusId]
                                       WHEN 1 THEN 'Pending'
                                       WHEN 2 THEN 'Completed'
                                       WHEN 3 THEN 'Voided'
                                       ELSE 'Unknown'
                                    END,
    [Quantity]                      INT     NOT NULL,
    [UnitPrice]                     MONEY   NOT NULL,
    [DiscountAmount]                MONEY   NOT NULL,
    [VatAmount]                     MONEY   NOT NULL CONSTRAINT DF_pos_CartDetail_VatAmount DEFAULT 0,
    [LineTotal]                     MONEY   NOT NULL,
    CONSTRAINT FK_CartDetail_CartMaster FOREIGN KEY (CartMasterId) REFERENCES pos_CartMaster(CartMasterId),
    CONSTRAINT FK_CartDetail_StockMaster FOREIGN KEY (StockMasterId) REFERENCES pos_StockMaster(StockMasterId)
);
GO
