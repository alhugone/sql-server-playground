DECLARE @cnt INT = 0;
PRINT 'begin of loop'
WHILE @cnt < 300
BEGIN
	BEGIN TRY
	   RAISERROR (N'tekst', @cnt, 1)
	   PRINT 'I''M HERE'
	END TRY
	BEGIN CATCH
		PRINT CONCAT(N'catch block ', ERROR_STATE(), ' ', ERROR_SEVERITY(),' ', @cnt)
	END CATCH
	SET @cnt=@cnt+1
END;	
PRINT 'end of loop'
