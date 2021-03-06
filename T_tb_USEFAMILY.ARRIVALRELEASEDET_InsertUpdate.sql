-- =============================================
-- Author:	Frendy Lio
-- Date: 4/12/2020
-- Description:	Insert or Update Trigger that will insert that will insert a row for the \[KioskCheckIn].[BackDisplayTbl]
--					Will insert only if a Pet has arrived or not (ARRIVALDATE)
-- =============================================

CREATE TRIGGER [USEFAMILY].[T_tb_USEFAMILY.ARRIVALRELEASEDET_InsertUpdate]
	ON [USEFAMILY].[ARRIVALRELEASEDET]
	FOR INSERT, UPDATE

AS 

DECLARE @AuditType as varchar(10)
DECLARE @whatisError AS VARCHAR(100)

--------------------
-- If Update, check if there is ARRIVALDATE, If yes, insert in the BackDisplayTbl if it is not there
--------------------
	IF		EXISTS ( SELECT * FROM DELETED ) 
		AND	( SELECT TOP 1 ARRIVALDATE FROM INSERTED) IS NOT NULL 
	BEGIN
		IF NOT EXISTS(
			SELECT 
				*
			FROM [KioskCheckIn].[BackDisplayTbl] BDTbl
			-------------------------------------
			INNER JOIN INSERTED Itbl ON 
			-------------------------------------
				BDTbl.ARRIVALRELEASEDETKEY = Itbl.ARRIVALRELEASEDETKEY
			-------------------------------------
		)
		INSERT INTO [KioskCheckIn].[BackDisplayTbl](
			[ARRIVALRELEASEDETKEY],
			[Is_Arrived],
			[Is_Inspected],
			[Is_Released],
			[ColourID],
			[TimeCreated],
			[Is_Completed]
		)
		SELECT
			[ARRIVALRELEASEDETKEY],
			0,
			0,
			0,
			1,
			getdate(),
			0
		FROM INSERTED

		--Error check
		if @@ERROR <> 0
		Begin
			set @whatisError = 'Error related to [T_tb_USEFAMILY.ARRIVALRELEASEDET_InsertUpdate]'
			goto errorcode
		End
	END

	--------------------
	-- If we update the ARRIVALDATE TO NULL, delete row
	--------------------
	ELSE IF	EXISTS ( SELECT * FROM DELETED ) 
		AND	( SELECT TOP 1 ARRIVALDATE FROM INSERTED) IS NULL 
	BEGIN
		DELETE FROM [KioskCheckIn].[BackDisplayTbl]
		WHERE ARRIVALRELEASEDETKEY IN ( SELECT ARRIVALRELEASEDETKEY FROM INSERTED)
	END
	
	--------------------
	-- If new row and Arrivaldate is not null, insert into backdisplay
	-- Insert
	--------------------
	ELSE IF	NOT EXISTS ( SELECT * FROM DELETED ) 
		AND	( SELECT TOP 1 ARRIVALDATE FROM INSERTED) IS NOT NULL 
	BEGIN
		INSERT INTO [KioskCheckIn].[BackDisplayTbl](
			[ARRIVALRELEASEDETKEY],
			[Is_Arrived],
			[Is_Inspected],
			[Is_Released],
			[ColourID],
			[TimeCreated],
			[Is_Completed]
		)
		SELECT
			[ARRIVALRELEASEDETKEY],
			0,
			0,
			0,
			1,
			getdate(),
			0
		FROM INSERTED
	END

ExitCode:
return

ErrorCode:
raiserror (@WhatIsError,16,1)
--Rollback transaction if something went wrong
rollback transaction
-----------------------------------------------------------------------------------------------------------------------------------------------------