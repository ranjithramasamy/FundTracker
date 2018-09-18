USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <20 March 2014>
-- Description:	<delete expense details by given id.>
-- =============================================
CREATE PROCEDURE [dbo].[FT_DeleteDailyExpenseDetail]
( 
	@expId INT
)AS
BEGIN
    -- Delete expense details by given ID.
	DELETE FROM [dbo].[DailyExpenseMaster] WHERE id = @expId
END