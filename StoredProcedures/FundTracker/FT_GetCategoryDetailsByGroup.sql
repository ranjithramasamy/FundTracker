USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <11 Nov 2012>
-- Description:	<Retrieves category group details by given group ID.>
-- =======================================================================
ALTER PROCEDURE [dbo].[FT_GetCategoryDetailsByGroup]
( 
	@group_key VARCHAR(3)
)AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Select all category group details.
	SELECT [category_id], [description], 
		CASE default_account_type 
			WHEN 'D' THEN 'Dr'
			ELSE 'Cr'
		END AS default_account_type FROM [dbo].[CategoryMaster]
	WHERE group_key LIKE '%' + @group_key + '%'
END