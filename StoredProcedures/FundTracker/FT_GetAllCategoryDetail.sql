USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <11 July 2012>
-- Description:	<Retrieves all expense category details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_GetAllCategoryDetail] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Select all expense category details.
	SELECT CM.category_id, CM.group_key AS group_key, CM.description, 
		CASE  
			WHEN CHARINDEX(',', CM.group_key) = 0 THEN GM.description
			ELSE 'Multiple'
		END AS group_name,	
		CASE CM.default_account_type 
			WHEN 'D' THEN 'Dr'
			ELSE 'Cr'
		END AS default_account_type	
	FROM [dbo].[CategoryMaster] CM LEFT OUTER JOIN [dbo].[GroupMaster] GM 
		ON CM.group_key = GM.group_key
	ORDER BY category_id ASC
END