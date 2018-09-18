
DECLARE @isValid int
EXEC sp_CheckAuthorisedUser @uname = 'ranjith', @pwd = 'rama1samy', @isValid = @isValid OUTPUT
SELECT @isValid