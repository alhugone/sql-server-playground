DECLARE @cnt INT = 0;
PRINT 'begin of loop'
WHILE @cnt < 11
BEGIN
	BEGIN TRY
	   RAISERROR (N'tekst', @cnt, 1)
	END TRY
	BEGIN CATCH
		PRINT CONCAT(N'catch block ', @cnt)
	END CATCH
	SET @cnt=@cnt+1
END;	
PRINT 'end of loop'
