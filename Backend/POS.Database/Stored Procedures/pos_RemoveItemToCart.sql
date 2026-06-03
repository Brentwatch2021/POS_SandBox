CREATE PROCEDURE [dbo].[pos_RemoveItemToCart]
(
    @Barcode         VARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

     Delete
       FROM [dbo].[pos_StockMaster]
      WHERE Barcode = @Barcode;
     
END;
GO