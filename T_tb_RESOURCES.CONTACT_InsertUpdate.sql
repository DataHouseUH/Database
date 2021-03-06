-- =============================================
-- Author:	Frendy Lio
-- Date: 4/6/2020
-- Description:	Insert or Update Trigger that will insert a phone number into KioskCheckIn.UsersInformationTbl
--						This phone number will not have any characters
--						This will help find the user faster.
-- =============================================

CREATE TRIGGER [RESOURCES].[T_tb_RESOURCES.CONTACT_InsertUpdate]
	ON [RESOURCES].[CONTACT]
	FOR INSERT, UPDATE

AS 

DECLARE @AuditType as varchar(10)
DECLARE @whatisError AS VARCHAR(100)

--------------------
-- If Update
--------------------
	IF EXISTS( SELECT * FROM DELETED )
	BEGIN
		UPDATE [KioskCheckIn].[UserInformationTbl]
		SET
			DAYPHN = (SELECT TOP 1 DAYPHN FROM INSERTED) -- Top 1 just in case
		WHERE
			[CNTCTKEY] = (SELECT TOP 1 [CNTCTKEY] FROM INSERTED) -- Top 1 Just in case

	--Error check
	if @@ERROR <> 0
	Begin
		set @whatisError = 'Error related to [T_tb_RESOURCES.CONTACT_InsertUpdate]'
		goto errorcode
	End


	END
--------------------
-- If INSERT
--------------------
	ELSE
	BEGIN
		INSERT INTO [KioskCheckIn].[UserInformationTbl] (
			[CNTCTKEY],
			DAYPHN
		)
		SELECT
			[CNTCTKEY],
			DAYPHN			
		FROM INSERTED

		--Error check
		if @@ERROR <> 0
		Begin
			set @whatisError = 'Error related to [T_tb_RESOURCES.CONTACT_InsertUpdate]'
			goto errorcode
		End
	END

ExitCode:
return

ErrorCode:
raiserror (@WhatIsError,16,1)
--Rollback transaction if something went wrong
rollback transaction
-----------------------------------------------------------------------------------------------------------------------------------------------------