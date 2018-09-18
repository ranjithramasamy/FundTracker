USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <19 May 2012>
-- Description:	<Update the new member details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_UpdateMemberDetails]
( 
	@memberid INT,
	@firstName VARCHAR(50), 
	@lastName VARCHAR(50), 
	@nickName VARCHAR(50),
	@gender CHAR(1), 
	@address VARCHAR(250), 
	@city VARCHAR(15),
	@pincode VARCHAR(10), 
	@telephoneNo VARCHAR(12), 
	@mobileNo VARCHAR(10),
	@active BIT
)AS
BEGIN
	UPDATE [dbo].[MembersMaster] 
	SET first_name = @firstName, last_name = @lastName, nick_name = @nickName, address = @address, gender = @gender, city = @city,
		pincode = @pincode, telephone_no = @telephoneNo, mobile_no = @mobileNo, active = @active, updated_date = SYSDATETIME()
	WHERE member_id = @memberid
END