CREATE TABLE [dbo].[pos_Store] (
  [StoreId]               INT             IDENTITY    (1, 1)      PRIMARY KEY,
  [StoreName]             NVARCHAR(200)   NOT NULL    CONSTRAINT DF_Store_StoreName       DEFAULT '',
  [StoreLocation]         NVARCHAR(255),
  [IsStoreActive]         BIT             NOT NULL CONSTRAINT DF_pos_Store_IsStoreActive      DEFAULT 1,
  [StoreCreatedAt]        DateTime        NOT NULL CONSTRAINT DF_pos_Store_StoreCreatedAt     DEFAULT GetUTCDate()
);
go