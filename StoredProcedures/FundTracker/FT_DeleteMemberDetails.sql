USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <15 July 2012>
-- Description:	<delete member details by given member id.>
-- =============================================
CREATE PROCEDURE [dbo].[FT_DeleteMemberDetails]
( 
	@memberid INT
)AS
BEGIN
    -- Delete member details by given ID.
	DELETE FROM [dbo].[MembersMaster] WHERE member_id = @memberid
END