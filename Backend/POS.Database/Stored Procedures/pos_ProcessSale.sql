CREATE PROCEDURE dbo.pos_ProcessSale
(
    @UserId              INT,
    @PaymentMethodTypeId TINYINT
)
AS
BEGIN
    SET NOCOUNT ON;

    Declare @CartItems INT
    
    
CREATE TABLE #CartDetails (
    SequenceID          INT IDENTITY(1,1) PRIMARY KEY,
    CartDetailId        BIGINT,
    StockMasterId       BIGINT,
    Quantity            INT,
    LineTotal           INT,
    VatAmount           MONEY,
    UserId			    INT
);


INSERT INTO #CartDetails (CartDetailId, StockMasterId, Quantity, LineTotal, VatAmount, UserId)
     SELECT CartDetailId, StockMasterId, Quantity, LineTotal, VatAmount, UserId
       FROM [dbo].[pos_CartDetail]
      WHERE UserId = @UserId
        AND CartDetailStatusId = 1;
      

DECLARE @CurrentSeq INT = 1;
DECLARE @MaxSeq INT = (SELECT MAX(SequenceID) FROM #CartDetails);

DECLARE @LoopSourceID INT;
DECLARE @LoopData1 VARCHAR(100);
DECLARE @LoopData2 INT;

-- Instead of a cursor that would lock the items use a loop with a temp table to process each item one by one,
-- ensuring that we can handle errors (deadlocks) etc on a per-item basis without affecting the entire transaction.
WHILE @CurrentSeq <= @MaxSeq
BEGIN
    
    Declare @CartDetailId BIGINT,
            @StockMasterId BIGINT,
            @CartQuantity INT,
            @LineTotal MONEY,
            @VatAmount MONEY,
            @CartUserId INT;

    SELECT @CartDetailId = CartDetailId, @StockMasterId = StockMasterId, @CartQuantity = Quantity, @LineTotal = LineTotal, @VatAmount = VatAmount, @CartUserId = UserId  
      FROM #CartDetails
     WHERE SequenceID = @CurrentSeq;

    
    BEGIN TRANSACTION;
    BEGIN TRY
        
      Insert into [dbo].[pos_CartMaster]  ([UserId], [CartMasterStatusId], [SubTotal], [VatTotal], [GrandTotal])
           values (@CartUserId, 2, @LineTotal - @VatAmount, @VatAmount, @LineTotal);
          declare @NewCartMasterId BIGINT = SCOPE_IDENTITY();
     

      Insert into [dbo].[pos_Payment] (CartMasterId, PaymentMethodTypeId, Amount, PaymentStatusId)
           values (@NewCartMasterId, @PaymentMethodTypeId, @LineTotal, 1);
   
      Insert into [dbo].[pos_StockLedger] (StockMasterId, StockMasterMovementTypeId, QuantityChange, CreatedByUserId)
           values (@StockMasterId, 1, -@CartQuantity, @CartUserId); 
    
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        RAISERROR('Error in the sale.', 16, 1);
        RETURN;
    END CATCH;

    SET @CurrentSeq = @CurrentSeq + 1;
END;

DROP TABLE #CartDetails;
END;
go