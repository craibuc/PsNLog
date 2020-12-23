/*
Purpose: store the results of scheduled tasks.
Revisions:
    2020-30-30 - CB - creating script
*/

USE Custom
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dbo].[EventLog] DROP CONSTRAINT [DF_EventLog_created]
GO

DROP TABLE [dbo].[EventLog]
GO

CREATE TABLE [dbo].[EventLog](
    Id int PRIMARY KEY IDENTITY (1, 1),
	Created datetime NULL,
    Computer varchar(50),
    [User] varchar(50),
	Source varchar(50) NOT NULL, -- name of the script
    [Level] varchar(15) NOT NULL, -- [Trace|Debug|Information|Warning|Error|Fatal]
    TypeName varchar(50) NULL, -- structured logging
    PrimaryKeyInt int NULL, -- structured logging
    PrimaryKeyVarchar varchar(50) NULL, -- structured logging
    [Message] varchar(1000),
    Exception varchar(1000) NULL,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EventLog] ADD  CONSTRAINT [DF_EventLog_created]  DEFAULT (getdate()) FOR [created]
GO

GRANT SELECT ON [dbo].[EventLog] TO PUBLIC
GO
