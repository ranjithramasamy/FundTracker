USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <13 November 2012>
-- Description:	<Retrieves all daily expense details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_GetAllDailyExpenseDetails]
(
	@from_date VARCHAR(10), 
	@to_date VARCHAR(10)
) AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Select all expense category details.
	SELECT DEM.id, DEM.expense_date, CM.category_id AS CategoryID, CM.description AS description, DEM.narration, DEM.amount
	FROM [dbo].[DailyExpenseMaster] DEM INNER JOIN [dbo].[CategoryMaster] CM 
		ON DEM.exp_category_id = CM.category_id
	WHERE DEM.expense_date >= @from_date AND DEM.expense_date <= @to_date
	ORDER BY id DESC
END