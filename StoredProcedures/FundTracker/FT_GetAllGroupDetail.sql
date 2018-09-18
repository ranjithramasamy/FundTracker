USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <29 July 2012>
-- Description:	<Retrieves all category group details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_GetAllGroupDetail] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Select all category group details.
	SELECT * FROM [dbo].[GroupMaster] ORDER BY group_id ASC
END