 --1. 他網扣永豐與財金入帳開始時間 ：營業日9:10  
UPDATE PARAMETER SET Value='09:10' WHERE NAME='EDI_WORKTIME_START';

--2. 自網扣永豐入他行開始時間：營業日8:00
UPDATE PARAMETER SET Value='08:00' WHERE NAME='START_TIME_MMA2HOST';
--3. 他網扣永豐結束時間：營業日15:30
UPDATE PARAMETER SET Value='15:30' WHERE NAME='HOST_PAYEXT_END_TIME';

--4. 財金入帳結束時間：營業日16:40
UPDATE PARAMETER SET Value='16:40' WHERE NAME='EDI_WORKTIME_END';
UPDATE PARAMETER SET Value='16:40' WHERE NAME='EDI_WORKTIME_BUF_END';

--5. 自網扣永豐入他行結束時間：營業日16:30
UPDATE PARAMETER SET Value='16:30' WHERE NAME='STOP_TIME_MMA2HOST';

GO