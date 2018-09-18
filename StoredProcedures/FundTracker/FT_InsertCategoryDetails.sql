USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <14 July 2012>
-- Description:	<Insert the new category details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_InsertCategoryDetails]
( 
	@groupKey VARCHAR(50),
	@desctription VARCHAR(50), 
	@defaultType CHAR(1)
)AS
BEGIN
	INSERT INTO [dbo].[CategoryMaster] (group_key, [description], default_account_type, created_date, updated_date )
	VALUES( @groupKey, @desctription, @defaultType, SYSDATETIME(), SYSDATETIME() )
END