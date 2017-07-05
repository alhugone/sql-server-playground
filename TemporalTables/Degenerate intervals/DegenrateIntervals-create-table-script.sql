--ALTER TABLE TemporalSample SET ( SYSTEM_VERSIONING = OFF )
--DROP TABLE TemporalSample
--DROP TABLE TemporalSampleHistory
CREATE TABLE TemporalSample
(    
     Id int NOT NULL Primary Key,
	 Txt varchar(50) NOT NULL,
	 SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
	 SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
	 PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)     
)   
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TemporalSampleHistory));

--INSERT ONE ROW--
INSERT INTO TemporalSample (Id,Txt) 
VALUES (1,'')
-- UPDATE INSERTED ROW TO GENERATE HISTORY ROW--
UPDATE TemporalSample
SET Txt='1'

--SHOULD RETURN TWO ROWS--
SELECT *
FROM TemporalSample
FOR SYSTEM_TIME ALL
