USE [FundTracker]
GO
/****** Object:  StoredProcedure [dbo].[FT_CheckAuthorisedUser]    Script Date: 05/19/2012 01:34:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <13 May 2012>
-- Description:	<Check weather the given username and password is valid or not.
--				 If valid, return 1 or if invalid, return 0>
-- =============================================
ALTER PROCEDURE [dbo].[FT_CheckAuthorisedUser] 
( 
	@uname VARCHAR(24), 
	@pwd VARCHAR(16), 
	@isValid INT OUTPUT
)AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Validate given username & password matching with our stored data.
	SELECT @isValid = count(*) FROM [dbo].[LoginMaster] 
		WHERE username = @uname AND password = @pwd
END
