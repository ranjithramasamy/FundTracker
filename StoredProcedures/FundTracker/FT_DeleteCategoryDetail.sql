USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <15 July 2012>
-- Description:	<Delete category details by given ID.>
-- =============================================
CREATE PROCEDURE [dbo].[FT_DeleteCategoryDetail]
( 
	@categoryid INT
)AS
BEGIN
    -- Delete category details by given ID.
	DELETE FROM [dbo].[CategoryMaster] WHERE category_id = @categoryid
END