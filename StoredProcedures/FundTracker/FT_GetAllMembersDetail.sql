USE [FundTracker]
GO
/****** Object:  StoredProcedure [dbo].[FT_GetAllMembersDetail]    Script Date: 05/19/2012 01:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <13 May 2012>
-- Description:	<Retrieves all members detail.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_GetAllMembersDetail] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Validate given username & password matching with our stored data.
	SELECT * FROM [dbo].[MembersMaster] ORDER BY member_id DESC
END