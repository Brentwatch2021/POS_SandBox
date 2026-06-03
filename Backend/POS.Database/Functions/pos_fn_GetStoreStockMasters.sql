CREATE FUNCTION [dbo].[pos_fn_GetStoreStockMasters]
(
    @SearchTerm NVARCHAR(100) = NULL,
    @StoreId INT,
    @PageNumber INT,
    @PageSize INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT Barcode,
         StockMasterName,
         CurrentPrice,
         VatRate,
         COUNT(*) OVER() AS TotalCount 
    FROM [dbo].[pos_StockMaster]
   WHERE StoreId = @StoreId
     AND isStockMasterActive = 1
      OR StockMasterName LIKE '%' + ISNULL(@SearchTerm, '') + '%'
   ORDER BY StockMasterId ASC 
  OFFSET (@PageNumber - 1) * @PageSize ROWS
   FETCH NEXT @PageSize ROWS ONLY
);
GO