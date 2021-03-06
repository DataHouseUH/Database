USE [InforPS-AQ]
GO
/****** Object:  Schema [KioskCheckIn]    Script Date: 4/29/2020 11:31:32 PM ******/
CREATE SCHEMA [KioskCheckIn]
GO
/****** Object:  UserDefinedFunction [KioskCheckIn].[RemoveChars]    Script Date: 4/29/2020 11:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [KioskCheckIn].[RemoveChars](@Input varchar(1000))
RETURNS VARCHAR(1000)
BEGIN
  DECLARE @pos INT
  SET @Pos = PATINDEX('%[^0-9]%',@Input)
  WHILE @Pos > 0
   BEGIN
    SET @Input = STUFF(@Input,@pos,1,'')
    SET @Pos = PATINDEX('%[^0-9]%',@Input)
   END
  RETURN @Input
END
GO
/****** Object:  Table [KioskCheckIn].[AlertTbl]    Script Date: 4/29/2020 11:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[AlertTbl](
	[AlertID] [int] IDENTITY(1,1) NOT NULL,
	[BackDisplayID] [int] NULL,
	[Message] [varchar](3000) NOT NULL,
	[TimeCreated] [datetime] NOT NULL,
	[TimeCompleted] [datetime] NULL,
 CONSTRAINT [PK_AlertTbl] PRIMARY KEY CLUSTERED 
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[BackDisplayTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[BackDisplayTbl](
	[BackDisplayID] [int] IDENTITY(1,1) NOT NULL,
	[ARRIVALRELEASEDETKEY] [int] NOT NULL,
	[UserID] [int] NULL,
	[Is_Arrived] [bit] NOT NULL,
	[Is_Inspected] [bit] NOT NULL,
	[Is_Released] [bit] NOT NULL,
	[ColourID] [int] NOT NULL,
	[TimeCreated] [datetime] NULL,
	[Is_Completed] [bit] NOT NULL,
	[CheckInID] [int] NULL,
 CONSTRAINT [PK_BackDisplayTbl] PRIMARY KEY CLUSTERED 
(
	[BackDisplayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[CheckInTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[CheckInTbl](
	[CheckInID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[TimeCreated] [datetime] NOT NULL,
	[StatusID] [int] NOT NULL,
	[HashID] [int] NOT NULL,
	[Is_Qualified] [bit] NOT NULL,
	[Is_Completed] [bit] NOT NULL,
	[ARRIVALRELEASEDETKEY] [int] NOT NULL,
 CONSTRAINT [PK_CheckInTbl] PRIMARY KEY CLUSTERED 
(
	[CheckInID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[MasterAlertCustomMessageTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[MasterAlertCustomMessageTbl](
	[AlertCustomMessageID] [int] IDENTITY(1,1) NOT NULL,
	[Message] [varchar](3000) NOT NULL,
 CONSTRAINT [PK_MasterAlertCustomMessageTbl] PRIMARY KEY CLUSTERED 
(
	[AlertCustomMessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[MasterColourTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[MasterColourTbl](
	[ColourID] [int] IDENTITY(1,1) NOT NULL,
	[Colour] [varchar](10) NOT NULL,
	[Name] [varchar](10) NULL,
 CONSTRAINT [PK_ColourMasterTbl] PRIMARY KEY CLUSTERED 
(
	[ColourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[MasterStatusTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[MasterStatusTbl](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
	[ColourID] [int] NOT NULL,
 CONSTRAINT [PK_MasterStatusTbl] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[UserInformationTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[UserInformationTbl](
	[CNTCTKEY] [int] NOT NULL,
	[DAYPHN] [bigint] NOT NULL,
 CONSTRAINT [PK_UserInformationTbl] PRIMARY KEY CLUSTERED 
(
	[CNTCTKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KioskCheckIn].[UserIsnotQualifiedTbl]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KioskCheckIn].[UserIsnotQualifiedTbl](
	[UserIsNotQualifiedID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[PhoneNumber] [bigint] NULL,
	[Email] [varchar](50) NULL,
	[MicroChipID] [varchar](50) NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_UserIsnotQualifiedTbl] PRIMARY KEY CLUSTERED 
(
	[UserIsNotQualifiedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [KioskCheckIn].[UserInformationVw]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/*================================================================
-- Created by: Frendy Lio
-- DATE: 4/3/2020
-- DESCRIPTION: View of the tables needed for the matching.
				Currently it has xxx in order to secure the data for the Interns.
				I updated some rows to have some fake names; it should work when using the real database.
================================================================*/


CREATE VIEW [KioskCheckIn].[UserInformationVw] AS
 SELECT
	AR.ARRIVALRELEASEDETKEY, 
	UA.APUSEKEY,
	C.CNTCTKEY,
	UA.APNO, 
	CNT.NAMELAST, 
	CNT.NAMEFIRST, 
	UI.DAYPHN, 
	C.REFERENCEVALUE2 'FOREIGN PHN', 
	C.EMAIL, 
	UA.APNAME 'PETNAME', 
	AR.ARRIVALDATE, 
	AR.PRIMARYMCNUMBER,
	1 AS Is_Qualified
 FROM CDR_USE.USEAPPL UA --base use application table 
 ------------------------------------------
 INNER JOIN CDR_USE.USEAPPLDETAIL UAD ON 
 ------------------------------------------
	UAD.APUSEKEY = UA.APUSEKEY --link between extension table below and base use application table
 ------------------------------------------
 INNER JOIN USEFAMILY.ARRIVALRELEASEDET AR ON 
 ------------------------------------------
	AR.APUSEAPPLDTLKEY = UAD.APUSEAPPLDTLKEY --extension table containing mc number and other pet info
 ------------------------------------------
 INNER JOIN CDR_USE.USEAPL AP ON
 ------------------------------------------
	 AP.APUSEKEY = UA.APUSEKEY --link table between contact tables below and base use application table
 ------------------------------------------
 INNER JOIN RESOURCES.CONTACT C ON 
 ------------------------------------------
	C.CNTCTKEY = AP.CNTCTKEY --contact table (different contact info - email, phn)
 ------------------------------------------
 INNER JOIN RESOURCES.CNTCTID CNT ON 
 ------------------------------------------
	CNT.IDKEY = C.IDKEY  --identity table (name, ssn, dob)
 ------------------------------------------
 INNER JOIN [KioskCheckIn].[UserInformationTbl] UI ON 
 ------------------------------------------
	UI.CNTCTKEY = AP.CNTCTKEY -- Table that has phone number without characters
 ------------------------------------------
 WHERE 
		(
		UA.APNO IS NOT NULL 
	AND AP.PRIM = 'Y'
	AND C.EMAIL = '' 
	)
	OR	C.DAYPHN = '' 
	OR CNT.NAMEFIRST LIKE '%' 
	OR CNT.NAMELAST LIKE '%' 
	OR AR.PRIMARYMCNUMBER = ''
 UNION 
 SELECT
	0 AS ARRIVALRELEASEDETKEY,
	0 AS APUSEKEY,
	[UserIsNotQualifiedID] AS CNTCTKEY, -- we need to change Unqualified UserID to be negative, for now just do -1 ...
	'', 
	[LastName] AS NAMELAST, 
	[FirstName] AS NAMEFIRST, 
	[PhoneNumber] AS DAYPHN, 
	'' AS 'FOREIGN PHN', 
	Email, 
	'' AS 'PETNAME', 
	'', 
	MicroChipID AS PRIMARYMCNUMBER,
	0 AS Is_Qualified
 FROM [KioskCheckIn].[UserIsnotQualifiedTbl]
 WHERE 
	DateCreated > CAST(GETDATE() AS DATE)

GO
ALTER TABLE [KioskCheckIn].[BackDisplayTbl] ADD  CONSTRAINT [DF_BackDisplayTbl_ARRIVALRELEASEDETKEY]  DEFAULT ((0)) FOR [ARRIVALRELEASEDETKEY]
GO
ALTER TABLE [KioskCheckIn].[BackDisplayTbl] ADD  CONSTRAINT [DF_BackDisplayTbl_Is_Arrived]  DEFAULT ((0)) FOR [Is_Arrived]
GO
ALTER TABLE [KioskCheckIn].[BackDisplayTbl] ADD  CONSTRAINT [DF_BackDisplayTbl_Is_Inspected]  DEFAULT ((0)) FOR [Is_Inspected]
GO
ALTER TABLE [KioskCheckIn].[BackDisplayTbl] ADD  CONSTRAINT [DF_BackDisplayTbl_Is_Completed]  DEFAULT ((0)) FOR [Is_Completed]
GO
ALTER TABLE [KioskCheckIn].[CheckInTbl] ADD  CONSTRAINT [DF_CheckInTbl_HashID]  DEFAULT ((0)) FOR [HashID]
GO
ALTER TABLE [KioskCheckIn].[CheckInTbl] ADD  CONSTRAINT [DF_CheckInTbl_Is_Qualified]  DEFAULT ((0)) FOR [Is_Qualified]
GO
ALTER TABLE [KioskCheckIn].[CheckInTbl] ADD  CONSTRAINT [DF_CheckInTbl_Is_Completed]  DEFAULT ((0)) FOR [Is_Completed]
GO
ALTER TABLE [KioskCheckIn].[CheckInTbl] ADD  CONSTRAINT [DF_CheckInTbl_ARRIVALRELEASEDETKEY]  DEFAULT ((0)) FOR [ARRIVALRELEASEDETKEY]
GO
ALTER TABLE [KioskCheckIn].[UserIsnotQualifiedTbl] ADD  CONSTRAINT [DF_UserIsnotQualifiedTbl_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [KioskCheckIn].[AlertTbl]  WITH CHECK ADD  CONSTRAINT [FK_BackDisplayTbl_AlertTbl] FOREIGN KEY([BackDisplayID])
REFERENCES [KioskCheckIn].[BackDisplayTbl] ([BackDisplayID])
GO
ALTER TABLE [KioskCheckIn].[AlertTbl] CHECK CONSTRAINT [FK_BackDisplayTbl_AlertTbl]
GO
ALTER TABLE [KioskCheckIn].[BackDisplayTbl]  WITH CHECK ADD  CONSTRAINT [FK_ColourMasterTbl_BackDisplayTbl] FOREIGN KEY([ColourID])
REFERENCES [KioskCheckIn].[MasterColourTbl] ([ColourID])
GO
ALTER TABLE [KioskCheckIn].[BackDisplayTbl] CHECK CONSTRAINT [FK_ColourMasterTbl_BackDisplayTbl]
GO
ALTER TABLE [KioskCheckIn].[CheckInTbl]  WITH CHECK ADD  CONSTRAINT [FK_MasterStatusTbl_CheckInTbl] FOREIGN KEY([StatusID])
REFERENCES [KioskCheckIn].[MasterStatusTbl] ([StatusID])
GO
ALTER TABLE [KioskCheckIn].[CheckInTbl] CHECK CONSTRAINT [FK_MasterStatusTbl_CheckInTbl]
GO
ALTER TABLE [KioskCheckIn].[MasterStatusTbl]  WITH CHECK ADD  CONSTRAINT [FK_MasterColourTbl_MasterStatusTbl] FOREIGN KEY([ColourID])
REFERENCES [KioskCheckIn].[MasterColourTbl] ([ColourID])
GO
ALTER TABLE [KioskCheckIn].[MasterStatusTbl] CHECK CONSTRAINT [FK_MasterColourTbl_MasterStatusTbl]
GO
/****** Object:  StoredProcedure [KioskCheckIn].[ARRIVALRELEASEDET_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [KioskCheckIn].[ARRIVALRELEASEDET_Proc]

AS
BEGIN
	
INSERT INTO [USEFAMILY].[ARRIVALRELEASEDET](
[AAQHFDISPOSITIONLINK]
      ,[AAQHFNOTES]
      ,[ADDBY]
      ,[ADDDTTM]
      ,[APUSEAPPLDTLKEY]
      ,[APPLYOVERPAYMENTCHKBX]
      ,[AQRECEIVEDDATE]
      ,[ARCLOCATION]
      ,[ARRIVALDATE]
   --   ,[ARRIVALRELEASEDETKEY]
      ,[CAGE]
      ,[COLLECTAQS279CHKBX]
      ,[COLLECTAQS279DATE]
      ,[COLLECTCOMMENTS]
      ,[COLLECTHCCHKBX]
      ,[COLLECTHCDATE]
      ,[COLLECTHCISSUEDDATE]
      ,[COLLECTHIHCCHKBX]
      ,[COLLECTHIHCDATE]
      ,[COLLECTHIHCISSUEDDATE]
      ,[COLLECTNIIPCHKBX]
      ,[COLLECTRVCCCHKBX]
      ,[COLLECTRVCCDATE]
      ,[COLLECTRVCPCHKBX]
      ,[COLLECTRVCPDATE]
      ,[DAYSOVERDUE]
      ,[DAYSTRANSFERS]
      ,[ELIGIBLEDATE]
      ,[FEEOVERRIDELINK]
      ,[INITIALS]
      ,[MODBY]
      ,[MODDTTM]
      ,[LEFTAAQHFCHKBX]
      ,[NIIPSERVICEDOGCOMMENTS]
      ,[PETBREEDREADONLY]
      ,[PETCOLORREADONLY]
      ,[PETCOLORREADONLY2]
      ,[PETCOLORREADONLY3]
      ,[PETINFOBREEDLINK]
      ,[PETINFOCOLORLINK]
      ,[PETINFOCOLORLINK2]
      ,[PETINFOCOLORLINK3]
      ,[PETINFOMIXEDCHKBX]
      ,[PETINFOSEX]
      ,[PETINFOSPECIES]
      ,[PETMIXEDREADONLY]
      ,[PETNAMEREADONLY]
      ,[PETSEXREADONLY]
      ,[PETSPECIESREADONLY]
      ,[PRIMARYMCNUMBER]
      ,[QUARANTINEBLANKET]
      ,[QUARANTINECAUTIONCHKBX]
      ,[QUARANTINECLOTHING]
      ,[QUARANTINECOLLAR]
      ,[QUARANTINECRATE]
      ,[QUARANTINEDISHES]
      ,[QUARANTINEFOOD]
      ,[QUARANTINEFORM279]
      ,[QUARANTINEHC]
      ,[QUARANTINEHIHC]
      ,[QUARANTINELEASHES]
      ,[QUARANTINEOTHER]
      ,[QUARANTINERVCC]
      ,[QUARANTINERVCP]
      ,[QUARANTINESIZE]
      ,[QUARANTINETOYS]
      ,[RELEASECODELINK]
      ,[RELEASEDATE]
      ,[SHIPMASTERCARRIERCODELINK]
      ,[SHIPMASTERDESTCODELINK]
      ,[SHIPMASTERFLIGHTNUMBER]
      ,[SHIPMASTEROWNER]
      ,[SHIPMASTEROWNERLASTNAME]
      ,[SHIPMASTERPORT]
      ,[KENNELINGSTATUS]

	)
	SELECT
		'',
		NULL,
		'MIGRATE',	
		'2017-12-11 00:00:00.000',
		'122657', -- FK 2
		'N',
		'2017-12-14 00:00:00.000',
		'AAQHF',	
		'2020-04-06 19:40:48.600',
--		NULL, -- Key
		NULL,
		'N',
		NULL,
		'MIGR: Prev Entry# 258602 MIGR: Collect original/carbon HC and NIIP upon arrival.',
		'N',
		NULL,
		NULL,
		'N',
		NULL,
		NULL,
		'N',
		'N',
		NULL,
		'N',
		NULL,
		0,
		0,
		'2016-05-16 00:00:00.000',
		'',
		NULL,
		'JLee',
		'2018-03-24 09:49:39.617',
		'N',
		NULL,
		'SHI',
		'BRD',
		'WHT',
		NULL,
		'',
		'',
		'',
		'',
		'N',
		NULL,
		NULL,
		'N',
		'CHINA',
		'Female',
		'Canine',
		'ABC123',
		NULL,
		'N',
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		'R',
		'2017-12-14 00:00:00.000',
		'AS',
		'KOA',	
		'855',	
		'OUDA',
		'PITTS',
		'PDX',
		NULL

END


GO
/****** Object:  StoredProcedure [KioskCheckIn].[Copy_Users_PhoneNumber]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 4/6/2020
-- Description:	Query to copy the data for phone number without any characters
-- =============================================


CREATE PROCEDURE [KioskCheckIn].[Copy_Users_PhoneNumber] AS

SELECT
	CNTCTKEY,
	[KioskCheckIn].[RemoveChars](DAYPHN) AS DAYPHN
INTO [KioskCheckIn].[UserInformationTbl]
FROM [InforPS-AQ].[KioskCheckIn].[UserInformationVw]
WHERE DAYPHN IS NOT NULL AND DAYPHN != ''
GROUP BY CNTCTKEY, DAYPHN
ORDER BY CNTCTKEY 
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Create_Alert_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Insert data into AlertTbl
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Create_Alert_Proc]
	@BackDisplayID INT,
	@Message VARCHAR(3000)

AS
BEGIN
	
	INSERT INTO [KioskCheckIn].[AlertTbl](
		BackDisplayID,
		Message,
		TimeCreated
	)
	SELECT
		@BackDisplayID,
		@Message,
		GETDATE()

	SELECT
		1 AS Status,
		'' AS Error

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Create_AlertCustomMessage_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	View Alerts for Front, they can choose which one they want to see.
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Create_AlertCustomMessage_Proc]
	@Message AS VARCHAR(1000)
	
AS
BEGIN
	
	INSERT INTO [KioskCheckIn].[MasterAlertCustomMessageTbl](
		Message
	)
	SELECT
		@Message

	SELECT
		1 AS Status,
		'' AS Message

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Create_BackDisplay_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Insert data into BackDisplayTbl
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Create_BackDisplay_Proc]
	@PetID INT

AS
BEGIN
	
	INSERT INTO [KioskCheckIn].[BackDisplayTbl](
		PetID,
		Is_Arrived,
		Is_Inspected,
		Is_Released,
		ColourID
	)
	SELECT
		@PetID,
		0,
		0,
		0,
		0

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Create_CheckIn_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Insert data into CheckInTbl

-- Update: 4/7/2020 
-- By: Frendy Lio
-- Changed logic for statusID, we need to change it for multiple pets ...
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Create_CheckIn_Proc]
	@UserID INT,
	@PetID INT,
	@IsQualified BIT
	
AS
BEGIN
	
	------------
	-- Create Hash Number for Display
	-- If have phone number, use the last 4 digits
	-- Else, Use a Hash
	------------
	DECLARE @HashID AS VARCHAR(10)
	DECLARE @PhoneNumber AS BIGINT

	SELECT
		@Phonenumber = DAYPHN
	FROM [KioskCheckIn].[UserInformationTbl]
	WHERE
		CNTCTKEY = @UserID

	-- Phone Number
	IF @PhoneNumber IS NOT NULL
	BEGIN
		SET @HashID = RIGHT(@PhoneNumber, 4)
	END

	-- No Phone Number
	ELSE 
	BEGIN

		INSERT INTO [KioskCheckIn].[CheckInTbl](
			UserID,
			TimeCreated,
			StatusID,
			HashID,
			Is_Qualified,
			ARRIVALRELEASEDETKEY
		)
		SELECT
			@UserID,
			GETDATE(),
			CASE 
				WHEN @IsQualified = 1 THEN 1
				ELSE 4
			END,
			RIGHT(
			[KioskCheckIn].[RemoveChars](
				CONVERT(VARCHAR(1000),
					HASHBYTES(
						'SHA2_256', CAST(@UserID AS VARCHAR(10))
						), 2
					)
				), 4
			),
			@IsQualified,
			0

			GOTO CheckIN
	END

	------------
	-- Create StatusOD
	------------
	DECLARE @StatusID INT
	-- If not qualified
	IF @UserID < 0 
	SET @StatusID = 4 --not qualified

	-- If qualified check pet status
	ELSE
	BEGIN

		IF NOT EXISTS(
			SELECT
				BDTbl.ARRIVALRELEASEDETKEY
			FROM [KioskCheckIn].[BackDisplayTbl] BDTbl
			---------------------------------------------------
			INNER JOIN [KioskCheckIn].[UserInformationVw] UIVw ON
			---------------------------------------------------
				BDTbl.ARRIVALRELEASEDETKEY = UIVw.ARRIVALRELEASEDETKEY
			WHERE
					@UserID = UIVw.CNTCTKEY
				AND BDTbl.ARRIVALRELEASEDETKEY = @PetID
				AND Is_Completed = 0
		)
		BEGIN
			SET @StatusID = 1 -- waiting for pet
		END
		-- If pet arrived
		ELSE
		BEGIN
			-- Check if Is_release is completed
			IF (
				SELECT
					Is_Released 
				FROM [KioskCheckIn].[BackDisplayTbl]
				WHERE
						UserID = @UserID
					AND ARRIVALRELEASEDETKEY = @PetID
					AND	Is_Completed = 0
			) = 1
			BEGIN
				SET @StatusID = 3 -- ready for release
			END
			ELSE 
				SET @StatusID = 2 -- pet ispection in progress

		END



	END

	INSERT INTO [KioskCheckIn].[CheckInTbl](
		UserID,
		TimeCreated,
		StatusID,
		HashID,
		Is_Qualified,
		ARRIVALRELEASEDETKEY
	)
	SELECT
		@UserID,
		GETDATE(),
		CASE 
			WHEN @IsQualified = 1 THEN 1
			ELSE 4
		END,
		@HashID,
		@IsQualified,
		ISNULL(@PetID, 0)


	CheckIN:

	DECLARE @CheckInID INT
	SET @CheckInID  = SCOPE_IDENTITY()

	IF EXISTS(
		SELECT
			1
		FROM [KioskCheckIn].[BackDisplayTbl]
		WHERE
				ARRIVALRELEASEDETKEY = @PetID
			AND Is_Completed = 0
			AND ARRIVALRELEASEDETKEY != 0 
	)
	BEGIN
		UPDATE [KioskCheckIn].[BackDisplayTbl]
		SET 
			CheckInID = @CheckInID,
			UserID = @UserID
		WHERE
				ARRIVALRELEASEDETKEY = @PetID
			AND Is_Completed = 0			
			
	END

	ELSE
	BEGIN
		INSERT INTO [KioskCheckIn].[BackDisplayTbl](
			ARRIVALRELEASEDETKEY,
			UserID,
			Is_Arrived,
			Is_Inspected,
			Is_Released,
			ColourID,
			TimeCreated,
			Is_Completed,
			CheckInID
		)
		SELECT
			ISNULL(@PetID, 0),
			@UserID,
			0,
			0,
			0,
			CASE 
				WHEN @IsQualified = 1 THEN 1
				ELSE 4
			END,
			GETDATE(),
			0,
			@CheckInID
	END
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Create_Pet_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Insert data into PetTbl
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Create_Pet_Proc]
	@UserID INT,
	@PetName VARCHAR(50),
	@Microchip VARCHAR(10)

AS
BEGIN
	
	INSERT INTO [KioskCheckIn].[PetTbl](
		UserID,
		PetName,
		Microchip,
		PetTypeID
	)
	SELECT
		@UserID,
		@PetName,
		@Microchip,
		1

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Create_UserIsnotQualified_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Insert data into [UserIsnotQualifiedTbl]
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Create_UserIsnotQualified_Proc]
	@LastName VARCHAR(50),
	@FirstName VARCHAR(50),
	@MicroChipID VARCHAR(50),
	@Email VARCHAR(50),
	@PhoneNumber BIGINT,
	@UserID INT = NULL OUTPUT
	
AS
BEGIN
	
	INSERT INTO [KioskCheckIn].[UserIsnotQualifiedTbl](
		FirstName,
		LastName,
		PhoneNumber,
		Email,
		MicroChipID
	)
	SELECT
		@FirstName,
		@LastName,
		@PhoneNumber,
		@Email,
		@MicroChipID

	----------------------
	-- After Inserting User that is not qualify, check them in.
	----------------------
	 SET @UserID  = SCOPE_IDENTITY()

	EXEC [KioskCheckIn].[Create_CheckIn_Proc] 
	@UserID,
	NULL,
	0

	ExitCode:
	SELECT
		0 AS Status,
		'' AS Error,
		@UserID AS UserID
	RETURN 0
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Delete_AlertCustomMessage_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Delete Alerts for Front
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Delete_AlertCustomMessage_Proc]
	@AlertCustmMessageID AS INT
	
AS
BEGIN
	
	DELETE FROM [KioskCheckIn].[MasterAlertCustomMessageTbl]
	WHERE
		AlertCustomMessageID = @AlertCustmMessageID

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[DELETE_ARRIVALRELEASEDET_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [KioskCheckIn].[DELETE_ARRIVALRELEASEDET_Proc]

AS
BEGIN

DELETE FROM  USEFAMILY.ARRIVALRELEASEDET where APUSEAPPLDTLKEY = 122657

END


GO
/****** Object:  StoredProcedure [KioskCheckIn].[Update_Alert_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Completes an Alert
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Update_Alert_Proc]
	@AlertID INT
	
AS
BEGIN
	
	DECLARE @ErrorMsg VARCHAR(100)

	-----------
	-- Error Check
	-----------
	IF NOT EXISTS(
		SELECT
			1
		FROM [KioskCheckIn].[AlertTbl]
		WHERE
			AlertID = @AlertID
	)
	BEGIN
		SET @ErrorMsg = 'We apologize, the record was not found.'
		GOTO ErrorCode
	END

	------------
	-- Update
	------------
	UPDATE [KioskCheckIn].[AlertTbl]
	SET
		TimeCompleted = GETDATE()
	WHERE
		AlertID = @AlertID

ExitCode:
	SELECT
		1 AS Status,
		'' AS Error
	RETURN 1

ErrorCode:
	SELECT
		0 AS Status,
		@ErrorMsg AS Error
	RETURN 0
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Update_AlertCustomMessage_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	View Alerts for Front, they can choose which one they want to see.
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Update_AlertCustomMessage_Proc]
	@AlertCustmMessageID AS INT,
	@Message AS VARCHAR(1000)
	
AS
BEGIN
	
	IF		@AlertCustmMessageID = -1 
		AND (SELECT COUNT(AlertCustomMessageID) FROM  [KioskCheckIn].[MasterAlertCustomMessageTbl]) < 9 
	BEGIN
		EXECUTE [KioskCheckIn].[Create_AlertCustomMessage_Proc] @Message
	END

	ELSE
	BEGIN
		UPDATE [KioskCheckIn].[MasterAlertCustomMessageTbl]
		SET
			Message = @Message
		WHERE
			AlertCustomMessageID = @AlertCustmMessageID
	END

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Update_BackDisplay_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Update data into BackDisplayTbl
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[Update_BackDisplay_Proc]
	@BackDisplayID INT,
	@Is_Arrived BIT,
	@Is_Inspected BIT,
	@Is_Released BIT,
	@Is_Completed BIT
	
AS
BEGIN
	
	DECLARE @ErrorMsg VARCHAR(100)
	DECLARE @ColourID INT

	-----------
	-- Error Check
	-----------
	IF NOT EXISTS(
		SELECT
			1
		FROM [KioskCheckIn].BackDisplayTbl
		WHERE
			BackDisplayID = @BackDisplayID
	)
	BEGIN
		SET @ErrorMsg = 'We apologize, the record was not found.'
		GOTO ErrorCode
	END

	/*
	-- Pet hasn't arrived, you cannot check anything
	IF EXISTS(
		SELECT
			1
		FROM [KioskCheckIn].BackDisplayTbl
		WHERE
				BackDisplayID = @BackDisplayID
			AND ARRIVALRELEASEDETKEY = 0
	)
	BEGIN
		SET @ErrorMsg = 'We apologize, pet is not in record, you cannot update it.'
		GOTO ErrorCode
	END

	*/

	------------
	-- Update
	------------
	UPDATE [KioskCheckIn].[BackDisplayTbl]
	SET
		Is_Arrived = ISNULL(@Is_Arrived, Is_Arrived),
		Is_Inspected = ISNULL(@Is_Inspected, Is_Inspected),
		Is_Released = ISNULL(@Is_Released, Is_Released)
	WHERE
		BackDisplayID = @BackDisplayID

	-- now update the colour depending the situation.
	UPDATE [KioskCheckIn].[BackDisplayTbl]
	SET
		ColourID = CASE
						WHEN Is_Released = 0 AND Is_Arrived = 0 AND Is_Inspected = 0 THEN 1 -- red
						WHEN Is_Released = 0 AND (Is_Arrived = 1 OR Is_Inspected = 1) THEN 2 -- yellow 
						WHEN Is_Released = 1 THEN 3 -- red
					END
	WHERE
		BackDisplayID = @BackDisplayID

	UPDATE [KioskCheckIn].[CheckInTbl]
	SET 
		StatusID = CASE
						WHEN Is_Released = 1 THEN 3
						WHEN Is_Arrived = 1 THEN 2
						WHEN Is_Released = 0 AND Is_Arrived = 0 AND Is_Inspected = 0 THEN 1
					END
	FROM [KioskCheckIn].[CheckInTbl] AS CITbl
	------------------------------------------
	INNER JOIN [KioskCheckIn].[BackDisplayTbl] AS BDTbl ON
	------------------------------------------
		CITbl.CheckInID = BDTbl.CheckInID
	WHERE
		BackDisplayID = @BackDisplayID

	------------
	-- Update a completition
	------------
	IF @Is_Completed = 1
	BEGIN
		IF EXISTS(
			SELECT
				1
			FROM [KioskCheckIn].[BackDisplayTbl]
			WHERE
					BackDisplayID = @BackDisplayID
				AND Is_Arrived = 1
				AND Is_Inspected = 1
				AND Is_Released = 1
				AND CheckInID IS NOT NULL
		)
		BEGIN
			UPDATE [KioskCheckIn].[BackDisplayTbl]
			SET Is_Completed = 1
			WHERE
				BackDisplayID = @BackDisplayID

			UPDATE [KioskCheckIn].[CheckInTbl]
			SET [Is_Completed] = 1
			FROM [KioskCheckIn].[CheckInTbl] AS CITbl
			------------------------------------------
			INNER JOIN [KioskCheckIn].[BackDisplayTbl] AS BDTbl ON
			------------------------------------------
				CITbl.CheckInID = BDTbl.CheckInID
			WHERE
				BackDisplayID = @BackDisplayID
		END

		ELSE
		BEGIN
			SET @ErrorMsg = 'We apologize, you are unable to complete this action because the pet is not ready to be completed.'
			GOTO ErrorCode
		END
			
	END
		
ExitCode:
	SELECT
		1 AS Status,
		'' AS Error
	RETURN 1

ErrorCode:
	SELECT
		0 AS Status,
		@ErrorMsg AS Error
	RETURN 0
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[View_Alert_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Display Alert
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[View_Alert_Proc]
	
AS
BEGIN
	
	SELECT
		AlertID,
		BackDisplayID,
		Message,
		TimeCreated
	FROM [KioskCheckIn].[AlertTbl]
	WHERE
			TimeCreated > CAST(GETDATE() AS DATE)
		AND TimeCompleted IS NULL
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[View_AlertCustomMessage_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	View Alerts for Front, they can choose which one they want to see.
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[View_AlertCustomMessage_Proc]
	
AS
BEGIN
	
	SELECT
		[AlertCustomMessageID],
		[Message]
	FROM [KioskCheckIn].[MasterAlertCustomMessageTbl]

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[View_BackDisplay_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Display BackDisplay
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[View_BackDisplay_Proc]
	
AS
BEGIN
	
	SELECT
		BDTbl.BackDisplayID,
		UIVw.NAMELAST + ', ' + UIVw.NAMEFIRST AS UserDisplayName,
		UIVw.PETNAME AS PetName,
		UIVw.PRIMARYMCNUMBER AS MicroChipID,
		UIVw.APNO AS ApplicationNumber,
		BDTbl.Is_Arrived,
		BDTbl.Is_Inspected,
		BDTbl.Is_Released,
		CMTBL.Colour,
		BDTbl.Is_Completed,
		CASE 
			WHEN CMTbl.ColourID = 1 THEN 3
			WHEN CMTbl.ColourID = 2 THEN 2
			WHEN CMTbl.ColourID = 3 THEN 1
			WHEN CMTbl.ColourID = 4 THEN 4
			ELSE 5
		END As OrderColor
	FROM [KioskCheckIn].[BackDisplayTbl] BDTbl
	----------------------------------------------
	INNER JOIN [KioskCheckIn].[UserInformationVw] UIVw ON
	----------------------------------------------
			BDTbl.[ARRIVALRELEASEDETKEY] = UIVw.[ARRIVALRELEASEDETKEY]
		AND	BDTbl.UserID = UIVw.CNTCTKEY
	---------------------------
	INNER JOIN [KioskCheckIn].[MasterColourTbl] CMTbl ON
	---------------------------
		BDTbl.ColourID = CMTbl.ColourID
	---------------------------
	WHERE
			BDTbl.TimeCreated > CAST(GETDATE() AS DATE) 
		AND BDTbl.Is_Completed = 0
		AND BDTbl.CheckInID IS NOT NULL
	ORDER BY
		OrderColor ASC,
		BDTbl.TimeCreated ASC
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[View_Confirmation_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Display Confirmation information
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[View_Confirmation_Proc]
	@UserID INT,
	@is_Qualified BIT
	
AS
BEGIN
	
	SELECT DISTINCT TOP 1 
		CITbl.HashID AS DisplayID,
		UIVw.NAMELAST + ', ' + UIVw.NAMEFIRST AS UserDisplayName
	FROM [KioskCheckIn].[CheckInTbl] CITbl
	----------------------------------------------
	INNER JOIN [KioskCheckIn].[UserInformationVw] UIVw ON
	----------------------------------------------
			CITbl.UserID = UIVw.CNTCTKEY
		AND CITbl.Is_Qualified = UIVw.Is_Qualified
	-----------------------------------------------
	WHERE
			CITbl.UserID = @UserID
		AND UIVw.Is_Qualified =@is_Qualified

END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[View_FrontDisplay_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/7/2020
-- Description:	Display BackDisplay
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[View_FrontDisplay_Proc]
	
AS
BEGIN
	
	SELECT DISTINCT TOP 20
		CITbl.HashID AS DisplayID,
		LEFT(UIVw.NAMELAST, 1) + ', ' + UIVw.NAMEFIRST AS UserDisplayName,
		UIVw.PETNAME AS PetName, 
		MSTbl.StatusName AS StatusName,
		TimeCreated
	FROM [KioskCheckIn].[CheckInTbl] CITbl
	----------------------------------------------
	LEFT JOIN [KioskCheckIn].[UserInformationVw] UIVw ON
	----------------------------------------------
			CITbl.UserID = UIVw.CNTCTKEY
		AND	CITBl.ARRIVALRELEASEDETKEY = UIVw.ARRIVALRELEASEDETKEY
	-----------------------------------------------
	INNER JOIN [KioskCheckIn].[MasterStatusTbl] MSTbl ON
	-----------------------------------------------
		CITbl.StatusID = MSTbl.StatusID

	WHERE
			CITbl.TimeCreated > CAST(GETDATE() AS DATE)
		AND CITbl.Is_Completed = 0
	ORDER BY 
		CITbl.TimeCreated ASC
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[View_User_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Frendy Lio
-- Create date: 3/30/2020
-- Description:	This Proc will find if a user is qualified or not. If Qualified, means that we found his data. If not, they are not qualified
--
-- Update: Frendy Lio
-- Date: 4/21/2020
-- Description: Updated proc to match new logic for Check-In
-- =============================================
CREATE PROCEDURE [KioskCheckIn].[View_User_Proc]
	@LastName VARCHAR(50),
	@FirstName VARCHAR(50),
	@PetName VARCHAR(50),
	@MicrochipID VARCHAR(50),
	@Email VARCHAR(50),
	@PhoneNumber VARCHAR(50)

AS
BEGIN
	
	-- Find @UserID from Microchip
	DECLARE @UserID INT
	DECLARE @ErrorMessage VARCHAR(100)
	DECLARE @HowManyUsersFound INT

	-- Pet information
	DECLARE @HowManyPets INT
	DECLARE @PetID INT

	--------------------
	-- Default values
	-------------------
	IF @LastName IS NULL SET @LastName = ''
	IF @FirstName IS NULL SET @FirstName = ''
	IF @PetName IS NULL SET @PetName = ''
	IF @MicrochipID IS NULL SET @MicrochipID = ''
	IF @Email IS NULL SET @Email = ''
	IF @PhoneNumber IS NULL SET @PhoneNumber = ''

	-------------------------
	-- Part 1: Checks
	-------------------------

	--------------------------
	-- Case 1: First and Last Name are provided, use that and email address or pet name.
	--------------------------
	IF @LastName IS NOT NULL AND @FirstName IS NOT NULL
	BEGIN
		SELECT
			@UserID = CNTCTKEY
		FROM [KioskCheckIn].[UserInformationVw]
		WHERE
				NAMEFIRST LIKE @FirstName + '%'
			AND NAMELAST like @LastName + '%'
			AND Is_Qualified = 1
			AND (
					(EMAIL = LTRIM(@Email) AND EMAIL != '')
				OR	(PETNAME =LTRIM(@PetName) AND PETNAME != '')
			)

		IF @UserID IS NOT NULL
		BEGIN
			GOTO CheckPets
		END
	END

	--------------------------
	-- Case 2: Phone Number is provided
	--------------------------
	IF @PhoneNumber IS NOT NULL
	BEGIN

		DECLARE @PhoneNumberBigInt bigint 
		SET @PhoneNumberBigInt = [KioskCheckIn].[RemoveChars](@PhoneNumber)

		SELECT
			@UserID = CNTCTKEY
		FROM [KioskCheckIn].[UserInformationVw]
		WHERE
				DAYPHN = @PhoneNumberBigInt
			AND @PhoneNumberBigInt != ''
			AND Is_Qualified = 1
			AND (
					NAMEFIRST LIKE @FirstName + '%'
				OR	NAMELAST like @LastName + '%'
				OR	(PETNAME = LTRIM(@PetName) AND PETNAME != '')
			)

		IF @UserID IS NOT NULL
		BEGIN
			GOTO CheckPets
		END

	END

	--------------------------
	-- Case 3: If Email Address is provided
	--------------------------
	IF @Email IS NOT NULL
	BEGIN
		SELECT
			@UserID = CNTCTKEY
		FROM [KioskCheckIn].[UserInformationVw]
		WHERE
				EMAIL = LTRIM(@Email) 
			AND EMAIL != ''
			AND (
					NAMEFIRST LIKE @FirstName + '%'
				OR	NAMELAST like @LastName + '%'
				OR	(PETNAME = LTRIM(@PetName) AND PETNAME != '')
			)

		IF @UserID IS NOT NULL
		BEGIN
			GOTO CheckPets
		END
	END

	--------------------------
	-- Case 4: If MicroChip is Provided
	--------------------------
	IF @MicrochipID IS NOT NULL
	BEGIN
		SELECT
			@UserID = CNTCTKEY
		FROM [KioskCheckIn].[UserInformationVw]
		WHERE
				PRIMARYMCNUMBER = @MicrochipID
			AND PRIMARYMCNUMBER != ''
			AND	(
					NAMEFIRST LIKE @FirstName + '%'
				OR	NAMELAST like @LastName + '%'
				OR	(PETNAME = LTRIM(@PetName) AND PETNAME != '')
			)

		IF @UserID IS NOT NULL
		BEGIN
			GOTO CheckPets
		END
	END

	-- If you get here, none of the matchces worked, thus, go to unqualified
	SET @ErrorMessage = 'Could not find the user.'
	GOTO ErrorCode

	--------------------------
	-- Part 2: Check How many Pets we find with that UserID
	--------------------------
	CheckPets:

		-- Count how many pets
		SELECT 
			@HowManyPets = COUNT(ARRIVALRELEASEDETKEY)
		FROM [KioskCheckIn].[UserInformationVw]
		WHERE
			@UserID = CNTCTKEY

		IF @HowManyPets = 1
		BEGIN
			SELECT 
				@PetID = ARRIVALRELEASEDETKEY
			FROM [KioskCheckIn].[UserInformationVw]
			WHERE
				@UserID = CNTCTKEY			
		END
		
		-- If more than one pet
		-- 0 will never happen
		ELSE
		BEGIN
			-- Get pet names
			SELECT 
				@PetID = ARRIVALRELEASEDETKEY
			FROM [KioskCheckIn].[UserInformationVw]
			WHERE
					@UserID = CNTCTKEY	
				AND	(
						(@PetName = LTRIM(PETNAME) AND PETNAME != '')
					OR	(@MicrochipID = PRIMARYMCNUMBER AND PRIMARYMCNUMBER != '')
				)

			-- If petID still null, we couldn't find the pet
			
			IF (@PetID IS NULL)
			BEGIN
				SET @ErrorMessage = 'You are a qualify user. Looks like you have multiple pets; please especify which pet you are picking up.'
				GOTO PetError
			END
		END


	ExitCode:
		--------------
		-- Before exiting, Put User in CheckIn
		--------------
		EXEC [KioskCheckIn].[Create_CheckIn_Proc]
			@UserID,
			@PetID,
			1

		SELECT
			1 AS Status,
			'' AS Error,
			@UserID AS UserID
		RETURN 1

	ErrorCode:
		----------------
		-- Before exiting, create a user that does not qualify
		---------------
		IF @MicroChipID IS NULL OR LTRIM(@MicroChipID) = '' 
		BEGIN
			SELECT
			-1 AS Status,
			'Please provided MicroChipID' AS Error,
			NULL AS UserID

			Return 0
		END

		
		EXEC [KioskCheckIn].[Create_UserIsnotQualified_Proc]
				@LastName,
				@FirstName,
				@MicroChipID,
				@Email,
				@PhoneNumberBigInt,
				@UserID OUTPUT 

		SELECT
			0 AS Status,
			@ErrorMessage AS Error,
			@UserID AS UserID
		Return 0

	PetError:
		SELECT
			0 AS Status,
			@ErrorMessage AS Error,
			@UserID AS UserID
		Return 0
END
GO
/****** Object:  StoredProcedure [KioskCheckIn].[Wei_Proc]    Script Date: 4/29/2020 11:31:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [KioskCheckIn].[Wei_Proc]

AS
BEGIN
	
	DELETE FROM [KioskCheckIn].[CheckInTbl]

	DELETE FROM [KioskCheckIn].[BackDisplayTbl] WHERE BackDisplayID > 10

END
GO
