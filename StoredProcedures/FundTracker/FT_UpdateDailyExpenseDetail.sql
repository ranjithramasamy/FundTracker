USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <20 March 2014>
-- Description:	<Update the existing expense details.>
-- =============================================
CREATE PROCEDURE [dbo].[FT_UpdateDailyExpenseDetail]
( 
	@expId INT,
	@expense_date DATETIME, 
	@exp_category_id INT,
	@narration VARCHAR(100), 
	@amount DECIMAL(16, 2)
)AS
BEGIN
	UPDATE [dbo].[DailyExpenseMaster] 
	SET expense_date = @expense_date, exp_category_id = @exp_category_id, narration = @narration, amount = @amount, updated_date = SYSDATETIME()
	WHERE id = @expId
END