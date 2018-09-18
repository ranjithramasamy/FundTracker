USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <09 June 2013>
-- Description:	<insert daily expense details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_InsertDailyExpenseDetails]
(
	@expense_date DATETIME, 
	@exp_category_id INT,
	@narration VARCHAR(100), 
	@amount DECIMAL(16, 2)
) AS
BEGIN
    -- Insert daily expense details.
	INSERT INTO [dbo].[DailyExpenseMaster] (expense_date, exp_category_id, narration, amount, created_date, updated_date)
	VALUES( @expense_date, @exp_category_id, @narration, @amount, SYSDATETIME(), SYSDATETIME());
END