CREATE PROCEDURE dbo.pos_AddItemToCart
(
    @Barcode         VARCHAR(255),
    @UserId          INT,
    @Quantity        INT,
    @DiscountAmount   MONEY
)
AS
BEGIN
    SET NOCOUNT ON;

    Declare @StockMasterId INT,
            @CurrentPrice MONEY,
            @VatRate DECIMAL(5,2),
            @IsStockMasterActive BIT;

     SELECT @StockMasterId = StockMasterId, @CurrentPrice = CurrentPrice, @VatRate = VatRate, @IsStockMasterActive = IsStockMasterActive
       FROM [dbo].[pos_StockMaster]
      WHERE Barcode = @Barcode;
     
     if(@IsStockMasterActive <> 1)
     BEGIN
        RAISERROR('The item with the provided barcode is not active.', 16, 1);
        RETURN;
     END

     INSERT INTO [dbo].[pos_CartDetail] ([StockMasterId], [UserId], [CartDetailStatusId], [Quantity], [UnitPrice], [DiscountAmount], [VatAmount], [LineTotal])
          values (@StockMasterId, @UserId, 1, @Quantity, @CurrentPrice, @DiscountAmount, (@CurrentPrice * @Quantity - @DiscountAmount) * @VatRate, (@CurrentPrice * @Quantity - @DiscountAmount) * (1 + @VatRate));

END;
GO
