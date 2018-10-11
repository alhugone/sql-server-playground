RAISERROR( 'Second message.', 0, 1 ) WITH NOWAIT;  -- sends immedietely
RAISERROR( 'First message.', 0, 1 ) ;  -- sends at the end asfter WAITFOR
WAITFOR DELAY '00:00:05'; 
go;

RAISERROR( 'First message.', 0, 1 ) ; 
RAISERROR( 'Second message.', 0, 1 ) WITH NOWAIT;  -- sends immedietely with previous 
WAITFOR DELAY '00:00:05'; 
go;