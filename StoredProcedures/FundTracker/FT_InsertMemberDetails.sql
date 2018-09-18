USE [FundTracker]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ranjith Ramasamy>
-- Create date: <19 May 2012>
-- Description:	<Insert the new member details.>
-- =============================================
ALTER PROCEDURE [dbo].[FT_InsertMemberDetails]
( 
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
	INSERT INTO [dbo].[MembersMaster] (first_name, last_name, nick_name, address, gender, city, pincode, telephone_no, mobile_no, active, created_date, updated_date)
	VALUES( @firstName, @lastName, @nickName, @address, @gender, @city, @pincode, @telephoneNo, @mobileNo, @active, SYSDATETIME(), SYSDATETIME());
END