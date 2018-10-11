BEGIN TRAN
    --SHOULD RETURN TWO ROWS GENERATED IN CREATE TABLE SCRIPT
    -- SELECT NO.1
    SELECT *
    FROM TemporalSample
    FOR SYSTEM_TIME ALL

    UPDATE TemporalSample
    SET Txt='2';
    WAITFOR DELAY '00:00:01';

    UPDATE TemporalSample
    SET Txt='3';
    WAITFOR DELAY '00:00:01';

    UPDATE TemporalSample
    SET Txt='4';
    WAITFOR DELAY '00:00:01';

    UPDATE TemporalSample
    SET Txt='5';
    WAITFOR DELAY '00:00:01';

    --SHOULD RETURN 3 ROWS--
    -- SELECT NO.2
    SELECT *
    FROM TemporalSample
    FOR SYSTEM_TIME all

    --SHOULD RETURN 5 ROWS--
    -- SELECT NO.3
    SELECT *
    FROM TemporalSampleHistory
ROLLBACK