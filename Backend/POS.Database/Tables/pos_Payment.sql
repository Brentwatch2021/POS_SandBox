CREATE TABLE [dbo].[pos_Payment] (
    [PaymentId]                          INT      IDENTITY (1,1)  PRIMARY KEY,
    [CartMasterId]                       BIGINT   NOT NULL,
    [PaymentMethodTypeId]                TinyInt  NOT NULL,
    [Amount]                             MONEY    NOT NULL,
    [PaymentStatusId]                    TINYINT  NOT NULL,
    [PaymentStatus]                      AS CASE  [PaymentStatusId]
                                         WHEN 'Approved' THEN 1
                                         WHEN 'Failed' THEN 2
                                         WHEN 'Refund' THEN 3
                                         ELSE 0
                                         END,
    [PaymentReference]                   AS 'INV-' + RIGHT('000000' + CAST(PaymentId AS VARCHAR(10)), 6),
    [PaymentCreatedAt]                   DATETIME NOT NULL CONSTRAINT DF_Payment_PaymentCreatedAt DEFAULT GETUTCDATE(),
    CONSTRAINT FK_pos_Payment_CartMaster FOREIGN KEY (CartMasterId) REFERENCES pos_CartMaster(CartMasterId),
    CONSTRAINT FK_pos_Payment_pos_PaymentMethodType FOREIGN KEY (PaymentMethodTypeId) REFERENCES pos_PaymentMethodType(PaymentMethodTypeId)
);
GO
