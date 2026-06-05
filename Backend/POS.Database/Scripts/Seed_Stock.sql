insert into [dbo].[pos_PaymentMethodType] ([PaymentMethodTypeName])
values
('Cash'),
('Card'),
('MobilePay'),
('GiftCard'),
('Other');
go

----- Seed StockMaster

SET NOCOUNT ON;

DECLARE @BatchSize INT = 1000;
DECLARE @MaxRows BIGINT = 10000;

DECLARE @Current BIGINT = 1;

WHILE @Current <= @MaxRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
            + (@Current - 1) AS n
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )

    INSERT INTO pos_StockMaster
    (
        StoreId,
        StockMasterName,
        Barcode,
        CurrentPrice,
        VatRate,
        IsStockMasterActive
    )
    SELECT
        s.StoreId,

        CASE (n % 10)
            WHEN 0 THEN 'T-Shirt'
            WHEN 1 THEN 'Slim Fit Jeans'
            WHEN 2 THEN 'Hoodie'
            WHEN 3 THEN 'Denim Jacket'
            WHEN 4 THEN 'Sneakers'
            WHEN 5 THEN 'Chino Pants'
            WHEN 6 THEN 'Polo Shirt'
            WHEN 7 THEN 'Cargo Shorts'
            WHEN 8 THEN 'Sweatshirt'
            WHEN 9 THEN 'Running Jacket'
        END
        + ' - Model ' + CAST(n AS VARCHAR(20)),

        'BC'
        + CAST(s.StoreId AS VARCHAR(5))
        + RIGHT('0000000000' + CAST(n AS VARCHAR(20)), 10),

        CAST(
            50 + ((n * 13) % 145000) / 100.0
            AS DECIMAL(18,2)
        ),

        0.15,
        1

    FROM pos_Store s
    CROSS JOIN Numbers;

    PRINT CONCAT('Inserted batch starting at: ', @Current);

    SET @Current += @BatchSize;

END
go

-- Seed StockLedger with random movements for each StockMaster

INSERT INTO pos_StockLedger
(
    StockMasterId,
    StockMasterMovementTypeId,
    QuantityChange,
    CreatedByUserId
)
SELECT
    sm.StockMasterId,
    3, -- GRV for all entries to simulate stock additions

    ABS(CHECKSUM(NEWID())) % 500 + 1,

    1

FROM pos_StockMaster sm;
go