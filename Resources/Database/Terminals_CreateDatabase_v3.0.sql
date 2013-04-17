/****** Object:  Database [TERMINALS.MDF]    Script Date: 04/16/2013 16:51:38 ******/
CREATE DATABASE [TERMINALS.MDF]
GO
ALTER DATABASE [TERMINALS.MDF] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TERMINALS.MDF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TERMINALS.MDF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET ARITHABORT OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET AUTO_CLOSE ON
GO
ALTER DATABASE [TERMINALS.MDF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [TERMINALS.MDF] SET AUTO_SHRINK ON
GO
ALTER DATABASE [TERMINALS.MDF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [TERMINALS.MDF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [TERMINALS.MDF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET  DISABLE_BROKER
GO
ALTER DATABASE [TERMINALS.MDF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [TERMINALS.MDF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [TERMINALS.MDF] SET  READ_WRITE
GO
ALTER DATABASE [TERMINALS.MDF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [TERMINALS.MDF] SET  MULTI_USER
GO
ALTER DATABASE [TERMINALS.MDF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [TERMINALS.MDF] SET DB_CHAINING OFF
GO
USE [TERMINALS.MDF]
GO
/****** Object:  StoredProcedure [dbo].[AddFavoriteToGroup]    Script Date: 04/16/2013 16:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddFavoriteToGroup]
	(
	@favoriteId int,
	@groupId int
	)

AS
GO
/****** Object:  Table [dbo].[Options]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[PropertyName] [nvarchar](20) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[PropertyName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Options] ([PropertyName], [Value]) VALUES (N'MasterPasswordKey', NULL)
/****** Object:  Table [dbo].[Groups]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorites]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Favorites](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Protocol] [nvarchar](10) NOT NULL,
	[Port] [int] NOT NULL,
	[ServerName] [nvarchar](255) NOT NULL,
	[NewWindow] [bit] NOT NULL,
	[DesktopShare] [nvarchar](255) NULL,
	[Notes] [nvarchar](500) NULL,
	[ProtocolProperties] [xml] NULL,
	[IconData] [varbinary](max) NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Only to simplyfy relations, otherwise redundant because of Guid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Favorites', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'XML serialized properties depending on selected protocol. This allowes create customized features without changing database schema independent on selected protol' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Favorites', @level2type=N'COLUMN',@level2name=N'ProtocolProperties'
GO
/****** Object:  Table [dbo].[CredentialBase]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CredentialBase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](255) NULL,
	[Domain] [nvarchar](255) NULL,
	[EncryptedPassword] [nvarchar](max) NULL,
 CONSTRAINT [PK_CredentialBase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Directly referenced from Favorites Security or Credentials. This isnt referenced from XML favorite protocol options' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CredentialBase', @level2type=N'COLUMN',@level2name=N'Id'
GO
/****** Object:  Table [dbo].[BeforeConnectExecute]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BeforeConnectExecute](
	[FavoriteId] [int] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Command] [nvarchar](255) NULL,
	[CommandArguments] [nvarchar](255) NULL,
	[InitialDirectory] [nvarchar](255) NULL,
	[WaitForExit] [bit] NOT NULL,
 CONSTRAINT [PK_BeforeConnectExecute] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Credentials]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Credentials](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Credentials_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCredentials]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCredentials]
	(
	@Id int
	)
AS

	delete from CredentialBase where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[DeleteCredentialBase]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCredentialBase]
	(
	@Id int
	)
AS
	delete from CredentialBase where Id = @Id
GO
/****** Object:  Table [dbo].[DisplayOptions]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DisplayOptions](
	[FavoriteId] [int] NOT NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
	[Size] [tinyint] NULL,
	[Colors] [tinyint] NULL,
 CONSTRAINT [PK_DisplayOptions] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavoritesInGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavoritesInGroup](
	[FavoriteId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
 CONSTRAINT [PK_FavoritesInGroup] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC,
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteFavorite]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteFavorite]
	(
	@Id int
	)
AS
	delete from Favorites where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[DeleteGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteGroup]
	(
	@Id int,
  @ParentId int
	)
AS
	delete from Groups where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[GetMasterPasswordKey]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMasterPasswordKey]

AS
SELECT  Value
FROM    Options
WHERE   (PropertyName = 'MasterPasswordKey')
GO
/****** Object:  Table [dbo].[History]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[FavoriteId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[UserSid] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_History_1] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC,
	[Date] ASC,
	[UserSid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetFavoriteProtocolProperties]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFavoriteProtocolProperties]
	(
	@FavoriteId int
	)
AS
select ProtocolProperties from Favorites
  where Id = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[GetFavoriteIcon]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetFavoriteIcon]
(
  @FavoriteId int
)

AS
SELECT  IconData
FROM    Favorites
WHERE   (Id = @FavoriteId)
GO
/****** Object:  StoredProcedure [dbo].[InsertCredentialBase]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCredentialBase]
	(
  @UserName nvarchar(255),
  @Domain nvarchar(255),
  @EncryptedPassword nvarchar(max)
	)
AS
	insert into CredentialBase 
  (UserName, Domain, EncryptedPassword)
  values  
  (@UserName, @Domain, @EncryptedPassword)

  select SCOPE_IDENTITY() as Id
GO
/****** Object:  StoredProcedure [dbo].[InsertFavorite]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFavorite]
	(
	@Name nvarchar(255),
  @Protocol nvarchar(5),
  @Port int,
  @ServerName nvarchar(255),
  @NewWindow bit,
  @DesktopShare nvarchar(255),
  @Notes nvarchar(500)
	)
AS
	insert into Favorites 
  (Name, Protocol, Port, ServerName, NewWindow,
  DesktopShare, Notes)
  
  values (@Name, @Protocol, @Port, @ServerName, @NewWindow,
  @DesktopShare, @Notes)

select SCOPE_IDENTITY() as Id
GO
/****** Object:  StoredProcedure [dbo].[InsertGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertGroup]
	(
  @ParentId int,
  @Name nvarchar(255)
	)
AS
	insert into Groups 
  (ParentId, Name)
  values  
  (@ParentId, @Name)

  select SCOPE_IDENTITY() as Id
GO
/****** Object:  StoredProcedure [dbo].[SetFavoriteIcon]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SetFavoriteIcon]
(
  @FavoriteId int,
  @IconData varbinary(max)
)

AS
update  Favorites
set     IconData = @IconData
WHERE   (Id = @FavoriteId)
GO
/****** Object:  Table [dbo].[Security]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Security](
	[FavoriteId] [int] NOT NULL,
	[CredentialId] [int] NULL,
	[CredentialBaseId] [int] NULL,
 CONSTRAINT [PK_Security] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpdateMasterPasswordKey]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateMasterPasswordKey]
	(
	@NewKey nvarchar(max)
	)
AS
update Options
set Value = @NewKey
where PropertyName = 'MasterPasswordKey'
GO
/****** Object:  StoredProcedure [dbo].[UpdateGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGroup]
	(
	@Id int,
  @ParentId int,
  @Name nvarchar(255)
	)
AS
	update Groups 
  set
  ParentId = @ParentId, Name = @Name
  where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[UpdateFavoriteProtocolProperties]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateFavoriteProtocolProperties]
	(
	@FavoriteId int,
  @ProtocolProperties xml
	)
AS
	update Favorites 
  set
  ProtocolProperties = @ProtocolProperties
  where Id = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[UpdateFavorite]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFavorite]
	(
	@Id int,
	@Name nvarchar(255),
  @Protocol nvarchar(5),
  @Port int,
  @ServerName nvarchar(255),
  @NewWindow bit,
  @DesktopShare nvarchar(255),
  @Notes nvarchar(500)
	)
AS
	update Favorites 
  set
  Name = @Name, Protocol = @Protocol,
  Port = @Port, ServerName = @ServerName, NewWindow = @NewWindow,
  DesktopShare = @DesktopShare, Notes = @Notes
  where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[UpdateCredentialBase]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCredentialBase]
	(
	@Id int,
  @UserName nvarchar(255),
  @Domain nvarchar(255),
  @EncryptedPassword nvarchar(max)
	)
AS
	update CredentialBase 
  set
  UserName = @UserName, Domain = @Domain, EncryptedPassword = @EncryptedPassword
  where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[UpdateSecurity]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSecurity]
	(
	@FavoriteId int,
	@CredentialId int,
  @CredentialBaseId int
	)
AS
	update Security 
  set
  CredentialId = @CredentialId, CredentialBaseId = @CredentialBaseId
  where  FavoriteId = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[UpdateBeforeConnectExecute]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBeforeConnectExecute]
	(
	@FavoriteId int,
  @Enabled bit,
  @Command nvarchar(255),
  @CommandArguments nvarchar(255),
  @InitialDirectory nvarchar(255),
  @WaitForExit bit
	)
AS
	update BeforeConnectExecute 
  set
  Enabled = @Enabled, Command = @Command, 
  CommandArguments = @CommandArguments, InitialDirectory = @InitialDirectory,
  WaitForExit = @WaitForExit
  where FavoriteId = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[UpdateDisplayOptions]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateDisplayOptions]
	(
	@FavoriteId int,
  @Height int,
  @Width int,
  @Size tinyint,
  @Colors tinyint
	)
AS
	update DisplayOptions 
  set
  Height = @Height, Width = @Width, Size = @Size, Colors = @Colors
    where FavoriteId = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[UpdateCredentials]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCredentials]
	(
	  @Id int,
    @Name nvarchar(255),
    @UserName nvarchar(255),
    @Domain nvarchar(255),
    @EncryptedPassword nvarchar(max)
	)
AS
	update CredentialBase 
  set
  UserName = @UserName, Domain = @Domain, EncryptedPassword = @EncryptedPassword
  where Id = @Id

	update Credentials 
  set
  Name = @Name
  where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[InsertSecurity]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSecurity]
	(
	@FavoriteId int,
	@CredentialId int,
  @CredentialBaseId int
	)
AS
	insert into Security (FavoriteId, CredentialId, CredentialBaseId)
  values (@FavoriteId, @CredentialId, @CredentialBaseId)
GO
/****** Object:  StoredProcedure [dbo].[InsertHistory]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertHistory]
	(
	@FavoriteId int,
    @Date datetime,
    @UserSid nvarchar(255)
	)
AS

  declare @hasHistory int
  
  select @hasHistory = count(FavoriteId) from History
  where FavoriteId = @FavoriteId and UserSid = @UserSid and
        DATEADD(ms, -DATEPART(ms, Date), Date) = DATEADD(ms, -DATEPART(ms, @Date), @Date)
	
  if @hasHistory = 0
  begin
	insert into History 
	  (FavoriteId, Date, UserSid)
	values  
	  (@FavoriteId, @Date, @UserSid)
  end
GO
/****** Object:  StoredProcedure [dbo].[InsertFavoritesInGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFavoritesInGroup]
	(
	@FavoriteId int,
  @GroupId int
	)
AS
	insert into FavoritesInGroup 
  (FavoriteId, GroupId)
  values  
  (@FavoriteId, @GroupId)
GO
/****** Object:  StoredProcedure [dbo].[InsertDisplayOptions]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDisplayOptions]
	(
	@FavoriteId int,
  @Height int,
  @Width int,
  @Size tinyint,
  @Colors tinyint
	)
AS
	insert into DisplayOptions 
  (FavoriteId, Height, Width, Size, Colors)
  values  
  (@FavoriteId, @Height, @Width, @Size, @Colors)
GO
/****** Object:  StoredProcedure [dbo].[InsertCredentials]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCredentials]
	(
  @Name nvarchar(255),
  @UserName nvarchar(255),
  @Domain nvarchar(255),
  @EncryptedPassword nvarchar(max)
	)
AS
  declare @CredentialsBaseId int  
  
  insert into CredentialBase 
  (UserName, Domain, EncryptedPassword)
  values  
  (@UserName, @Domain, @EncryptedPassword)

  set @CredentialsBaseId = SCOPE_IDENTITY()

  insert into Credentials 
  (Name, Id)
  values  
  (@Name, @CredentialsBaseId)

select @CredentialsBaseId as Id
GO
/****** Object:  StoredProcedure [dbo].[InsertBeforeConnectExecute]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBeforeConnectExecute]
	(
	@FavoriteId int,
  @Enabled bit,
  @Command nvarchar(255),
  @CommandArguments nvarchar(255),
  @InitialDirectory nvarchar(255),
  @WaitForExit bit
	)
AS
	insert into BeforeConnectExecute 
  (FavoriteId, Enabled, Command, CommandArguments, InitialDirectory,
   WaitForExit)
  
  values  (@FavoriteId, @Enabled, @Command, @CommandArguments,
  @InitialDirectory, @WaitForExit)
GO
/****** Object:  StoredProcedure [dbo].[GetFavoriteGroups]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetFavoriteGroups]
	(
	@favoriteId int
	)
AS
SELECT DISTINCT GroupId
FROM         FavoritesInGroup
WHERE     (FavoriteId = @favoriteId)
GO
/****** Object:  StoredProcedure [dbo].[GetFavoritesInGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFavoritesInGroup]
	(
	@groupId int
	)
AS
	SELECT DISTINCT FavoriteId
FROM FavoritesInGroup
WHERE GroupId = @groupId
GO
/****** Object:  StoredProcedure [dbo].[GetFavoritesHistoryByDate]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFavoritesHistoryByDate]
	(
  @From datetime,
  @To datetime
	)
AS
	select distinct FavoriteId from History 
  where @From < Date and  Date < @To
GO
/****** Object:  StoredProcedure [dbo].[DeleteFavoritesInGroup]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DeleteFavoritesInGroup]
	(
	@FavoriteId int,
  @GroupId int
	)
AS
	delete from FavoritesInGroup 
  where
  FavoriteId = @FavoriteId and GroupId = @GroupId
GO
/****** Object:  StoredProcedure [dbo].[DeleteDisplayOptions]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteDisplayOptions]
	(
	@FavoriteId int
	)
AS
	delete from DisplayOptions where FavoriteId = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[DeleteSecurity]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteSecurity]
	(
	@FavoriteId int,
  @Credential int,
  @CredentialBaseId int
	)
AS
	delete from Security 
  where FavoriteId = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[DeleteBeforeConnectExecute]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBeforeConnectExecute]
	(
	@FavoriteId int
	)
AS
	delete from BeforeConnectExecute where FavoriteId = @FavoriteId
GO
/****** Object:  StoredProcedure [dbo].[ClearHistory]    Script Date: 04/16/2013 16:51:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClearHistory]

AS
	delete from History
	RETURN
GO
/****** Object:  ForeignKey [FK_Groups_Groups]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Groups] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Groups] ([Id])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Groups]
GO
/****** Object:  ForeignKey [FK_BeforeConnectExecute_BeforeConnectExecute]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[BeforeConnectExecute]  WITH CHECK ADD  CONSTRAINT [FK_BeforeConnectExecute_BeforeConnectExecute] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BeforeConnectExecute] CHECK CONSTRAINT [FK_BeforeConnectExecute_BeforeConnectExecute]
GO
/****** Object:  ForeignKey [FK_Credentials_CredentialBase]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[Credentials]  WITH CHECK ADD  CONSTRAINT [FK_Credentials_CredentialBase] FOREIGN KEY([Id])
REFERENCES [dbo].[CredentialBase] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Credentials] CHECK CONSTRAINT [FK_Credentials_CredentialBase]
GO
/****** Object:  ForeignKey [FK_DisplayOptions_Favorites]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[DisplayOptions]  WITH CHECK ADD  CONSTRAINT [FK_DisplayOptions_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DisplayOptions] CHECK CONSTRAINT [FK_DisplayOptions_Favorites]
GO
/****** Object:  ForeignKey [FK_FavoritesInGroup_Favorites]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[FavoritesInGroup]  WITH CHECK ADD  CONSTRAINT [FK_FavoritesInGroup_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FavoritesInGroup] CHECK CONSTRAINT [FK_FavoritesInGroup_Favorites]
GO
/****** Object:  ForeignKey [FK_FavoritesInGroup_Groups]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[FavoritesInGroup]  WITH CHECK ADD  CONSTRAINT [FK_FavoritesInGroup_Groups] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FavoritesInGroup] CHECK CONSTRAINT [FK_FavoritesInGroup_Groups]
GO
/****** Object:  ForeignKey [FK_History_Favorites]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Favorites]
GO
/****** Object:  ForeignKey [FK_Security_CredentialBase]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[Security]  WITH CHECK ADD  CONSTRAINT [FK_Security_CredentialBase] FOREIGN KEY([CredentialBaseId])
REFERENCES [dbo].[CredentialBase] ([Id])
GO
ALTER TABLE [dbo].[Security] CHECK CONSTRAINT [FK_Security_CredentialBase]
GO
/****** Object:  ForeignKey [FK_Security_Favorites]    Script Date: 04/16/2013 16:51:40 ******/
ALTER TABLE [dbo].[Security]  WITH CHECK ADD  CONSTRAINT [FK_Security_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Security] CHECK CONSTRAINT [FK_Security_Favorites]
GO
