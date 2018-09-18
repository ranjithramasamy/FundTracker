USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <14 July 2012>
-- Description:	<Update the existing category details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_UpdateCategoryDetails]
( 
	@categoryid INT,
	@groupKey VARCHAR(50),
	@description VARCHAR(50),
	@defaultType CHAR(1)
)AS
BEGIN
	UPDATE [dbo].[CategoryMaster] 
	SET group_key = @groupKey, description = @description, default_account_type = @defaultType, updated_date = SYSDATETIME()
	WHERE category_id = @categoryid
END