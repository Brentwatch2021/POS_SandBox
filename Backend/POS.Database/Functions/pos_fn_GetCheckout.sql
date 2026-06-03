CREATE FUNCTION dbo.pos_fn_GetCheckout
(
    @UserId INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT sm.Barcode,
         sm.StockMasterName,
         sm.CurrentPrice,
         sm.VatRate,
         cd.CartDetailStatusId,
         cd.Quantity,
         cd.DiscountAmount
    FROM [dbo].[pos_CartDetail] cd
   inner join [dbo].[pos_StockMaster] sm
      on sm.StockMasterId = cd.StockMasterId
   WHERE cd.UserId = @UserId
     AND CartDetailStatusId = 1
   
);
GO