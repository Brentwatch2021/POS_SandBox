CREATE TABLE dbo.Product (
    [ProductId]           INT                 IDENTITY (1,1)                                      PRIMARY KEY,

    [Barcode]             VARCHAR(50)         NOT NULL CONSTRAINT DF_Products_Barcode             DEFAULT '',
    [ProductName]         VARCHAR(200)        NOT NULL,

    [CurrentPrice]        Money               NOT NULL CONSTRAINT DF_Products_CurrentPrice        DEFAULT 0,
    [VatRate]             DECIMAL(5,2)        NOT NULL CONSTRAINT DF_Products_VatRate             DEFAULT 0,

    [IsProductActive]     BIT                 NOT NULL CONSTRAINT DF_Products_IsProductActive     DEFAULT 1,
    [ProductCreatedAt]    DATETIME            NOT NULL CONSTRAINT DF_Products_ProductCreatedAt    DEFAULT GETDATE()

);