USE [master]
GO
/****** Object:  Database [Blend]    Script Date: 08/12/2021 12:21:22 ******/
CREATE DATABASE [Blend]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Blend', FILENAME = N'S:\Data\Blend.mdf' , SIZE = 6592KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Blend_log', FILENAME = N'S:\Data\Blend_log.ldf' , SIZE = 12352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Blend] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Blend].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [Blend] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Blend] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Blend] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Blend] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Blend] SET ARITHABORT OFF 
GO
ALTER DATABASE [Blend] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Blend] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [Blend] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Blend] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Blend] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Blend] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Blend] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Blend] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Blend] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Blend] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Blend] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Blend] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Blend] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Blend] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Blend] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Blend] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Blend] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Blend] SET RECOVERY FULL 
GO
ALTER DATABASE [Blend] SET  MULTI_USER 
GO
ALTER DATABASE [Blend] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Blend] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Blend] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Blend] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Blend] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Blend] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Blend] SET QUERY_STORE = OFF
GO
USE [Blend]
GO
/****** Object:  User [Vincent]    Script Date: 08/12/2021 12:21:23 ******/
CREATE USER [Vincent] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ReadOnly]    Script Date: 08/12/2021 12:21:23 ******/
CREATE USER [ReadOnly] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Blend]    Script Date: 08/12/2021 12:21:23 ******/
CREATE USER [Blend] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[BlendCalculationTable]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[BlendCalculationTable](@lngComposition [int], @lngCompositionType [int], @strProject [nvarchar](4000), @strUser [nvarchar](4000), @strResult [nvarchar](4000))
RETURNS  TABLE (
	[lngCompositionId] [int] NULL,
	[lngProductId] [int] NULL,
	[decCompositionResultWeight] [decimal](18, 9) NULL,
	[strMessage] [nvarchar](200) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [BlendCalculation].[BlendCalculation.UserDefinedFunctions].[BlendCalculationTable]
GO
/****** Object:  View [dbo].[vwCPais_sysUser]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCPais_sysUser]
AS
SELECT     uid, name
FROM         sys.sysusers WITH (READPAST)
WHERE     (name = 'Blend') OR
                      (name = N'ReadOnly')
GO
/****** Object:  Table [dbo].[tblCPais_Client]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_Client](
	[lngIdClient] [bigint] IDENTITY(1,1) NOT NULL,
	[strClientName] [nvarchar](50) NOT NULL,
	[strClientStreetNumber] [nvarchar](50) NULL,
	[strClientZipCode] [nvarchar](50) NULL,
	[strClientCity] [nvarchar](50) NULL,
	[strClientPhone] [nvarchar](50) NULL,
	[strClientFax] [nvarchar](50) NULL,
	[strClientEmail] [nvarchar](50) NULL,
 CONSTRAINT [prkClient] PRIMARY KEY CLUSTERED 
(
	[lngIdClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_ClientContactPerson]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_ClientContactPerson](
	[lngIdClientContactPerson] [bigint] IDENTITY(1,1) NOT NULL,
	[lngClientId] [bigint] NOT NULL,
	[lngContactPersonId] [bigint] NOT NULL,
 CONSTRAINT [prkClientContactPerson] PRIMARY KEY CLUSTERED 
(
	[lngIdClientContactPerson] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_Composition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_Composition](
	[lngIdComposition] [bigint] IDENTITY(1,1) NOT NULL,
	[strCompositionDescription] [nvarchar](100) NULL,
	[lngCompositionNumber] [bigint] NULL,
	[strCompositionComment] [nvarchar](1000) NULL,
	[decOrderWeight] [decimal](9, 2) NULL,
	[decHectare] [decimal](9, 2) NULL,
	[dtmComposition] [datetime] NULL,
	[lngLocationId] [bigint] NULL,
	[lngCompositionTypeId] [bigint] NULL,
	[lngClientId] [bigint] NULL,
	[lngContactPersonId] [bigint] NULL,
	[strPlot] [nvarchar](50) NULL,
	[strPlant] [nvarchar](50) NULL,
 CONSTRAINT [prkComposition] PRIMARY KEY CLUSTERED 
(
	[lngIdComposition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_CompositionExercise]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_CompositionExercise](
	[lngIdCompositionExercise] [bigint] IDENTITY(1,1) NOT NULL,
	[lngCompositionId] [bigint] NOT NULL,
	[lngNutrientId] [bigint] NOT NULL,
	[decMinimum] [decimal](18, 5) NOT NULL,
	[decMaximum] [decimal](18, 5) NOT NULL,
	[blnAllowed] [bit] NOT NULL,
 CONSTRAINT [prkCompositionExercise] PRIMARY KEY CLUSTERED 
(
	[lngIdCompositionExercise] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_CompositionResult]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_CompositionResult](
	[lngIdCompositionResult] [bigint] IDENTITY(1,1) NOT NULL,
	[lngCompositionId] [bigint] NOT NULL,
	[lngProductId] [bigint] NOT NULL,
	[decCompositionResultWeight] [decimal](18, 5) NOT NULL,
	[strMessage] [nvarchar](200) NULL,
 CONSTRAINT [prkCompositionResult] PRIMARY KEY CLUSTERED 
(
	[lngIdCompositionResult] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_CompositionType]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_CompositionType](
	[lngIdCompositionType] [bigint] IDENTITY(1,1) NOT NULL,
	[strCompositionTypeDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [prkCompositionType] PRIMARY KEY CLUSTERED 
(
	[lngIdCompositionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_ContactPerson]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_ContactPerson](
	[lngIdContactPerson] [bigint] IDENTITY(1,1) NOT NULL,
	[strContactPersonName] [nvarchar](50) NOT NULL,
	[strFaxNumber] [nvarchar](20) NULL,
 CONSTRAINT [prkContactPersoon] PRIMARY KEY CLUSTERED 
(
	[lngIdContactPerson] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_ExtraCost]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_ExtraCost](
	[lngIdExtraCost] [bigint] IDENTITY(1,1) NOT NULL,
	[strExtraCostDescription] [nvarchar](50) NOT NULL,
	[strExtraCostReport] [nvarchar](50) NOT NULL,
	[decExtraCostPrice] [decimal](9, 2) NOT NULL,
 CONSTRAINT [indExtraCost] PRIMARY KEY CLUSTERED 
(
	[lngIdExtraCost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_Location]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_Location](
	[lngIdLocation] [bigint] IDENTITY(1,1) NOT NULL,
	[strLocationDescription] [nvarchar](50) NOT NULL,
	[strLocationStreetNumber] [nvarchar](50) NULL,
	[strLocationZipCode] [nvarchar](50) NULL,
	[strLocationCity] [nvarchar](50) NULL,
	[strLocationPhone] [nvarchar](50) NULL,
	[strLocationFax] [nvarchar](50) NULL,
	[lngMaximumBlendRun] [int] NOT NULL,
 CONSTRAINT [prkLocation] PRIMARY KEY CLUSTERED 
(
	[lngIdLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_LocationExtraCost]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_LocationExtraCost](
	[lngIdLocationExtraCost] [bigint] IDENTITY(1,1) NOT NULL,
	[lngLocationId] [bigint] NOT NULL,
	[lngExtraCostId] [bigint] NOT NULL,
	[decLocationExtraCostPrice] [decimal](9, 2) NOT NULL,
 CONSTRAINT [prkLocationExtraCost] PRIMARY KEY CLUSTERED 
(
	[lngIdLocationExtraCost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_LocationPackaging]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_LocationPackaging](
	[lngIdLocationPackaging] [bigint] IDENTITY(1,1) NOT NULL,
	[lngLocationId] [bigint] NOT NULL,
	[lngPackagingId] [bigint] NOT NULL,
	[decLocationPackagingPrice] [decimal](9, 2) NOT NULL,
 CONSTRAINT [PK_tblCPais_LocationPackaging] PRIMARY KEY CLUSTERED 
(
	[lngIdLocationPackaging] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_LocationProduct]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_LocationProduct](
	[lngIdLocationProduct] [bigint] IDENTITY(1,1) NOT NULL,
	[lngLocationId] [bigint] NOT NULL,
	[lngProductId] [bigint] NOT NULL,
	[decLocationProductPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [prkLocationProduct] PRIMARY KEY CLUSTERED 
(
	[lngIdLocationProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_Nutrient]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_Nutrient](
	[lngIdNutrient] [bigint] IDENTITY(1,1) NOT NULL,
	[strNutrientDescription] [nvarchar](50) NOT NULL,
	[blnNutrientExerciseValue] [bit] NOT NULL,
 CONSTRAINT [prkNutrient] PRIMARY KEY CLUSTERED 
(
	[lngIdNutrient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_Packaging]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_Packaging](
	[lngIdPackaging] [bigint] IDENTITY(1,1) NOT NULL,
	[strPackagingDescription] [nvarchar](50) NOT NULL,
	[decPackagingPrice] [decimal](9, 2) NOT NULL,
 CONSTRAINT [prkEmballage] PRIMARY KEY CLUSTERED 
(
	[lngIdPackaging] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_Product]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_Product](
	[lngIdProduct] [bigint] IDENTITY(1,1) NOT NULL,
	[strProductDescription] [nvarchar](50) NOT NULL,
	[decProductDefaultPrice] [decimal](9, 2) NOT NULL,
	[decDensity] [decimal](9, 2) NULL,
 CONSTRAINT [prkProduct] PRIMARY KEY CLUSTERED 
(
	[lngIdProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_ProductNutrient]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_ProductNutrient](
	[lngIdProductNutrient] [bigint] IDENTITY(1,1) NOT NULL,
	[lngProductId] [bigint] NOT NULL,
	[lngNutrientId] [bigint] NOT NULL,
	[decNutrientValue] [decimal](18, 9) NOT NULL,
 CONSTRAINT [prkProductIngredient] PRIMARY KEY CLUSTERED 
(
	[lngIdProductNutrient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_sysConfigurationItem]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_sysConfigurationItem](
	[lngIdConfigurationItem] [bigint] IDENTITY(1,1) NOT NULL,
	[lngProjectId] [bigint] NOT NULL,
	[strConfigurationItem] [nvarchar](50) NOT NULL,
	[strUser] [nvarchar](50) NOT NULL,
	[strValue] [nvarchar](100) NULL,
 CONSTRAINT [prksysConfigurationItem] PRIMARY KEY CLUSTERED 
(
	[lngIdConfigurationItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_sysProject]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_sysProject](
	[lngIdProject] [bigint] IDENTITY(1,1) NOT NULL,
	[strProject] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblCPais_sysProject] PRIMARY KEY CLUSTERED 
(
	[lngIdProject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_sysRibbon]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_sysRibbon](
	[lngIdRibbon] [bigint] IDENTITY(1,1) NOT NULL,
	[lngProjectId] [bigint] NOT NULL,
	[strRibbonName] [nvarchar](50) NOT NULL,
	[xmlRibbon] [xml] NULL,
 CONSTRAINT [prkRibbon] PRIMARY KEY CLUSTERED 
(
	[lngIdRibbon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPais_sysTable]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPais_sysTable](
	[lngIdTable] [bigint] IDENTITY(1,1) NOT NULL,
	[strInputTableTab] [nvarchar](50) NOT NULL,
	[strInputTableDescription] [nvarchar](50) NOT NULL,
	[lngProjectId] [bigint] NOT NULL,
 CONSTRAINT [PK_tblCPais_sysTable] PRIMARY KEY CLUSTERED 
(
	[lngIdTable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Client] ON 
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (1, N'Triferto B.V.', N'Postbus 462', N'7000AL', N'Doetinchem', N'0314 374074', N'0314 374079', N'jasper.stelwagen@triferto.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (2, N'Agrarische Unie 4', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (3, N'Schleedoorn Neede 2', NULL, NULL, NULL, N'0545291354', N'0545293961', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (4, N'Hans Müller', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (5, N'Hendrix UTD De Wijk 4', NULL, NULL, NULL, N'522 443962', N'522 443977', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (6, N'Roost 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (7, N'Cooperatie Arkervaart-Twente 4', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (8, N'Mertens Horst 2', NULL, NULL, NULL, NULL, N'077 3999117', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (9, N'De Bruijn Agri 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (10, N'GFH Wijnjewoude', N'Mounleane 4', N'9241 HA', N'WIJNJEWOUDE', N'0516 451732', N'0516 451421', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (11, N'Oude Elberink 2', NULL, NULL, NULL, N'+31 (546) 631136', N'+31 (546) 632063', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (12, N'Hermus Mengvoeders B.V. 2', N'Brieltjenspolder 6', N'4921 PJ', N'Made', N'0162 682496', N'0162 686826', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (13, N'Agri Salland', N'Dorpstraat 16', N'8152 bl', N'Lemelerveld', N'0572 372442', N'0572371868', N'AgriSalland@Nutreco.com')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (14, N'Borgelink 2', N'Lattropperstaat 25', N'7591 PJ', N'Denekamp', N'0541-351305', N'0541-351305', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (15, N'Dijk Baflo', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (16, N'Hoekstra Fourages BV', N'Schoterlandseweg 31', N'8414 LM', N'NIEUWEHORNE', N'0513-541258', N'0513-541220', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (17, N'Thiermann', N'Scharringhausen 23', N'27245', N'Kirchdorf', NULL, N'+494273932050', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (18, N'Boegershausen', NULL, NULL, NULL, NULL, N'+49 (421) 6908301', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (19, N'Agrarisch Centrum', N'Schoterlandseweg 24', N'8413 NA', N'OUDEHORNE', N'0513-542056', N'0513-542025', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (20, N'Benthem  Vollenhove 2', N'De Weijert 20', N'8325 EM', N'VOLLENHOVE', N'0527-243322', N'0527-241684', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (21, N'C.A.V. den Ham', N'Dorpsstraat 68', N'7683 BL', N'DEN HAM', N'0546-672525', N'0546-672645', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (22, N'Elsenga & Kieft', N'Kanaalweg 8', N'1733 GJ', N'NIEUWE NIEDORP', N'0226-411560', N'0226-413601', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (23, N'Fieten', N'Riegshoogtendijk 124', N'7913 TB', N'HOLLANDSCHEVELD', N'0528-341293', N'0528-342771', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (24, N'Hoogland B.V. Ferwert', N'Hegebeintumerwei 33B', N'9172 ZS', N'FERWERT', N'0518-411400', N'0518-412491', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (25, N'Maatman', N'Hoofdweg 39', N'8471 ZH', N'WOLVEGA', N'0561-612606', N'0561-612638', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (26, N'Mulder Agro v.o.f. Kollumerzwaag', N'Foarwei 45', N'9298 PP', N'KOLLUMERZWAAG', N'0511-441298', N'0511-443891', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (27, N'Runia Fourage B.V.', N'Wytlansdykje 17', N'8566 JG', N'NIJEMIRDUM', N'0514-571564', N'0514-571683', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (28, N'Sikma Veevoederfabriek', N'Groningerstreek 20', N'9871 PG', N'STROOBOS', N'0512-351281', N'0512-352276', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (29, N'Struik Peter', N'Ambachtswei 4', N'8501 XA', N'JOURE', N'0513-416162', N'0513-417722', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (30, N'Tjoelker Fouragehandel 3', N'Diepswal 44', N'9350 AB', N'LEEK', N'0594-512264', N'0594-512187', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (31, N'Zwaag v.d. - Kroes', N'Schoterlandsweg 24', N'8413 NA', N'OUDEHORNE', N'0513-542056', N'0513-542025', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (32, N'Heus Voeders BV  2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (33, N'Beekhuizen 2', NULL, NULL, NULL, NULL, N'+31 (345) 684441', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (34, N'Visser Engwierum', N'Mounebuorren 35', N'9132 EJ', N'ENGWIERUM', N'0511-408261', N'0511-408256', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (35, N'Agri Oost 2', N'James Wattstraat 2', N'7131ME', N'Lichtenvoorde', N'0544-393100', N'0544-393109', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (38, N'Grevers  Mengvoeders 3', N'Kapelweg 9', N'7050AB', N'Sinderen', N'0315-617229', N'0315-617502', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (39, N'Agri Gelre 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (40, N'Eck Harmelen 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (41, N'Beekhuizen Beesd 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (42, N'Staring Groessen 3', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (43, N'Midland  Barneveld 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (44, N'Pars Graanhandel', N'Kl. De Vriesstraat 20', N'9079 KK', N'ST. JACOBIPAROCHIE', N'0518-491289', N'0518-491242', N'parsgranen@wxs.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (45, N'Fuite 2', NULL, NULL, N'Genemuiden', N'+31(38)3854177', N'+31(38)3856549', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (46, N'Ijsselstreek 5', NULL, NULL, N'Lettele', N'0570-551268', N'0570-551559', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (47, N'Theeuwes Ullicoten 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (48, N'Bos, P, Ederveen 3', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (49, N'Agri Center Z-O  4', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (50, N'Agruniek Didam 5', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (51, N'Iperen BV 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (52, N'Agrimm Amstelveen 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (53, N'Brunsveld  2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (54, N'Arkervaart Twente  Nijkerk 4', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (55, N'Mulders Oudenbosch 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (56, N'Fakkert Diervoeders 9', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (57, N'Linde Fourages 4', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (58, N'Eck, Wijk bij Duurstede 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (59, N'Gool, Hilvarenbeek 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (60, N'Kruidhof H.', N'Oude Rijksweg 411', N'7954 GH', N'ROUVEEN', N'0522-291201', N'0522-291823', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (61, N'Oonk Wierden 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (62, N'Nederkassel 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (63, N'Distel Bentelo 3', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (64, N'Fransen Gerrits 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (65, N'Schuitema Joh. Mussel', N'Zandtangerweg 50', N'9584 AL', N'MUSSEL', N'0599-454214', N'0599-454918', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (66, N'Bolder Angeren 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (67, N'Zevenster 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (68, N'Berkt Hedel 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (69, N'Verhage Kerkwerve 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (70, N'Hidding G.', N'Lottingstraat 4', N'7841 BE', N'SLEEN', N'0591-361279', N'0591-361995', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (71, N'C.A.V.V. Z-O Salland 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (72, N'Fluks B.V. 2', N'Postbus 6', N'9617 ZG', N'HARKSTEDE', N'050-4041201', NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (73, N'Bieleman Veevoeders 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (74, N'Weidse Blik', N'Fricoweg 45', N'9005 PC', N'WERGEA', N'058-2552209', N'058-2551959', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (75, N'Gunnewick Mengvoeders 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (76, N'Agri Combi Midden 4', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (77, N'Wal v.d. Gebr. It Heidenskip', N'Heidenskipsterdyk 18C', N'8724 HV', N'IT HEIDENSKIP', N'0514-521765', N'0514-521425', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (78, N'Velthof Borne 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (79, N'Cooten Diervoeders 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (80, N'Keizer Feerwerd 2', N'Torensmaweg 21', N'9892 TD', N'FEERWERD', N'0594-621218', N'0594-621790', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (81, N'Agri Twente 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (82, N'Politiek Fa.', N'It Fabriek 1', N'8823 SZ', N'LOLLUM', N'0517-469131', N'0517-469432', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (83, N'Dijk Hijken 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (84, N'Hoop  Zelhem 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (85, N'Koning H.W. Winsum', N'Kleasterdyk 48', N'8831 XA', N'WINSUM', N'0517-342187', N'0517-342372', N'koning.fourages@tiscali.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (86, N'Agrab Handelsonderneming', N'P.R. Roelfsemaweg 6', N'9423 RA', N'HOOGERSMILDE', N'0592-459550', N'0592-459955', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (87, N'Vlogman 2', N'Vorden', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (88, N'E.J. Bos 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (89, N'Bos E.J. Ederveen 2', N'Hoofdweg 244', N'6744 WR', N'Ederveen', N'0318-571155', N'0318-571797', N'ejbos@ejbos.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (90, N'Hofman v.o.f.', N'Munnekenweg 6', N'7963 PV', N'RUINEN', N'0522-471703', N'0522-472860', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (91, N'Brandhof Renswoude 3', NULL, NULL, NULL, NULL, N'0318542126', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (92, N'Frieling BV 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (93, N'Vlamings Steenbergen 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (94, N'Timmerman H.J.', N'Hoogenweg 59', N'7792 VE', N'VENEBRUGGE', N'0523-216217', N'0523-216670', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (95, N'Wolswinkel BV 2', N'Asschatterweg 64', N'3831 JW', N'Leusden', N'0342-452000', N'0342-452524', N'info@wolswinkel.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (96, N'Treurniet Mengvoeders 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (97, N'Mol Agrocom 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (98, N'Brons 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (99, N'WPA Dedemsvaart 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (100, N'Hooijmeijer Diervoeders 3', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (101, N'Agrodyn Montfort 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (102, N'Neutkens Vessem 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (103, N'Hendrix UTD Boxmeer', N'Veerstraat 38', N'5831 JN', N'BOXMEER', N'0485-589911', N'0485-573924', N'hendrixutd@nutreco.com')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (104, N'Buiter Roden', N'Kanaalstraat 62', N'9301 LT', N'RODEN', N'06-51451077', N'050-5019265', N'info@buiterroden.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (105, N'RCG Koeln', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (106, N'Loon 2', N'Sprangweg 42', N'4741 RC', N'Hoeven', N'0165-502383', NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (107, N'Boom vd 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (108, N'D.S.D.', N'Fortuinweg 8', N'9101 PE', N'DOKKUM', N'0519-220001', N'0519-220302', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (109, N'Henten 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (110, N'Timmerhuis Veevoeders 3', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (111, N'Triferto Belgie', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (112, N'Bosch Daarle 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (113, N'Langwerden Veevoeders 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (114, N'Bremer', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (115, N'Coop De Eendracht 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (116, N'Niekerk Muiswinkel 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (117, N'Ravenhorst 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (118, N'Postma Fa.', N'De Eker 1', N'8627 SB', N'GAUW', N'0515-521227', N'0515-521792', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (119, N'Wolters P.', N'P. Durksstraat 1A', N'9108 MK', N'BROEKSTERWOUDE', N'0511-421874', N'0511-422812', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (120, N'Feijen 2', N'Rondweg 14', N'7721 AA', N'Dalfsen', N'0529-431327', N'0529-433225', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (122, N'Hoeflake', N'Kon. wilhelmina str 51', N'5321 GG', N'Hedel', N'0735991356', N'0735994079', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (123, N'Agravis Münster', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (124, N'Breden van', N'Oosterweg 67', N'9367 RK', N'DE WILP', N'0594-641320', N'0594-641322', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (125, N'Vries de Haulerwijk', N'Norgerweg 104', N'8433 LS', N'HAULERWIJK', N'0516-421378', N'0516-422367', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (126, N'DV Lux', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (127, N'SAP International Corporation N.V. S.A.', N'Krekelenberg 89', N'B-2980', N'Zoersel', N'+3233090651', N'+3233091931', N'info@sico.be')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (128, N'Agro Buren', N'Marsdijk 29 A', N'4033 LL', N'Lienden', NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (129, N'BOR', NULL, NULL, N'Ameide', NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (130, N'AGRO DE HORNE', N'Schoterlandseweg 24', N'8413 NA', N'OUDEHORNE', N'0513-542056', N'0513-542025', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (131, N'Windhorst van Veen', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (133, N'Profyto', N'Revisieweg 3', NULL, N'Emmeloord', NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (134, N'Bremer GmbH', N'Feldstrasse 11', N'47574', N'GOCH', NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (135, N'Cooperatie De Eeendracht', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (136, N'Beiselen GmbH', N'Magirusstr. 7-9', N'89077', N'ULM', N'+49 731 9342 0', N'+49 731 9342 239', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (137, N'Veldhuizen Bunschoten', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (138, N'Mulder Granen', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (139, N'Jong de Fourage V.O.F.', N'Trekweg 8', N'8763 MD', N'PARREGA', N'0515-579322', N'0515-579264', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (140, N'Hazenberg Grootegast', N'Hoofdstraat 35', N'9861 AA', N'GROOTEGAST', N'0594-612090', N'0594-614080', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (141, N'Groot de, Jaap', N'Zwolseweg 117', N'8275 AD', N'''S HEERENBROEK', N'038-3557503', N'038-3557514', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (142, N'WMU', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (143, N'Lösing', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (144, N'LLS', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (145, N'Alb. Groot Schagerbrug', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (146, N'cul', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (147, N'Mulder A.J. Appelscha', N'Vaart N.Z. 13', N'8426 AN', N'APPELSCHA', N'0516-430602', N'0516-433351', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (148, N'Wal Creil', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (149, N'Agerland', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (150, N'Blonk Moerkapelle', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (151, N'Cooperatie Wijster 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (152, N'Zwama', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (153, N'Visser Heeg', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (154, N'Fonk', N'Doufstegg 10', N'47495', N'Rheinberg', N'+491727550113', N'+49280280450', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (155, N'Woordes', N'Meenkmolenweg 3', NULL, N'Winterswijk', NULL, N'0543 - 565552', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (156, N'Zuidersma Fourages', N'Terheylsterweg 53', N'9311 TA', N'Nieuw Roden', NULL, N'0594-517513', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (157, N'Screever 2', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (158, N'CLTV Zundert', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (159, N'Kuiper', N'Everdningenstraat 31', NULL, NULL, N'0545 221212', NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (160, N'Janszen Buggenum', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (161, N'Evers Putten', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (162, N'Hilkens Swalmen', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (163, N'Bosgoed', N'Zwarte Kolkstraat 100', N'7384 DE', N'Wilp', NULL, NULL, N'diervoeders@bosgoed.ocm')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (164, N'Kamphuis Beckum', N'Wolfkaterweg 53', N'7554 PK', N'Hengelo', NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (165, N'Te Morsche', N'Nijverdalsestraat 50-A', N'7642 AE', N'Wierden', N'00546571479', NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (166, N'Culterra', N'Postbus 6', N'8710 AA', N'Workum', N'0515542424', N'05155592995', N'info@culterra.nl')
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (167, N'VMB Wesepe', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (168, N'Gardenbroek', NULL, NULL, NULL, NULL, N'0525 68 33 59', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (169, N'Boer Groot Ammers', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (170, N'Fa Roeke', N'Herenbrinksweg 4', N'8144RC', N'Lierdreholthuis', N'00572394527', N'00572394753', NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (171, N'Blonk Biddinghuizen', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (172, N'Klein Hekkelder', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (173, N'Agrowin', N'Haven 2', NULL, N'Goor', NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (174, N'meijer rodeschool', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Client] ([lngIdClient], [strClientName], [strClientStreetNumber], [strClientZipCode], [strClientCity], [strClientPhone], [strClientFax], [strClientEmail]) VALUES (175, N'Bos Graszoden', N'Kruisseltseweg 45', N'3888NV', N'Nieuw Milligen', N'0577-456555', N'0577-456433', N'cbos@bosgraszoden.nl')
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Client] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ClientContactPerson] ON 
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (1, 1, 1)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (2, 1, 3)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (3, 1, 8)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (4, 1, 9)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (5, 1, 10)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (6, 1, 11)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (7, 1, 33)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (8, 1, 147)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (9, 1, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (10, 2, 5)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (11, 2, 6)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (12, 2, 32)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (13, 2, 51)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (14, 2, 71)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (15, 2, 99)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (16, 2, 109)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (17, 2, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (18, 2, 186)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (19, 2, 191)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (20, 2, 192)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (21, 2, 210)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (22, 2, 215)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (23, 2, 221)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (24, 2, 242)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (25, 2, 310)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (26, 2, 311)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (27, 2, 320)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (28, 3, 7)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (29, 3, 160)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (30, 5, 18)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (31, 5, 138)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (32, 5, 175)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (33, 6, 19)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (34, 6, 95)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (35, 7, 21)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (36, 7, 22)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (37, 7, 23)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (38, 8, 24)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (39, 9, 25)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (40, 9, 128)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (41, 9, 137)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (42, 9, 195)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (43, 9, 207)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (44, 9, 274)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (45, 10, 38)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (46, 10, 154)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (47, 10, 176)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (48, 10, 183)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (49, 11, 26)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (50, 11, 52)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (51, 11, 248)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (52, 12, 27)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (53, 13, 28)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (54, 13, 29)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (55, 14, 116)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (56, 16, 302)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (57, 17, 35)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (58, 18, 36)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (59, 20, 166)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (60, 20, 190)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (61, 21, 37)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (62, 21, 110)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (63, 21, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (64, 21, 167)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (65, 21, 220)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (66, 22, 269)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (67, 24, 224)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (68, 24, 225)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (69, 25, 312)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (70, 25, 313)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (71, 26, 292)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (72, 27, 40)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (73, 27, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (74, 27, 323)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (75, 28, 135)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (76, 29, 156)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (77, 29, 157)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (78, 29, 285)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (79, 30, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (80, 30, 256)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (81, 30, 257)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (82, 30, 258)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (83, 32, 42)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (84, 32, 43)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (85, 32, 90)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (86, 32, 182)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (87, 32, 270)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (88, 32, 280)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (89, 32, 288)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (90, 33, 45)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (91, 34, 243)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (92, 35, 106)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (93, 35, 171)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (94, 38, 163)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (95, 39, 53)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (96, 40, 54)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (97, 40, 55)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (98, 40, 266)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (99, 41, 45)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (100, 42, 57)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (101, 42, 92)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (102, 43, 58)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (103, 43, 59)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (104, 44, 317)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (105, 44, 318)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (106, 44, 319)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (107, 45, 60)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (108, 45, 66)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (109, 45, 103)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (110, 45, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (111, 45, 219)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (112, 45, 227)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (113, 46, 61)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (114, 46, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (115, 47, 62)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (116, 48, 63)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (117, 48, 64)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (118, 48, 307)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (119, 49, 65)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (120, 49, 115)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (121, 49, 306)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (122, 50, 67)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (123, 50, 68)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (124, 50, 69)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (125, 50, 70)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (126, 50, 75)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (127, 50, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (128, 50, 244)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (129, 51, 72)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (130, 51, 73)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (131, 51, 74)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (132, 51, 287)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (133, 51, 300)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (134, 52, 84)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (135, 53, 57)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (136, 53, 197)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (137, 54, 76)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (138, 54, 113)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (139, 54, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (140, 54, 209)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (141, 54, 308)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (142, 54, 309)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (143, 55, 108)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (144, 55, 141)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (145, 56, 164)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (146, 56, 165)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (147, 56, 208)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (148, 57, 82)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (149, 57, 97)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (150, 57, 281)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (151, 58, 83)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (152, 59, 87)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (153, 60, 247)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (154, 61, 88)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (155, 62, 89)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (156, 63, 91)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (157, 64, 168)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (158, 64, 174)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (159, 66, 94)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (160, 67, 96)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (161, 68, 98)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (162, 69, 100)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (163, 70, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (164, 71, 102)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (165, 71, 119)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (166, 73, 104)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (167, 74, 297)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (168, 75, 105)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (169, 75, 133)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (170, 75, 236)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (171, 76, 107)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (172, 78, 108)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (173, 79, 111)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (174, 79, 112)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (175, 80, 228)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (176, 81, 193)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (177, 83, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (178, 84, 118)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (179, 85, 298)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (180, 86, 238)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (181, 87, 120)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (182, 89, 121)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (183, 90, 315)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (184, 91, 122)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (185, 91, 123)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (186, 92, 199)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (187, 92, 267)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (188, 93, 124)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (189, 93, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (190, 95, 127)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (191, 95, 275)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (192, 95, 322)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (193, 96, 129)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (194, 96, 265)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (195, 97, 130)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (196, 99, 131)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (197, 100, 132)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (198, 101, 134)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (199, 102, 136)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (200, 103, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (201, 104, 328)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (202, 104, 329)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (203, 104, 330)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (204, 105, 139)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (205, 106, 201)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (206, 107, 141)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (207, 108, 142)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (208, 108, 155)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (209, 109, 144)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (210, 110, 145)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (211, 111, 146)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (212, 111, 147)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (213, 112, 148)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (214, 112, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (215, 112, 326)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (216, 113, 150)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (217, 113, 151)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (218, 115, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (219, 115, 290)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (220, 115, 304)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (221, 115, 314)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (222, 117, 162)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (223, 118, 237)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (224, 119, 246)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (225, 120, 170)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (226, 122, 172)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (227, 123, 178)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (228, 123, 211)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (229, 123, 212)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (230, 125, 316)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (231, 126, 177)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (232, 127, 179)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (233, 128, 181)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (234, 130, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (235, 130, 259)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (236, 130, 260)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (237, 130, 261)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (238, 130, 262)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (239, 130, 263)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (240, 130, 264)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (241, 130, 272)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (242, 131, 187)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (243, 133, 188)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (244, 133, 226)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (245, 133, 233)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (246, 134, 204)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (247, 137, 194)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (248, 138, 196)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (249, 139, 198)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (250, 140, 268)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (251, 142, 284)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (252, 144, 205)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (253, 145, 223)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (254, 146, 216)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (255, 146, 217)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (256, 146, 218)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (257, 148, 229)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (258, 149, 230)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (259, 150, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (260, 151, 234)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (261, 152, 239)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (262, 152, 240)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (263, 152, 241)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (264, 154, 245)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (265, 155, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (266, 156, 271)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (267, 157, 273)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (268, 159, 276)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (269, 160, 277)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (270, 161, 278)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (271, 162, 279)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (272, 163, 282)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (273, 164, 7)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (274, 164, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (275, 164, 283)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (276, 164, 301)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (277, 164, 321)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (278, 165, 286)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (279, 166, 289)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (280, 167, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (281, 168, 291)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (282, 169, 293)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (283, 170, 294)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (284, 171, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (285, 172, 295)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (286, 172, 296)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (287, 173, 149)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (288, 173, 299)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (289, 174, 325)
GO
INSERT [dbo].[tblCPais_ClientContactPerson] ([lngIdClientContactPerson], [lngClientId], [lngContactPersonId]) VALUES (290, 175, 327)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ClientContactPerson] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Composition] ON 
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9272, N'Samenstelling ADMBis 1 - Agerland', 1, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2009-10-16T09:48:30.000' AS DateTime), 6, 1, 149, 230, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9273, N'Samenstelling ADMBis 2 - Agerland', 2, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2009-10-16T09:49:13.000' AS DateTime), 6, 1, 149, 230, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9274, N'Samenstelling ADMBis 3 - Agerland', 3, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(200.00 AS Decimal(9, 2)), CAST(N'2009-10-16T10:20:42.000' AS DateTime), 6, 1, 149, 230, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9275, N'Samenstelling ADMBis 4 - Agerland', 4, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2009-12-08T10:14:57.000' AS DateTime), 6, 1, 149, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9276, N'Samenstelling ADMBis 5', 5, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2009-12-08T15:41:34.607' AS DateTime), 6, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9277, N'Samenstelling ADMBis 6', 6, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-17T21:12:30.000' AS DateTime), 6, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9278, N'Samenstelling ADMBis 7', 7, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-18T17:35:26.000' AS DateTime), 1, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9279, N'Samenstelling ADMBis 8', 8, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-19T11:20:49.000' AS DateTime), 1, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9280, N'Samenstelling ADMBis 9 - Agrarisch Centrum', 9, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-06-04T20:04:45.000' AS DateTime), 1, 1, 19, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9281, N'Samenstelling ADMBis 10', 10, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T10:55:45.887' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9282, N'Samenstelling ADMBis 11', 11, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T13:35:05.033' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9283, N'Samenstelling ADMBis 12', 12, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T13:38:06.477' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9284, N'Samenstelling ADMBis 13', 13, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T13:47:03.057' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9285, N'Samenstelling ADMBis 14', 14, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T13:50:52.500' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9286, N'Samenstelling ADMBis 15', 15, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T13:55:24.137' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9287, N'Samenstelling ADMBis 16', 16, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T14:00:24.900' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9288, N'Samenstelling ADMBis 17', 17, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T14:03:09.887' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9289, N'Samenstelling ADMBis 18', 18, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T15:19:09.223' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9290, N'Samenstelling ADMBis 19', 19, N'comment', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-03-25T15:35:57.710' AS DateTime), 1, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[tblCPais_Composition] ([lngIdComposition], [strCompositionDescription], [lngCompositionNumber], [strCompositionComment], [decOrderWeight], [decHectare], [dtmComposition], [lngLocationId], [lngCompositionTypeId], [lngClientId], [lngContactPersonId], [strPlot], [strPlant]) VALUES (9291, N'Samenstelling ADMBis 20', 20, N'LET OP: Prijs geldig tot 31 oktober 2008.', CAST(1000.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)), CAST(N'2010-06-04T20:05:02.000' AS DateTime), 1, 1, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Composition] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_CompositionExercise] ON 
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40049, 9272, 1, CAST(15.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40050, 9272, 2, CAST(15.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40051, 9272, 3, CAST(15.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40052, 9273, 1, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40053, 9273, 2, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40054, 9273, 3, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40055, 9273, 19, CAST(1.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40056, 9274, 1, CAST(20.00000 AS Decimal(18, 5)), CAST(100.00000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40057, 9274, 2, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40058, 9274, 3, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40059, 9274, 49, CAST(15.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40060, 9275, 1, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40061, 9275, 2, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40062, 9275, 3, CAST(12.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40066, 9276, 4, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40067, 9276, 5, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40068, 9276, 6, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40069, 9277, 1, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40070, 9277, 2, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40071, 9277, 3, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40072, 9277, 14, CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), 0)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40073, 9277, 5, CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), 0)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40074, 9277, 8, CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), 0)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40075, 9278, 1, CAST(20.00000 AS Decimal(18, 5)), CAST(20.00000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40076, 9278, 2, CAST(20.00000 AS Decimal(18, 5)), CAST(20.00000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40077, 9278, 3, CAST(20.00000 AS Decimal(18, 5)), CAST(20.00000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40080, 9279, 1, CAST(23.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40081, 9279, 2, CAST(24.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40082, 9279, 3, CAST(30.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40083, 9280, 1, CAST(22.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40084, 9280, 2, CAST(22.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40085, 9280, 3, CAST(22.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40086, 9281, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40087, 9281, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40088, 9281, 3, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40089, 9282, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40090, 9282, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40091, 9282, 3, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40092, 9283, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40093, 9283, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40094, 9283, 3, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40095, 9284, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40096, 9284, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40097, 9284, 3, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40098, 9285, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40099, 9285, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40100, 9285, 3, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40101, 9286, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40102, 9286, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40103, 9286, 3, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40104, 9287, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40105, 9287, 2, CAST(2.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40106, 9287, 3, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40107, 9287, 19, CAST(3.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40108, 9288, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40109, 9288, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40110, 9288, 3, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40111, 9288, 14, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40112, 9288, 19, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40113, 9289, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40114, 9289, 2, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40115, 9289, 3, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40116, 9289, 19, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40118, 9290, 1, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40119, 9290, 2, CAST(0.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40120, 9290, 3, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40121, 9290, 14, CAST(20.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40128, 9291, 1, CAST(5.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40129, 9291, 2, CAST(10.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
INSERT [dbo].[tblCPais_CompositionExercise] ([lngIdCompositionExercise], [lngCompositionId], [lngNutrientId], [decMinimum], [decMaximum], [blnAllowed]) VALUES (40130, 9291, 3, CAST(15.00000 AS Decimal(18, 5)), CAST(9999.99000 AS Decimal(18, 5)), 1)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_CompositionExercise] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_CompositionResult] ON 
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32920, 9272, 37, CAST(33.33330 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32921, 9272, 2, CAST(20.15580 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32922, 9272, 27, CAST(43.73830 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32923, 9273, 17, CAST(45.45450 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32924, 9273, 37, CAST(44.44440 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32925, 9273, 2, CAST(24.21930 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32926, 9273, 27, CAST(40.05100 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32949, 9274, 2, CAST(83.33333 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32950, 9274, 37, CAST(44.44440 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32951, 9274, 1, CAST(18.51850 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32961, 9275, 37, CAST(26.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32962, 9275, 2, CAST(36.87230 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32963, 9275, 27, CAST(12.93460 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32983, 9277, 0, CAST(0.00000 AS Decimal(18, 5)), N'Er is geen oplossing mogelijk, er zijn geen grondstoffen voor de gevraagde nutriënt: [1, Stikstof Totaal (N-tot)]')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32997, 9278, 8, CAST(33.33330 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32998, 9278, 2, CAST(35.51400 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (32999, 9278, 27, CAST(52.33640 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33009, 9279, 8, CAST(50.00000 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33010, 9279, 2, CAST(43.27100 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33011, 9279, 27, CAST(58.50470 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33013, 9281, 8, CAST(16.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33014, 9282, 8, CAST(16.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33016, 9283, 8, CAST(16.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33037, 9287, 16, CAST(14.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33038, 9287, 8, CAST(16.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33039, 9287, 17, CAST(36.36360 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33044, 9289, 4, CAST(22.22220 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33052, 9290, 8, CAST(10.36270 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33053, 9290, 12, CAST(34.38530 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33057, 9280, 8, CAST(36.66670 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33058, 9280, 2, CAST(39.06540 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33059, 9280, 27, CAST(57.57010 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33060, 9291, 8, CAST(25.00000 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33061, 9291, 2, CAST(21.02800 AS Decimal(18, 5)), N'')
GO
INSERT [dbo].[tblCPais_CompositionResult] ([lngIdCompositionResult], [lngCompositionId], [lngProductId], [decCompositionResultWeight], [strMessage]) VALUES (33062, 9291, 27, CAST(4.67290 AS Decimal(18, 5)), N'')
GO
SET IDENTITY_INSERT [dbo].[tblCPais_CompositionResult] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_CompositionType] ON 
GO
INSERT [dbo].[tblCPais_CompositionType] ([lngIdCompositionType], [strCompositionTypeDescription]) VALUES (2, N'Berekening blend naar 100 kilogram')
GO
INSERT [dbo].[tblCPais_CompositionType] ([lngIdCompositionType], [strCompositionTypeDescription]) VALUES (1, N'Berekening blend per hectare')
GO
INSERT [dbo].[tblCPais_CompositionType] ([lngIdCompositionType], [strCompositionTypeDescription]) VALUES (4, N'Berekening internet naar 100 kilogram')
GO
INSERT [dbo].[tblCPais_CompositionType] ([lngIdCompositionType], [strCompositionTypeDescription]) VALUES (3, N'Berekening internet per hectare')
GO
SET IDENTITY_INSERT [dbo].[tblCPais_CompositionType] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ContactPerson] ON 
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (1, N'Kees van den Heuvel', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (2, N'Francois', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (3, N'Sabine', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (4, N'Fokke Smit 0595 415121', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (5, N'H. Altena 0528 391108', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (6, N'J.W. Krijt 0575 442796', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (7, N'Paul Schleedoorn', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (8, N'Gert Jan de Groot', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (9, N'Bart Krijt', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (10, N'Klaus Junst', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (11, N'Luuk Hagting', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (13, N'W.J Jensma 050 3049137', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (14, N'D Zuur 050 3023594', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (15, N'H. Boels 0591 387175', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (16, N'J. Kunst 0505011696', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (17, N'Emmeloord +31 (527) 618611', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (18, N'W Dekker', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (19, N'George Brands', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (21, N'clemens vd Aa', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (22, N'Annette', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (23, N'Evert', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (24, N'John Haanen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (25, N'Peter de Bruijn', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (26, N'Raymond Hoppen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (27, N'Kees van Loenhout', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (28, N'Marcel Poppe', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (29, N'J. Wilms', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (30, N'G. Nij Bijvank', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (31, N'Chr.  Bleeker 0527262054', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (32, N'Paul Hooijma527261117', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (33, N'Terry van Loon', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (34, N'Broersma Egbert', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (35, N'Thiermann', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (36, N'Eckhard', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (37, N'Kosters Bertus', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (38, N'Kootstra Rinze', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (39, N'Hamminga Erik 06-20437380', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (40, N'Heeringa Joh. 06-53319049 fax 0513-417958', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (41, N'Wolters Anna 06-51421645', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (42, N'Piet Jan de Vries 0516 523466', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (43, N'Harold van Raaij', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (44, N'Henk Verdoold', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (45, N'Henk van Beekhuizen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (46, N'Frans Evers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (47, N'Mark', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (48, N'Jan Veninga', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (49, N'Henri Altena', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (50, N'Jan Veninga 0599-584924', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (51, N'Henri Altena 0528-391108', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (52, N'Andre Kleineschaars', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (53, N'Victor Berntsen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (54, N'Andre Tichelhoven', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (55, N'Adriaan Korevaar', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (57, N'Mark Ter Braak', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (58, N'Jan van Dijk', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (59, N'Peter Schermers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (60, N'erik Aalbers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (61, N'Maurice Severt', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (62, N'dhr Smulders', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (63, N'Hartger v Veldhuizen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (64, N'Geurt vd Fliert', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (65, N'P vd Kolk 0486 416664', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (66, N'dhr Drent  0528 361074', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (67, N'Conny Ernst', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (68, N'Wim Boschloo', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (69, N'Wim Krajenbrink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (70, N'Joost Guiven', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (71, N'm. van Hemmen 0597 530722', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (72, N'Dirk Jan Bakker', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (73, N'Peter Kalkman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (74, N'Jan de Gelder', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (75, N'R Krabbenborg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (76, N'Gerrit Heijstra', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (77, N'Jan Aaldrikman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (80, N'Robert Fakkert', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (81, N'Ernst Vreeswijk', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (82, N'G Hoogenboom', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (83, N'Gert Jan van Eck', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (84, N'Nico Immink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (85, N'Jan Kunst 050- 5011696', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (86, N'Douwe Zuur 050-3025050', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (87, N'Ben van Gool', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (88, N'Hans Oonk', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (89, N'Hans van Os', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (90, N'Jan-Roelof Jalving 0522 480944', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (91, N'Han D. 0547292137', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (92, N'dhr Staring', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (94, N'Hans Bolder', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (95, N'Helmus Roost', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (96, N'Jan Kuipers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (97, N'Ben van Asselt', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (98, N'dhr vd Berkt', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (99, N'Hans Boels 0591387175', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (100, N'Adri Verhage', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (101, N'Lex Slootweg 0321 320307', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (102, N'dhr Rotink 0548 595205', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (103, N'van Putten', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (104, N'Jan Bieleman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (105, N'Ronald Wolters', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (106, N'Ard Nijland', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (107, N'Ko vd Heide', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (108, N'Rene Mulders', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (109, N'Henri vd Vinne 0527 618611', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (110, N'Gert Roelofs', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (111, N'Frans van Cooten', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (112, N'Evert  Legemaat', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (113, N'Roel van Ee', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (114, N'roel', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (115, N'dhr Verbrugge 0478 642158', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (116, N'Herman Borgelink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (117, N'Guus Sonder', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (118, N'dhr Boeijink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (119, N'L. Schoorlemmer', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (120, N'Herman Vlogman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (121, N'Marius van Laar', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (122, N'Kees Bos', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (123, N'dhr. Vd Brandhof', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (124, N'Ad de Hoon', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (127, N'Marco vd Wind', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (128, N'Edwin Broeders', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (129, N'Hilco Eijkelenboom', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (130, N'Jaco van Beem', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (131, N'van Willigen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (132, N'Tonnie Hooijmeijer', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (133, N'Mark van Uun', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (134, N'M. Hamers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (135, N'jan dijkstra', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (136, N'Bart van Kollenburg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (137, N'Ron Vennix', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (138, N'Dirk Jensma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (139, N'rcg koeln', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (140, N'Mike van Loon', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (141, N'E. Verbrugge', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (142, N'Tjalling Nutma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (143, N'Wilco Jensma 050-3049137', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (144, N'R. van Henten', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (145, N'Jan Timmerhuis', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (146, N'Stefaan Pockele', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (147, N'Jan Campforts', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (148, N'Gerben Brinks', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (149, N'Kantoor', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (150, N'Bert Dubbink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (151, N'Harry Langwerden', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (153, N'E Verbrugge', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (154, N'Buitenga Dirk', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (155, N'Heslinga Herman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (156, N'Bosman Harold', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (157, N'Westra Lucas', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (158, N'van den Dool', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (159, N'Kalfsbeek J. ', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (160, N'Gerjan v Apeldoorn', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (161, N'W. Damveld', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (162, N'Rien', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (163, N'Mark Ter Braak /00343', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (164, N'Robert Fakkert/284', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (165, N'Ernst Vreeswijk/284', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (166, N'Braam Thijs', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (167, N'Damveld Willy', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (168, N'W. Smits', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (169, N'f', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (170, N'Tonnie Feijen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (171, N'Geert Luiten', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (172, N'Hoeflake', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (173, N'dhr. Pullen 0522 291906', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (174, N'Piet Vroom', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (175, N'Jan Kalter', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (176, N'Jongsma Johannes', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (177, N'Eckhard Jungst', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (178, N'Herr Gausepohl', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (179, N'Noel SAP', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (180, N'no', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (181, N'A. van Kessel', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (182, N'Gert Anker', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (183, N'Wouda Willem', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (186, N'Harry Roerink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (187, N'Jan van Waaij', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (188, N'Cor Eldering', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (189, N'Kroes, Jan', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (190, N'Braakman, Ben', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (191, N'Jan Visser0596683005', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (192, N'Jorik Dijksterhuis', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (193, N'Robert vd Aa', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (194, N'Albert Veldhuizen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (195, N'Pierre van Oort', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (196, N'H. Mulder', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (197, N'hr Brunsveld', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (198, N'Bennie de Jong', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (199, N'Bart Frieling', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (200, N'Hazenberg, Geert', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (201, N'Maik van Loon', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (202, N'Thijs Hiddink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (203, N'Gertjan v Apeldoorn', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (204, N'Herr Kranenburg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (205, N'Bert Caris', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (206, N' m', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (207, N'René Schellekens', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (208, N'Guus de Haan', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (209, N'Erik Koldenhof', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (210, N'Frits de Jonge', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (211, N'Herr Holtmann', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (212, N'Herr Wittkamp', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (213, N'Jan Veninga 0599-580161', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (214, N'Jan Veninga0599580161', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (215, N'Chr.  Bleeker 0527618611', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (216, N'Dirk Muilenburg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (217, N'Ruud Drost', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (218, N'Rene vd Veen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (219, N'Jan Fuite jr.', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (220, N'Ben Jan Marsman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (221, N'Auke Graafstra', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (222, N'Castelein, Sipke', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (223, N'Nico Groot', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (224, N'Camiel Hoogland', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (225, N'Andries Jensma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (226, N'Frans van Egmond', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (227, N'Jarig Jan Odinga', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (228, N'Johan Keizer', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (229, N'Carl vd Wal', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (230, N'Rob vd Lindeloof', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (231, N'rob ', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (232, N'Martin vd Waal', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (233, N'D. Middelkoop', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (234, N'Gezienus Koning', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (235, N'gez', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (236, N'G. Eilers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (237, N'A. Postma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (238, N'Egbert Broersma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (239, N'Jacob Zwama', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (240, N'Klaas Ellens', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (241, N'Jan Plantinga', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (242, N'Bram Schilder', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (243, N'Jaap Visser', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (244, N'Sander Hulshof', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (245, N'Herr Fonk', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (246, N'P. Wolters', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (247, N'Kruidhof', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (248, N'Frank Meijer', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (249, N'Wolters Anna 050-5797599', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (250, N'Kalfsbeek J. 050-4029764', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (251, N'Castelein, Sipke 058-2553223', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (252, N'Kalfsbeek J. 050-4029765', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (253, N'Wolters Anna 0505797599', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (254, N'Kalfsbeek J. 0504029765', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (255, N'Castelein Sipke 0582553223', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (256, N'Kalfsbeek J 0504029765', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (257, N'Castelein S 0582553223', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (258, N'Wolters A 0505797599', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (259, N'Aart Lageweg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (260, N'Gerrit de Vries', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (261, N'Johannes Jongsma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (262, N'Rinze Kootstra', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (263, N'Roel Ruiter', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (264, N'Willem Wouda', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (265, N'Dirk Jan Nell', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (266, N'Elbert Hennipman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (267, N'Hendrik Jan Boven', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (268, N'Geert Hazenberg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (269, N'Jan Willem Elsenga', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (270, N'Jaap Kieft', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (271, N'G. Zuidersma', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (272, N'Jan Kroes', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (273, N'Tonnie Screever', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (274, N'W. Rombouts', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (275, N'Wim vd Dool', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (276, N'dhr Kuiper', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (277, N'G.Th.M Janszen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (278, N'dhr Evers', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (279, N'Mark Hilkens', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (280, N'Henny Balkt', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (281, N'Herman Borkend', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (282, N'R Bosgoed', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (283, N'dhr Kamphuis', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (284, N'Wiljo Brusse', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (285, N'Peter Struik', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (286, N'H.D.J. Morsche', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (287, N'Frank Eerland', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (288, N'Edwin van Werven', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (289, N'Sietse Stellingwerf', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (290, N'dhr Dunnink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (291, N'Bert Gardenbroek', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (292, N'Theo Mulder', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (293, N'Jasper Boer', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (294, N'dhr Roeke', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (295, N'J van den Brink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (296, N'Bert Bagerman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (297, N'Siebe Hiemstra', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (298, N'K. Koning', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (299, N'Piet Salomons', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (300, N'Jean Paul Schipper', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (301, N'Arnout ter Horst', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (302, N'dhr Hoekstra', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (303, N'dhr Stegeman 0522 291906', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (304, N'dhr. Pullen', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (305, N'dhr Stegeman 0522291906', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (306, N'Antoine van Loon', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (307, N'Robert Bos', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (308, N'Gerrie van Steeg', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (309, N'Jan Aalderink', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (310, N'Jan Veninga0591351797', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (311, N'Jjaap Kruit', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (312, N'C. Maatman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (313, N'G. van Morel', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (314, N'J Stegeman0522291906', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (315, N'dhr Hofman', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (316, N'dhr De Vries', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (317, N'Jelte Pars', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (318, N'Pieter de Vries', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (319, N'Klaas de Boer', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (320, N'Niek Vedelaar', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (321, N'Diana', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (322, N'Maarten Wolswinkel', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (323, N'Th. Runia', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (324, N'meijer rodescool', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (325, N'henk meier', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (326, N'Han Bosch', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (327, N'Cees Bos', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (328, N'Jan Buiter', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (329, N'Eric Buiter', NULL)
GO
INSERT [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson], [strContactPersonName], [strFaxNumber]) VALUES (330, N'Gert Jan de Graaf', NULL)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ContactPerson] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ExtraCost] ON 
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (1, N'Af loods', N'af loods lijst 2', CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (2, N'Af loods + 20,- €', N'franco boer lijst 3', CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (3, N'Af loods + 28,- €', N'franco boer  lijst 4', CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (4, N'Af loods + 22,5 €', N'franco boer  lijst 5', CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (5, N'Af loods -/- 5,5 €', N'lijst 6', CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (6, N'Af loods + 10,- €', N'afgehaald boer lijst 7', CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (7, N'Af loods vloeibaar', N'af loods vloeibaar lijst 8', CAST(5.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost], [strExtraCostDescription], [strExtraCostReport], [decExtraCostPrice]) VALUES (8, N'Af loods + 25,- €', N'franco boer lijst 9', CAST(37.50 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ExtraCost] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Location] ON 
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (1, N'Gent', N'Koopvaardijlaan', N'9000', N'Gent', NULL, NULL, 9000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (2, N'- 1', N'Zwolle/Goor', NULL, NULL, N'0314-374074', N'0314-374079', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (3, N'Novagran 32', N'TRIFERTO', N'4825 BP', N'BREDA', N'076-5715620', N'076-5716120', 6000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (4, N'Novagran 20', N'TRIFERTO', N'8031 EB', N'ZWOLLE', N'038-4215609', N'038-4215609', 7000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (5, N'Maatmest 15', N'TRIFERTO', N'9641HM', N'VEENDAM', N'0598-491916', N'098-492249', 6000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (6, N'Luuk', N'Hagting', NULL, NULL, N'0314-374021', N'0314-374019', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (7, N'Novagran 21', N'TRIFERTO GOOR', NULL, NULL, NULL, NULL, 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (8, N'- 2', N'Havenstraaat 68', N'7005 AG', N'Doetincehm', N'0314-374073', N'0314-374089', 9000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (9, N'- 3', NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (10, N'- 4', NULL, NULL, NULL, NULL, NULL, 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (11, N'Maatmest 22', N'TRIFERTO', N'7005 AG', N'DOETINCHEM', N'0314-375970', N'0314-360906', 9000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (12, N'- 5', N'TRIFERTO', N'7005 AG', N'DOETINCHEM', N'0314-375970', N'0314-360906', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (13, N'Ward', NULL, NULL, NULL, NULL, NULL, 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (14, N'Maatmest 21', N'TRIFERTO', N'7471 LV', N'GOOR', N'0547-283338', N'0547-273201', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (15, N'- 6', N'Terry', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (16, N'Terry', NULL, NULL, NULL, NULL, NULL, 9000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (17, N'Maatmest 20', N'TRIFERTO', N'8031 EB', N'ZWOLLE', N'038-4215609', N'038-4214913', 7000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (18, N'Maatmest 46', N'DOK', N'7418 CT', N'DEVENTER', N'0570-625022', N'0570-628910', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (19, N'Novagran 46', N'DOK', N'7418 CT', N'DEVENTER', N'0570-625022', N'0570-628910', 6000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (20, N'Novagran 65', N'CKB', N'3542 AJ', N'UTRECHT', N'030-2479910', N'030-2479909', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (21, N'Maatmest 65', N'CKB', N'3542 AJ', N'UTRECHT', N'030-2479910', N'030-2479909', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (22, N'Novagran 53', N'ROOST AGRI', N'6031 ST', N'NEDERWEERT', N'0495-631220', N'0495-625528', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (23, N'Maatmest 53', N'ROOST AGRI', N'6031 ST', N'NEDERWEERT', N'0495-631220', N'0495-625528', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (24, N'Novagran 15', N'TRIFERTO', N'9641HM', N'Veendam', NULL, NULL, 6000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (25, N'Maatmest 32', N'TRIFERTO', N'4825 BP', N'BREDA', N'076-5715620', N'076-5716120', 6000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (26, N'- 7', NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (27, N'TrifertoNovagran', NULL, NULL, NULL, NULL, NULL, 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (28, N'Novagran 12', N'TRIFERTO', N'8447 GB', N'HEERENVEEN', N'0513-628630', N'0513-615023', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (29, N'kees', NULL, NULL, NULL, NULL, NULL, 9000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (30, N'Maatmest 72', N'PARS GRAANHANDEL', N'9079 KK', N'ST. JACOBIPAR.', N'0518-491289', N'0518-491242', 6500)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (31, N'TrifertoAlgemeen', N'volledig programma', NULL, NULL, NULL, NULL, 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (33, N'- 8', NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (35, N'Maatmest 75', N'V.O.F. BUITER', N'9301 LT', N'RODEN', N'050-5019204', N'050-5019265', 7000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (36, N'- 9', NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (37, N'Maatmest 12', N'TRIFERTO', N'8447 GB', N'HEERENVEEN', N'0513-628630', N'0513-615023', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (38, N'Maatmest 74', N'ZWAMA', N'9843 HA', N'GRIJPSKERK', N'0594-212366', N'0594-212474', 7500)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (39, N'Maatmest 78', N'FOEKE VISSER', N'8621 XD', N'HEEG', N'0515-442263', N'0515-443302', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (40, N'LLS', NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (41, N'TrifertoMaatmest', NULL, N'8447 GB', N'HEERENVEEN', N'0513-683242', N'0513-684197', 5000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (42, N'Novagran 11', N'Blauwverlaat', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (44, N'Vloeibaar', N'Veendam Vloeibaar', NULL, NULL, NULL, NULL, 25000)
GO
INSERT [dbo].[tblCPais_Location] ([lngIdLocation], [strLocationDescription], [strLocationStreetNumber], [strLocationZipCode], [strLocationCity], [strLocationPhone], [strLocationFax], [lngMaximumBlendRun]) VALUES (46, N'Novagran 22', N'Depot Doetinchem', NULL, NULL, NULL, NULL, 9000)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Location] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_LocationExtraCost] ON 
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (1, 1, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (2, 2, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (3, 3, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (4, 4, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (5, 5, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (6, 6, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (7, 7, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (8, 8, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (9, 9, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (10, 10, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (11, 11, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (12, 12, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (13, 13, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (14, 14, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (15, 15, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (16, 16, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (17, 17, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (18, 18, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (19, 19, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (20, 20, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (21, 21, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (22, 22, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (23, 23, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (24, 24, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (25, 25, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (26, 26, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (27, 27, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (28, 28, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (29, 29, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (30, 30, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (31, 31, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (32, 35, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (33, 37, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (34, 38, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (35, 39, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (36, 40, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (37, 41, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (38, 42, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (39, 46, 1, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (40, 1, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (41, 2, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (42, 3, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (43, 4, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (44, 5, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (45, 6, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (46, 7, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (47, 8, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (48, 9, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (49, 10, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (50, 11, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (51, 12, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (52, 14, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (53, 15, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (54, 16, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (55, 17, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (56, 18, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (57, 19, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (58, 20, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (59, 21, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (60, 22, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (61, 23, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (62, 24, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (63, 25, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (64, 27, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (65, 28, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (66, 30, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (67, 31, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (68, 35, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (69, 37, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (70, 38, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (71, 39, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (72, 41, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (73, 42, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (74, 46, 2, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (75, 1, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (76, 2, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (77, 3, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (78, 4, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (79, 5, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (80, 6, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (81, 7, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (82, 8, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (83, 9, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (84, 10, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (85, 11, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (86, 12, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (87, 14, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (88, 15, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (89, 16, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (90, 17, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (91, 24, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (92, 25, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (93, 27, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (94, 31, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (95, 46, 3, CAST(40.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (96, 1, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (97, 2, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (98, 4, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (99, 6, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (100, 7, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (101, 8, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (102, 9, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (103, 10, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (104, 11, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (105, 12, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (106, 14, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (107, 15, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (108, 16, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (109, 17, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (110, 18, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (111, 19, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (112, 20, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (113, 21, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (114, 24, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (115, 26, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (116, 27, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (117, 28, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (118, 31, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (119, 37, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (120, 39, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (121, 41, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (122, 46, 4, CAST(35.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (123, 11, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (124, 12, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (125, 13, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (126, 27, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (127, 29, 5, CAST(32.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (128, 31, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (129, 46, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (130, 4, 6, CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (131, 12, 6, CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (132, 13, 6, CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (133, 19, 6, CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (134, 27, 6, CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (135, 46, 6, CAST(22.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (136, 31, 7, CAST(5.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (137, 44, 7, CAST(5.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (138, 4, 8, CAST(37.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (139, 7, 8, CAST(37.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (140, 17, 8, CAST(37.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (141, 24, 8, CAST(37.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (142, 27, 8, CAST(37.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (143, 31, 8, CAST(37.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationExtraCost] ([lngIdLocationExtraCost], [lngLocationId], [lngExtraCostId], [decLocationExtraCostPrice]) VALUES (144, 46, 8, CAST(37.50 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_LocationExtraCost] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_LocationPackaging] ON 
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (1, 1, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (2, 2, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (3, 3, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (4, 4, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (5, 6, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (6, 7, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (7, 8, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (8, 9, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (9, 10, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (10, 11, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (11, 12, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (12, 13, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (13, 14, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (14, 15, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (15, 16, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (16, 17, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (17, 18, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (18, 19, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (19, 20, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (20, 21, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (21, 25, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (22, 27, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (23, 31, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (24, 40, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (25, 46, 1, CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (26, 1, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (27, 2, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (28, 6, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (29, 7, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (30, 8, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (31, 9, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (32, 10, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (33, 11, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (34, 12, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (35, 13, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (36, 14, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (37, 15, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (38, 16, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (39, 18, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (40, 19, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (41, 31, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (42, 40, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (43, 46, 2, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (44, 1, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (45, 2, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (46, 3, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (47, 4, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (48, 5, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (49, 6, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (50, 7, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (51, 8, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (52, 9, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (53, 10, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (54, 11, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (55, 12, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (56, 13, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (57, 14, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (58, 15, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (59, 16, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (60, 17, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (61, 18, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (62, 19, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (63, 20, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (64, 21, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (65, 22, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (66, 24, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (67, 25, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (68, 26, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (69, 27, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (70, 28, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (71, 29, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (72, 31, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (73, 35, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (74, 37, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (75, 39, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (76, 40, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (77, 41, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (78, 46, 3, CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (79, 1, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (80, 2, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (81, 3, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (82, 6, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (83, 7, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (84, 8, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (85, 9, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (86, 10, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (87, 11, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (88, 12, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (89, 13, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (90, 14, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (91, 15, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (92, 16, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (93, 18, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (94, 19, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (95, 20, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (96, 21, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (97, 31, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (98, 40, 4, CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (99, 1, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (100, 30, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (101, 31, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (102, 35, 5, CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (103, 31, 6, CAST(10.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_LocationPackaging] ([lngIdLocationPackaging], [lngLocationId], [lngPackagingId], [decLocationPackagingPrice]) VALUES (104, 44, 6, CAST(10.00 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_LocationPackaging] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_LocationProduct] ON 
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1, 1, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (2, 2, 1, CAST(14.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (3, 3, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (4, 4, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (5, 5, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (6, 6, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (7, 7, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (8, 8, 1, CAST(1512.40 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (9, 9, 1, CAST(14.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (10, 10, 1, CAST(14.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (11, 11, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (12, 12, 1, CAST(186.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (13, 13, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (14, 14, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (15, 16, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (16, 17, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (17, 19, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (18, 22, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (19, 23, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (20, 24, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (21, 25, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (22, 26, 1, CAST(148.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (23, 27, 1, CAST(383.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (24, 28, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (25, 29, 1, CAST(178.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (26, 31, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (27, 35, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (28, 37, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (29, 38, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (30, 40, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (31, 41, 1, CAST(383.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (32, 42, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (33, 46, 1, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (34, 1, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (36, 3, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (37, 4, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (38, 5, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (39, 6, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (40, 7, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (41, 8, 2, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (42, 11, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (43, 12, 2, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (44, 13, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (45, 14, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (46, 16, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (47, 17, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (48, 18, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (49, 19, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (50, 20, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (51, 21, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (52, 22, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (53, 23, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (54, 24, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (55, 25, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (56, 26, 2, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (57, 27, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (58, 28, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (59, 29, 2, CAST(260.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (60, 30, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (61, 31, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (62, 35, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (63, 37, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (64, 38, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (65, 39, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (66, 40, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (67, 41, 2, CAST(800.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (68, 42, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (69, 46, 2, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (70, 1, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (71, 2, 3, CAST(13.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (72, 4, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (73, 6, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (74, 8, 3, CAST(12.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (75, 13, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (76, 16, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (77, 19, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (78, 22, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (79, 24, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (80, 27, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (81, 31, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (82, 39, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (83, 41, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (84, 42, 3, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (85, 1, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (86, 2, 4, CAST(19.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (87, 3, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (88, 4, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (89, 5, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (90, 6, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (91, 7, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (92, 8, 4, CAST(1516.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (93, 11, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (94, 12, 4, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (95, 14, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (96, 16, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (97, 17, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (98, 18, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (99, 19, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (100, 20, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (101, 21, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (102, 22, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (103, 23, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (104, 24, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (105, 25, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (106, 27, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (107, 28, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (108, 29, 4, CAST(200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (109, 30, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (110, 31, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (111, 35, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (112, 37, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (113, 38, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (114, 39, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (115, 40, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (116, 41, 4, CAST(715.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (117, 46, 4, CAST(725.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (118, 1, 5, CAST(870.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (119, 2, 5, CAST(22.70 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (120, 16, 5, CAST(870.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (121, 31, 5, CAST(870.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (122, 1, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (123, 2, 6, CAST(19.25 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (124, 6, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (125, 16, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (126, 18, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (127, 19, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (128, 20, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (129, 21, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (130, 25, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (131, 27, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (132, 28, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (133, 30, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (134, 31, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (135, 37, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (136, 39, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (137, 41, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (138, 42, 6, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (139, 1, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (140, 2, 7, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (141, 3, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (142, 4, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (143, 5, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (144, 6, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (145, 7, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (146, 8, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (147, 9, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (148, 10, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (149, 11, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (150, 12, 7, CAST(176.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (151, 13, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (152, 14, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (153, 15, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (154, 16, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (155, 17, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (156, 18, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (157, 19, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (158, 20, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (159, 21, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (160, 22, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (161, 23, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (162, 24, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (163, 25, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (164, 26, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (165, 27, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (166, 28, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (167, 29, 7, CAST(170.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (168, 31, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (169, 33, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (170, 35, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (171, 36, 7, CAST(149.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (172, 37, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (173, 38, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (174, 39, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (175, 41, 7, CAST(375.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (176, 42, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (177, 46, 7, CAST(372.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (178, 1, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (179, 2, 8, CAST(16.60 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (180, 5, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (181, 8, 8, CAST(1515.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (182, 11, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (183, 13, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (184, 14, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (185, 16, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (186, 17, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (187, 18, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (188, 21, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (189, 23, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (190, 25, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (191, 29, 8, CAST(195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (192, 30, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (193, 31, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (194, 35, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (195, 37, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (196, 38, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (197, 39, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (198, 40, 8, CAST(615.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (199, 41, 8, CAST(620.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (200, 1, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (201, 2, 9, CAST(17.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (202, 8, 9, CAST(16.25 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (203, 9, 9, CAST(17.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (204, 10, 9, CAST(17.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (205, 11, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (206, 13, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (207, 14, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (208, 16, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (209, 17, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (210, 18, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (211, 21, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (212, 23, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (213, 25, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (214, 29, 9, CAST(183.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (215, 30, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (216, 31, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (217, 35, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (218, 39, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (219, 40, 9, CAST(525.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (220, 41, 9, CAST(530.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (221, 1, 10, CAST(550.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (222, 2, 10, CAST(19.05 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (223, 16, 10, CAST(550.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (224, 31, 10, CAST(550.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (225, 1, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (226, 2, 11, CAST(15.25 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (227, 3, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (228, 4, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (229, 5, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (230, 6, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (231, 7, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (232, 8, 11, CAST(14.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (233, 11, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (234, 12, 11, CAST(163.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (235, 13, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (236, 14, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (237, 16, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (238, 17, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (239, 18, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (240, 19, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (241, 20, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (242, 21, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (243, 22, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (244, 23, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (245, 24, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (246, 25, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (247, 27, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (248, 28, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (249, 29, 11, CAST(164.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (250, 30, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (251, 31, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (252, 35, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (253, 37, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (254, 39, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (255, 40, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (256, 41, 11, CAST(250.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (257, 46, 11, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (258, 1, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (259, 2, 12, CAST(7.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (260, 5, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (261, 8, 12, CAST(1561.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (262, 11, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (263, 16, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (264, 17, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (265, 24, 12, CAST(150150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (266, 29, 12, CAST(76.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (267, 31, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (268, 37, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (269, 39, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (270, 41, 12, CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (271, 1, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (272, 2, 13, CAST(21.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (273, 5, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (274, 6, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (275, 7, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (276, 8, 13, CAST(23.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (277, 11, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (278, 13, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (279, 16, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (280, 17, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (281, 18, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (282, 19, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (283, 21, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (284, 29, 13, CAST(250.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (285, 30, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (286, 31, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (287, 35, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (288, 38, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (289, 39, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (290, 41, 13, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (291, 1, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (292, 2, 14, CAST(16.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (293, 3, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (294, 4, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (295, 5, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (296, 6, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (297, 7, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (298, 8, 14, CAST(13.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (299, 11, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (300, 12, 14, CAST(201.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (301, 13, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (302, 14, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (303, 16, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (304, 17, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (305, 18, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (306, 19, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (307, 20, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (308, 21, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (309, 22, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (310, 23, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (311, 24, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (312, 25, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (313, 26, 14, CAST(163.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (314, 27, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (315, 28, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (316, 29, 14, CAST(185.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (317, 30, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (318, 31, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (319, 35, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (320, 37, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (321, 39, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (322, 41, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (323, 42, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (324, 46, 14, CAST(440.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (325, 1, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (326, 2, 15, CAST(11.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (327, 4, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (328, 5, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (329, 6, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (330, 7, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (331, 8, 15, CAST(11.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (332, 12, 15, CAST(130.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (333, 14, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (334, 16, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (335, 17, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (336, 18, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (337, 19, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (338, 25, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (339, 27, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (340, 28, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (341, 31, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (342, 37, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (343, 41, 15, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (344, 1, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (345, 2, 16, CAST(73.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (346, 4, 16, CAST(22002200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (347, 5, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (348, 6, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (349, 11, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (350, 12, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (351, 13, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (352, 16, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (353, 18, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (354, 24, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (355, 29, 16, CAST(1200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (356, 31, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (357, 44, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (358, 46, 16, CAST(2200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (359, 1, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (360, 2, 17, CAST(24.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (361, 3, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (362, 4, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (363, 5, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (364, 6, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (365, 7, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (366, 12, 17, CAST(255.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (367, 14, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (368, 16, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (369, 17, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (370, 24, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (371, 25, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (372, 27, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (373, 30, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (374, 31, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (375, 35, 17, CAST(325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (376, 46, 17, CAST(325325.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (377, 1, 18, CAST(240.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (378, 2, 18, CAST(39.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (379, 3, 18, CAST(217217.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (380, 16, 18, CAST(240.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (381, 31, 18, CAST(240.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (382, 1, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (383, 2, 19, CAST(22.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (384, 4, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (385, 6, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (386, 16, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (387, 24, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (388, 28, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (389, 31, 19, CAST(430430.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (390, 1, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (391, 2, 20, CAST(23.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (392, 3, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (393, 4, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (394, 5, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (395, 6, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (396, 16, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (397, 19, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (398, 22, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (399, 25, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (400, 31, 20, CAST(650.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (401, 1, 21, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (402, 2, 21, CAST(21.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (403, 16, 21, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (404, 1, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (405, 2, 22, CAST(7.45 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (406, 4, 22, CAST(7750775077.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (407, 5, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (408, 8, 22, CAST(8.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (409, 11, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (410, 14, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (411, 17, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (412, 18, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (413, 23, 22, CAST(77577.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (414, 25, 22, CAST(7777.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (415, 29, 22, CAST(75.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (416, 31, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (417, 35, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (418, 37, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (419, 39, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (420, 41, 22, CAST(77.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (421, 1, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (422, 2, 23, CAST(29.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (423, 11, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (424, 14, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (425, 17, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (426, 21, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (427, 25, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (428, 31, 23, CAST(460.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (429, 1, 24, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (430, 2, 24, CAST(35.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (431, 16, 24, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (432, 17, 24, CAST(450450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (433, 21, 24, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (434, 25, 24, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (435, 1, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (436, 2, 25, CAST(13.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (437, 11, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (438, 14, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (439, 16, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (440, 17, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (441, 25, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (442, 27, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (443, 30, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (444, 31, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (445, 35, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (446, 40, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (447, 41, 25, CAST(370.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (448, 1, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (449, 2, 26, CAST(17.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (450, 3, 26, CAST(190190.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (451, 4, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (452, 5, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (453, 6, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (454, 8, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (455, 9, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (456, 10, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (457, 11, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (458, 12, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (459, 13, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (460, 14, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (461, 15, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (462, 16, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (463, 17, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (464, 18, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (465, 19, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (466, 20, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (467, 21, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (468, 22, 26, CAST(195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (469, 23, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (470, 24, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (471, 25, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (472, 26, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (473, 27, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (474, 28, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (475, 29, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (476, 30, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (477, 31, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (478, 33, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (479, 35, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (480, 36, 26, CAST(155.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (481, 37, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (482, 38, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (483, 39, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (484, 40, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (485, 41, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (486, 42, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (487, 44, 26, CAST(195195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (488, 1, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (489, 2, 27, CAST(17.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (490, 6, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (491, 12, 27, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (492, 16, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (493, 19, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (494, 20, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (495, 21, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (496, 27, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (497, 31, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (498, 42, 27, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (499, 1, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (500, 2, 28, CAST(21.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (501, 3, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (502, 4, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (503, 5, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (504, 6, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (505, 7, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (506, 8, 28, CAST(21.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (507, 9, 28, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (508, 10, 28, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (509, 11, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (510, 12, 28, CAST(235.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (511, 13, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (512, 14, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (513, 15, 28, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (514, 16, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (515, 17, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (516, 18, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (517, 19, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (518, 20, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (519, 22, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (520, 23, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (521, 24, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (522, 25, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (523, 26, 28, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (524, 27, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (525, 28, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (526, 30, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (527, 31, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (528, 33, 28, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (529, 35, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (530, 36, 28, CAST(205.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (531, 37, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (532, 38, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (533, 39, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (534, 41, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (535, 46, 28, CAST(555.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (536, 1, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (537, 2, 29, CAST(12.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (538, 11, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (539, 14, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (540, 16, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (541, 17, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (542, 18, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (543, 31, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (544, 35, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (545, 37, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (546, 38, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (547, 41, 29, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (548, 1, 30, CAST(420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (549, 2, 30, CAST(23.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (550, 6, 30, CAST(420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (551, 16, 30, CAST(420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (552, 17, 30, CAST(420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (553, 31, 30, CAST(420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (554, 1, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (555, 2, 31, CAST(22.40 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (556, 3, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (557, 5, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (558, 6, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (559, 7, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (560, 8, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (561, 9, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (562, 10, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (563, 11, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (564, 13, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (565, 14, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (566, 15, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (567, 16, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (568, 18, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (569, 23, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (570, 25, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (571, 26, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (572, 27, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (573, 31, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (574, 33, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (575, 35, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (576, 36, 31, CAST(245.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (577, 37, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (578, 38, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (579, 39, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (580, 41, 31, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (581, 1, 32, CAST(805.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (582, 2, 32, CAST(24.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (583, 6, 32, CAST(805.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (584, 16, 32, CAST(805.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (585, 27, 32, CAST(805.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (586, 31, 32, CAST(805.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (587, 1, 33, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (588, 2, 33, CAST(13.25 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (589, 16, 33, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (590, 31, 33, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (591, 1, 34, CAST(655.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (592, 2, 34, CAST(21.10 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (593, 16, 34, CAST(655.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (594, 31, 34, CAST(655.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (595, 1, 35, CAST(660.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (596, 2, 35, CAST(19.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (597, 16, 35, CAST(660.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (598, 31, 35, CAST(660.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (599, 1, 36, CAST(436.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (600, 2, 36, CAST(40.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (601, 4, 36, CAST(436.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (602, 16, 36, CAST(436.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (603, 1, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (604, 2, 37, CAST(16.65 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (605, 6, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (606, 8, 37, CAST(15.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (607, 12, 37, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (608, 13, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (609, 14, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (610, 16, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (611, 19, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (612, 20, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (613, 21, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (614, 22, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (615, 24, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (616, 27, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (617, 28, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (618, 29, 37, CAST(195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (619, 31, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (620, 35, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (621, 40, 37, CAST(590.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (622, 1, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (623, 2, 38, CAST(19.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (624, 3, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (625, 8, 38, CAST(1516.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (626, 12, 38, CAST(212.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (627, 16, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (628, 19, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (629, 28, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (630, 31, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (631, 37, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (632, 42, 38, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (633, 1, 39, CAST(375.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (634, 2, 39, CAST(11.20 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (635, 6, 39, CAST(375.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (636, 8, 39, CAST(100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (637, 12, 39, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (638, 13, 39, CAST(375.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (639, 16, 39, CAST(375.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (640, 26, 39, CAST(112.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (641, 31, 39, CAST(375.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (642, 1, 40, CAST(540.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (643, 2, 40, CAST(30.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (644, 16, 40, CAST(540.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (645, 1, 41, CAST(1350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (646, 2, 41, CAST(90.20 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (647, 11, 41, CAST(13501350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (648, 14, 41, CAST(13501350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (649, 16, 41, CAST(1350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (650, 17, 41, CAST(1350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (651, 31, 41, CAST(1350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (652, 41, 41, CAST(1350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (653, 1, 42, CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (654, 2, 42, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (655, 6, 42, CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (656, 16, 42, CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (657, 18, 42, CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (658, 19, 42, CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (659, 31, 42, CAST(6000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (660, 1, 44, CAST(195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (661, 2, 44, CAST(19.29 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (662, 16, 44, CAST(195.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (663, 31, 44, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (664, 1, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (665, 2, 45, CAST(10.95 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (666, 5, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (667, 6, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (668, 8, 45, CAST(1510.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (669, 11, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (670, 12, 45, CAST(130.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (671, 13, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (672, 16, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (673, 24, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (674, 25, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (675, 27, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (676, 29, 45, CAST(117.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (677, 31, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (678, 37, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (679, 46, 45, CAST(360.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (680, 1, 46, CAST(660.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (681, 2, 46, CAST(16.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (682, 16, 46, CAST(660.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (683, 31, 46, CAST(660.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (684, 1, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (685, 2, 47, CAST(12.20 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (686, 4, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (687, 7, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (688, 16, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (689, 17, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (690, 19, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (691, 24, 47, CAST(9999410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (692, 31, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (693, 37, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (694, 42, 47, CAST(410.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (695, 1, 48, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (696, 2, 48, CAST(16.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (697, 16, 48, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (698, 24, 48, CAST(400400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (699, 31, 48, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (700, 1, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (701, 2, 49, CAST(13.60 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (702, 5, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (703, 6, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (704, 11, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (705, 16, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (706, 18, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (707, 24, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (708, 31, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (709, 38, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (710, 46, 49, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (711, 1, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (712, 2, 50, CAST(51.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (713, 6, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (714, 11, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (715, 16, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (716, 22, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (717, 23, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (718, 29, 50, CAST(475.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (719, 31, 50, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (720, 1, 51, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (721, 2, 51, CAST(57.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (722, 6, 51, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (723, 16, 51, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (724, 29, 51, CAST(545.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (725, 31, 51, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (726, 37, 51, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (727, 39, 51, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (728, 1, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (729, 2, 52, CAST(19.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (730, 3, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (731, 4, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (732, 5, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (733, 6, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (734, 7, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (735, 11, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (736, 12, 52, CAST(215.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (737, 13, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (738, 14, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (739, 16, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (740, 17, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (741, 18, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (742, 19, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (743, 20, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (744, 22, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (745, 23, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (746, 24, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (747, 25, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (748, 27, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (749, 28, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (750, 29, 52, CAST(190.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (751, 31, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (752, 35, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (753, 37, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (754, 41, 52, CAST(285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (755, 46, 52, CAST(265.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (756, 1, 53, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (757, 2, 53, CAST(60.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (758, 31, 53, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (759, 39, 53, CAST(840.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (760, 1, 54, CAST(420420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (761, 2, 54, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (762, 3, 54, CAST(420420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (763, 8, 54, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (764, 9, 54, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (765, 10, 54, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (766, 16, 54, CAST(420420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (767, 31, 54, CAST(420420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (768, 46, 54, CAST(420420.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (769, 4, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (770, 6, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (771, 8, 55, CAST(13.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (772, 12, 55, CAST(186.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (773, 13, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (774, 16, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (775, 17, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (776, 18, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (777, 19, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (778, 20, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (779, 21, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (780, 24, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (781, 27, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (782, 28, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (783, 29, 55, CAST(178.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (784, 30, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (785, 31, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (786, 39, 55, CAST(380.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (787, 3, 56, CAST(1750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (788, 8, 56, CAST(100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (789, 16, 56, CAST(1750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (790, 18, 56, CAST(1750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (791, 19, 56, CAST(1750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (792, 31, 56, CAST(1750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (793, 3, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (794, 4, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (795, 5, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (796, 6, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (797, 8, 58, CAST(23.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (798, 11, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (799, 12, 58, CAST(350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (800, 16, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (801, 17, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (802, 19, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (803, 24, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (804, 25, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (805, 27, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (806, 29, 58, CAST(330.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (807, 31, 58, CAST(920.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (808, 3, 59, CAST(825.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (809, 6, 59, CAST(825.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (810, 8, 59, CAST(80.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (811, 14, 59, CAST(825.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (812, 16, 59, CAST(825.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (813, 29, 59, CAST(545.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (814, 31, 59, CAST(825.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (815, 3, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (816, 4, 60, CAST(560560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (817, 7, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (818, 11, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (819, 16, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (820, 24, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (821, 27, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (822, 29, 60, CAST(20180.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (823, 31, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (824, 46, 60, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (825, 1, 61, CAST(622.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (826, 2, 61, CAST(20.85 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (827, 3, 61, CAST(622.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (828, 6, 61, CAST(622.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (829, 8, 61, CAST(20.85 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (830, 9, 61, CAST(20.85 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (831, 10, 61, CAST(20.85 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (832, 16, 61, CAST(622.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (833, 31, 61, CAST(622.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (834, 3, 62, CAST(119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (835, 7, 62, CAST(1195119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (836, 16, 62, CAST(119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (837, 17, 62, CAST(119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (838, 18, 62, CAST(119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (839, 19, 62, CAST(1195119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (840, 24, 62, CAST(1195119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (841, 27, 62, CAST(119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (842, 31, 62, CAST(119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (843, 46, 62, CAST(999119.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (844, 16, 63, CAST(17000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (845, 18, 63, CAST(17000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (846, 19, 63, CAST(17000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (847, 31, 63, CAST(17000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (848, 4, 64, CAST(1100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (849, 5, 64, CAST(1100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (850, 8, 64, CAST(90.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (851, 13, 64, CAST(1100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (852, 14, 64, CAST(1100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (853, 16, 64, CAST(1100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (854, 29, 64, CAST(700.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (855, 31, 64, CAST(1100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (856, 16, 66, CAST(900.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (857, 31, 66, CAST(900.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (858, 31, 70, CAST(485.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (859, 31, 71, CAST(510.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (860, 31, 72, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (861, 25, 73, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (862, 1, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (863, 2, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (864, 3, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (865, 4, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (866, 5, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (867, 6, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (868, 7, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (869, 8, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (870, 9, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (871, 10, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (872, 11, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (873, 12, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (874, 13, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (875, 14, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (876, 15, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (877, 17, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (878, 18, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (879, 19, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (880, 20, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (881, 21, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (882, 22, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (883, 23, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (884, 24, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (885, 25, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (886, 26, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (887, 28, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (888, 29, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (889, 31, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (890, 33, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (891, 35, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (892, 36, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (893, 37, 74, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (894, 5, 75, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (895, 31, 75, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (896, 35, 75, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (897, 4, 77, CAST(23002300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (898, 5, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (899, 11, 77, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (900, 12, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (901, 18, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (902, 24, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (903, 29, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (904, 31, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (905, 46, 77, CAST(2300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (906, 3, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (907, 4, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (908, 5, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (909, 7, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (910, 11, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (911, 12, 78, CAST(120.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (912, 13, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (913, 17, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (914, 18, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (915, 20, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (916, 21, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (917, 22, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (918, 23, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (919, 24, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (920, 27, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (921, 28, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (922, 29, 78, CAST(130.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (923, 30, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (924, 31, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (925, 35, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (926, 37, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (927, 38, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (928, 39, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (929, 42, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (930, 46, 78, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (931, 3, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (932, 4, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (933, 5, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (934, 7, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (935, 11, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (936, 12, 79, CAST(850.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (937, 13, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (938, 14, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (939, 17, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (940, 24, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (941, 25, 79, CAST(950950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (942, 27, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (943, 28, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (944, 31, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (945, 35, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (946, 37, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (947, 42, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (948, 46, 79, CAST(950.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (949, 3, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (950, 4, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (951, 5, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (952, 7, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (953, 11, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (954, 12, 80, CAST(900.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (955, 13, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (956, 14, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (957, 17, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (958, 22, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (959, 23, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (960, 24, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (961, 25, 80, CAST(10501050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (962, 27, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (963, 28, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (964, 31, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (965, 35, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (966, 42, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (967, 46, 80, CAST(1050.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (968, 44, 82, CAST(320.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (969, 24, 83, CAST(9999985.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (970, 44, 83, CAST(85.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (971, 44, 85, CAST(885.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (972, 14, 86, CAST(285285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (973, 25, 86, CAST(285285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (974, 44, 86, CAST(285285.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (975, 3, 88, CAST(775.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (976, 6, 88, CAST(775.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (977, 24, 88, CAST(775.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (978, 27, 88, CAST(775.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (979, 31, 88, CAST(775.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (980, 46, 88, CAST(775.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (981, 3, 89, CAST(825.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (982, 4, 89, CAST(540540.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (983, 24, 89, CAST(540.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (984, 31, 89, CAST(540.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (985, 46, 89, CAST(540.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (986, 4, 90, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (987, 5, 90, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (988, 31, 90, CAST(450.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (989, 6, 91, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (990, 31, 91, CAST(350350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (991, 5, 92, CAST(250.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (992, 31, 92, CAST(250.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (993, 3, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (994, 4, 93, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (995, 7, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (996, 12, 93, CAST(197.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (997, 19, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (998, 24, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (999, 27, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1000, 28, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1001, 31, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1002, 46, 93, CAST(560.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1003, 3, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1004, 4, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1005, 7, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1006, 12, 94, CAST(120.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1007, 17, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1008, 19, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1009, 23, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1010, 24, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1011, 25, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1012, 27, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1013, 28, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1014, 31, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1015, 42, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1016, 46, 94, CAST(210.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1017, 4, 97, CAST(445445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1018, 12, 97, CAST(165.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1019, 24, 97, CAST(445.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1020, 46, 98, CAST(565.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1021, 4, 99, CAST(390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1022, 7, 99, CAST(390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1023, 14, 99, CAST(390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1024, 17, 99, CAST(390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1025, 28, 99, CAST(390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1026, 31, 99, CAST(390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1027, 31, 101, CAST(240.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1028, 3, 102, CAST(900.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1029, 4, 102, CAST(800.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1030, 4, 103, CAST(32003200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1031, 17, 103, CAST(3200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1032, 4, 104, CAST(600600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1033, 11, 104, CAST(585.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1034, 46, 104, CAST(600.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1035, 46, 105, CAST(570.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1079, 37, 63, CAST(1.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1080, 37, 41, CAST(1350.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[tblCPais_LocationProduct] ([lngIdLocationProduct], [lngLocationId], [lngProductId], [decLocationProductPrice]) VALUES (1082, 2, 2, CAST(800.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_LocationProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Nutrient] ON 
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (1, N'Stikstof Totaal (N-tot)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (2, N'Fosfaat P2O5', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (3, N'Kalium Ch (K2O)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (4, N'Kalium Ca (K2O)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (5, N'Nitraat stikstof N-NO3', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (6, N'Ammonium stikstof N-NH4', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (7, N'Organische stof', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (8, N'P2O5 wateroplosbaar', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (9, N'methyleen-ureum', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (10, N'Magnesium (MgO) wateroplosbaar', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (11, N'Magnesium (MgO) totaal', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (12, N'Koper (Cu)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (13, N'Kobalt (Co)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (14, N'Chloor (Cl-)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (15, N'Zwavel (SO3)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (16, N'Calcium oplosbaar in mineraal zuur (CaO)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (17, N'IJzer (Fe)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (18, N'Mangaan (Mn)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (19, N'Boor (B)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (20, N'Zink (Zn)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (21, N'Molybdeen (Mo)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (22, N'Natrium (Na2O) oplosbaar in water', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (24, N'Zbw Bouwland', 0)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (25, N'Zbw Grasland', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (26, N'Organische stikstof (N-Org)', 0)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (27, N'Fosfor', 0)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (28, N'Kalium', 0)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (29, N'Se in ppm', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (31, N'Ureum stikstof (N-ureum)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (32, N'nitrificatieremmer', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (33, N'gedw P2O5 uit Super 18', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (34, N'gedw P2O5 uit Super 20', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (35, N'gedw N uit Entec 25-15', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (36, N'gedw K2O uit Patentkali', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (37, N'gedw MgO uit Kieseriet', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (38, N'KCL', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (39, N'gedw N uit Entec 26', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (40, N'gedw Se (ppm) uit Korrel Se', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (41, N'gedw koper korrel Goor', 0)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (42, N'gedw P2O5 uit NP 26-14', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (43, N'gedw P2O5 uit TSP', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (44, N'gedw Na2O uit Korrelzout', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (45, N'gedw Na2O uit Bemestingszout naturel', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (46, N'gedw MgO uit Stikstofmagnesia', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (47, N'gedw K2O uit Kaliumsulfaat', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (48, N'gedw K2O uit Granu-potash 47', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (49, N'gedw N uit DAP', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (50, N'procent uit DAP', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (51, N'gedw blendolie (%)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (52, N'gedw blendklei (%)', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (53, N'gedw K2O uit Korn Kali', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (55, N'gedw P2O5 uit DAP', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (56, N'gedw N uit ZZA', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (57, N'gedw N uit ASS', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (58, N'gedw SO3 uit ASS', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (59, N'gedw SO3 uit ZZA', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (60, N'gedw. B uit solubor', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (61, N'gedw K2O uit Kali 60', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (62, N'gedw Na2O uit Nakamag', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (64, N'gedw P2O5 uit NP 26-7', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (65, N'Gedw. N uit NP 17-17', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (66, N'gedw. B uit Rosabor', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (67, N'gedw N uit Entec Perfect', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (68, N'humifirst', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (69, N'gedw MgO uit dologran', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (70, N'gedw N uit Transitiebouwsteen', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (73, N'gedw P2O5 uit NP 23-23-0', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (74, N'gedw P2O5  uit NP 26-7+10 SO3', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (75, N'gedw. Borium uit NP 11-5', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (76, N'gedw N uit NP 9-13', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (77, N'gedw. N uit Dynamon S', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (78, N'gedw. SO3 uit Dynamon S', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (79, N'gedw P2O5 uit PK 15-30', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (83, N'gedw Se uit Ankerpoort-Se', 1)
GO
INSERT [dbo].[tblCPais_Nutrient] ([lngIdNutrient], [strNutrientDescription], [blnNutrientExerciseValue]) VALUES (87, N'dap niet nodig', 1)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Nutrient] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Packaging] ON 
GO
INSERT [dbo].[tblCPais_Packaging] ([lngIdPackaging], [strPackagingDescription], [decPackagingPrice]) VALUES (1, N'Toeslag 25 kg''s', CAST(25.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Packaging] ([lngIdPackaging], [strPackagingDescription], [decPackagingPrice]) VALUES (2, N'Toeslag 50 kg''s', CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Packaging] ([lngIdPackaging], [strPackagingDescription], [decPackagingPrice]) VALUES (3, N'Toeslag  Big Bag Kl.', CAST(15.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Packaging] ([lngIdPackaging], [strPackagingDescription], [decPackagingPrice]) VALUES (4, N'Toeslag  Big Bag Gr.', CAST(12.50 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Packaging] ([lngIdPackaging], [strPackagingDescription], [decPackagingPrice]) VALUES (5, N'Toeslag  statiegeld BB', CAST(7.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Packaging] ([lngIdPackaging], [strPackagingDescription], [decPackagingPrice]) VALUES (6, N'Toeslag vullen IBC Cans', CAST(10.00 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Packaging] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Product] ON 
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (0, N'Dummy', CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (1, N'Nutramon', CAST(383.00 AS Decimal(9, 2)), CAST(1040.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (2, N'DAP', CAST(800.00 AS Decimal(9, 2)), CAST(980.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (3, N'Magnesammon', CAST(700.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (4, N'Tripelsuper (Tsk)', CAST(715.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (5, N'Map 12-52', CAST(870.00 AS Decimal(9, 2)), CAST(950.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (6, N'Np 26-14', CAST(585.00 AS Decimal(9, 2)), CAST(1025.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (7, N'Stikstofmagnesia (MAS) 21+8', CAST(375.00 AS Decimal(9, 2)), CAST(1125.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (8, N'Kali 60 (KCL)', CAST(620.00 AS Decimal(9, 2)), CAST(1040.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (9, N'Patentkali', CAST(530.00 AS Decimal(9, 2)), CAST(1400.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (10, N'Npk 21+8+11', CAST(550.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (11, N'Kieseriet (korrel)', CAST(250.00 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (12, N'Nakamag', CAST(150.00 AS Decimal(9, 2)), CAST(1150.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (13, N'Kaliumsulfaat', CAST(850.00 AS Decimal(9, 2)), CAST(1250.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (14, N'Ass', CAST(440.00 AS Decimal(9, 2)), CAST(950.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (15, N'Super 20', CAST(360.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (16, N'Borium vlb 150gr/l', CAST(2200.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (17, N'Np 11.5+5.5+2.2 B', CAST(325.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (18, N'Sulfamag 35', CAST(240.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (19, N'NPK 5-7-30 CA', CAST(430430.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (20, N'Npk 12+10+18s', CAST(650.00 AS Decimal(9, 2)), CAST(1010.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (21, N'Npk 13+8+26', CAST(585.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (22, N'Bemestingszout', CAST(77.50 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (23, N'Bem.zout koper 3,5 %', CAST(460.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (24, N'Cobaltzout 0.3 %', CAST(450.00 AS Decimal(9, 2)), CAST(1150.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (25, N'ZZA', CAST(370.00 AS Decimal(9, 2)), CAST(1010.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (26, N'Korrelzout 33', CAST(195195.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (27, N'NP 26-7', CAST(410.00 AS Decimal(9, 2)), CAST(1025.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (28, N'Entec 26%', CAST(555.00 AS Decimal(9, 2)), CAST(980.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (29, N'Korn Kali', CAST(445.00 AS Decimal(9, 2)), CAST(1080.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (30, N'Kalksalpeter Tropicote', CAST(420.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (31, N'Chilisalpeter', CAST(350350.00 AS Decimal(9, 2)), CAST(925.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (32, N'NPK 7-14-28 CA', CAST(805.00 AS Decimal(9, 2)), CAST(1020.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (33, N'Pk 0+16+16', CAST(500.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (34, N'Ureum landbouw', CAST(350.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (35, N'Npk 17+17+17', CAST(660.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (36, N'Transitiebouwsteen', CAST(436.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (37, N'Pk 0+8+45', CAST(590.00 AS Decimal(9, 2)), CAST(1030.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (38, N'Npk 15+15+15', CAST(600.00 AS Decimal(9, 2)), CAST(1050.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (39, N'Thomaskali', CAST(375.00 AS Decimal(9, 2)), CAST(1131.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (40, N'Npk 8+15+15', CAST(540.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (41, N'Cobaltzout 1%', CAST(1350.00 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (42, N'koperoxychloride 57', CAST(6000.00 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (44, N'MgO-korrel', CAST(400.00 AS Decimal(9, 2)), CAST(1300.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (45, N'Super 18', CAST(360.00 AS Decimal(9, 2)), CAST(1170.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (46, N'PK 0-25-25', CAST(660.00 AS Decimal(9, 2)), CAST(1050.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (47, N'NP 26-7+10 SO3', CAST(410.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (48, N'Joling 7640', CAST(400.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (49, N'Kas WIT', CAST(383.00 AS Decimal(9, 2)), CAST(950.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (50, N'Korrel Koper 5 %', CAST(500.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (51, N'Korrel Cobalt 0,5 %', CAST(950.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (52, N'Korrel Selenium 60 ppm', CAST(285.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (53, N'Bem zout Koper 7 %', CAST(840.00 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (54, N'Entec 25-15', CAST(420420.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (55, N'KAS +4 MgO', CAST(383.00 AS Decimal(9, 2)), CAST(1070.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (56, N'Boriumpoeder 17,4 %', CAST(1750.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (58, N'Granu-potash 47', CAST(920.00 AS Decimal(9, 2)), CAST(1180.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (59, N'Mangaansulfaat 32%', CAST(825.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (60, N'PK 0-15-30', CAST(560.00 AS Decimal(9, 2)), CAST(1050.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (61, N'NP 23-23', CAST(622.50 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (62, N'Dologran', CAST(119.50 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (63, N'Cobaltsulfaat 21 %', CAST(17000.00 AS Decimal(9, 2)), CAST(1200.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (64, N'Zinksulfaat', CAST(1100.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (66, N'mnsulfaat', CAST(900.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (70, N'NP 17-17+0,1 B', CAST(485.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (71, N'NP 20-20+0,2 B', CAST(510.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (72, N'Microzout 30', CAST(400.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (73, N'Knochenmehl', CAST(400.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (74, N'blendklei', CAST(300.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (75, N'blendolie', CAST(850.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (77, N'solubor 20,8 %', CAST(2300.00 AS Decimal(9, 2)), CAST(1500.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (78, N'Korrelzout 32', CAST(210.00 AS Decimal(9, 2)), CAST(1160.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (79, N'Korrel Koper 8 %', CAST(950.00 AS Decimal(9, 2)), CAST(1054.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (80, N'Korrel Kobalt 0,7 %', CAST(1050.00 AS Decimal(9, 2)), CAST(1047.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (82, N'urean', CAST(290.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (83, N'anasol', CAST(85.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (85, N'APP', CAST(885.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (86, N'seleniumzout zakgoed', CAST(285285.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (88, N'Entec Perfect 14-7-17', CAST(775.00 AS Decimal(9, 2)), CAST(1000.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (89, N'NP 16+11 + 0,3 B + 3,5% Hfirst', CAST(540.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (90, N'Korrel Kobalt Zwolle/Veendam', CAST(450.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (91, N'Humifirst NP 16+16 + 0,2 B+3 MgO + 1,5% hfirst', CAST(350350.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (92, N'Ijzersulfaat', CAST(250.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (93, N'Korrelkali 0-0-30', CAST(560.00 AS Decimal(9, 2)), CAST(1050.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (94, N'Korrelzout-32', CAST(210.00 AS Decimal(9, 2)), CAST(1160.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (97, N'Novamais Kali 15-5-15', CAST(445.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (98, N'NP 20-20', CAST(565.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (99, N'Dynamon S', CAST(393.00 AS Decimal(9, 2)), CAST(1100.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (101, N'Mag 65', CAST(240.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (102, N'methyleen-ureum', CAST(800.00 AS Decimal(9, 2)), CAST(855.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (103, N'Selenium uit Ankerpoort-Se', CAST(3200.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (104, N'NPK 7-14-20 chloorarm', CAST(600.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[tblCPais_Product] ([lngIdProduct], [strProductDescription], [decProductDefaultPrice], [decDensity]) VALUES (105, N'NK 16-0-28', CAST(570.00 AS Decimal(9, 2)), CAST(1.00 AS Decimal(9, 2)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_Product] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ProductNutrient] ON 
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (1, 1, 1, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (2, 1, 5, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (3, 1, 6, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (4, 1, 10, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (5, 1, 11, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (6, 1, 16, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (8, 1, 24, CAST(-15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (9, 1, 25, CAST(-10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (10, 2, 1, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (11, 2, 2, CAST(46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (12, 2, 6, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (13, 2, 8, CAST(41.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (14, 2, 15, CAST(3.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (16, 2, 24, CAST(-36.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (17, 2, 25, CAST(-33.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (18, 2, 49, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (19, 2, 55, CAST(46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (20, 3, 1, CAST(22.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (21, 3, 5, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (22, 3, 6, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (23, 3, 10, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (24, 3, 11, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (25, 3, 16, CAST(10.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (27, 3, 24, CAST(-2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (28, 3, 25, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (29, 3, 46, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (30, 4, 2, CAST(45.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (31, 4, 8, CAST(43.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (32, 4, 15, CAST(4.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (33, 4, 16, CAST(24.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (35, 4, 24, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (36, 4, 25, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (37, 4, 43, CAST(45.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (38, 5, 1, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (39, 5, 2, CAST(52.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (40, 5, 6, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (41, 5, 8, CAST(47.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (43, 6, 1, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (44, 6, 2, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (45, 6, 5, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (46, 6, 6, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (47, 6, 8, CAST(12.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (49, 6, 24, CAST(-32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (50, 6, 25, CAST(-26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (51, 6, 42, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (52, 7, 1, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (53, 7, 5, CAST(10.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (54, 7, 6, CAST(10.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (55, 7, 11, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (56, 7, 16, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (58, 7, 24, CAST(-1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (59, 7, 25, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (60, 7, 46, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (61, 8, 3, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (62, 8, 14, CAST(47.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (64, 8, 61, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (65, 9, 4, CAST(30.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (66, 9, 10, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (67, 9, 11, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (68, 9, 14, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (69, 9, 15, CAST(43.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (71, 9, 24, CAST(0.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (72, 9, 25, CAST(0.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (73, 9, 36, CAST(30.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (74, 10, 1, CAST(20.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (75, 10, 2, CAST(8.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (76, 10, 3, CAST(11.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (77, 10, 5, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (78, 10, 6, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (79, 10, 11, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (80, 10, 14, CAST(9.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (81, 10, 15, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (82, 10, 19, CAST(0.020000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (83, 11, 10, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (84, 11, 11, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (85, 11, 15, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (87, 11, 24, CAST(-2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (88, 11, 25, CAST(-2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (89, 11, 37, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (90, 12, 3, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (91, 12, 10, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (92, 12, 11, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (93, 12, 14, CAST(44.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (94, 12, 15, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (95, 12, 22, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (97, 12, 24, CAST(-1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (98, 12, 25, CAST(-1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (99, 12, 62, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (100, 13, 4, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (101, 13, 14, CAST(2.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (102, 13, 15, CAST(43.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (104, 13, 47, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (105, 14, 1, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (106, 14, 5, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (107, 14, 6, CAST(19.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (108, 14, 11, CAST(0.030000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (109, 14, 15, CAST(32.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (111, 14, 24, CAST(-51.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (112, 14, 25, CAST(-46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (113, 14, 57, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (114, 14, 58, CAST(32.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (115, 15, 2, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (116, 15, 8, CAST(19.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (117, 15, 15, CAST(31.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (118, 15, 16, CAST(34.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (120, 15, 24, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (121, 15, 25, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (122, 15, 34, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (123, 16, 19, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (124, 16, 66, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (125, 17, 1, CAST(11.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (126, 17, 2, CAST(5.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (127, 17, 5, CAST(0.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (128, 17, 6, CAST(11.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (129, 17, 8, CAST(5.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (130, 17, 15, CAST(38.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (131, 17, 16, CAST(8.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (132, 17, 19, CAST(2.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (134, 17, 24, CAST(-14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (135, 17, 25, CAST(-12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (136, 17, 75, CAST(2.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (137, 18, 10, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (138, 18, 11, CAST(35.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (139, 18, 15, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (140, 19, 1, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (141, 19, 2, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (142, 19, 4, CAST(30.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (143, 19, 5, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (144, 19, 6, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (145, 19, 8, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (146, 19, 10, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (147, 19, 11, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (148, 19, 15, CAST(33.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (149, 19, 16, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (151, 20, 1, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (152, 20, 2, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (153, 20, 4, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (154, 20, 5, CAST(2.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (155, 20, 6, CAST(9.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (156, 20, 8, CAST(9.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (157, 20, 15, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (159, 20, 24, CAST(-5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (160, 20, 25, CAST(-3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (161, 21, 1, CAST(13.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (162, 21, 2, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (163, 21, 3, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (164, 21, 14, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (165, 21, 15, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (166, 22, 14, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (167, 22, 22, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (169, 22, 24, CAST(-2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (170, 22, 45, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (171, 23, 12, CAST(3.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (172, 23, 14, CAST(54.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (173, 23, 22, CAST(47.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (175, 24, 13, CAST(0.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (176, 24, 14, CAST(58.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (177, 24, 22, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (179, 24, 25, CAST(-2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (180, 25, 1, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (181, 25, 6, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (182, 25, 15, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (184, 25, 24, CAST(-63.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (185, 25, 25, CAST(-59.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (186, 25, 56, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (187, 25, 59, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (188, 26, 1, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (189, 26, 5, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (190, 26, 6, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (191, 26, 14, CAST(37.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (192, 26, 15, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (193, 26, 16, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (194, 26, 22, CAST(33.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (196, 27, 1, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (197, 27, 2, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (198, 27, 5, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (199, 27, 6, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (200, 27, 8, CAST(6.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (202, 27, 24, CAST(-31.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (203, 27, 25, CAST(-26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (204, 27, 64, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (205, 28, 1, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (206, 28, 5, CAST(7.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (207, 28, 6, CAST(18.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (208, 28, 15, CAST(32.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (210, 28, 24, CAST(-51.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (211, 28, 25, CAST(-46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (212, 28, 32, CAST(0.185000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (213, 28, 39, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (214, 29, 3, CAST(40.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (215, 29, 10, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (216, 29, 11, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (217, 29, 14, CAST(36.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (218, 29, 15, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (219, 29, 22, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (221, 29, 24, CAST(-8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (222, 29, 25, CAST(-8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (223, 29, 53, CAST(40.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (224, 30, 1, CAST(15.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (225, 30, 5, CAST(14.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (226, 30, 6, CAST(1.100000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (227, 30, 16, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (229, 31, 1, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (230, 31, 5, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (231, 31, 19, CAST(0.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (232, 31, 22, CAST(35.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (234, 31, 24, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (235, 31, 25, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (236, 32, 1, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (237, 32, 2, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (238, 32, 4, CAST(28.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (239, 32, 5, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (240, 32, 6, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (241, 32, 8, CAST(12.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (242, 32, 15, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (244, 32, 24, CAST(-3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (245, 32, 25, CAST(-3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (246, 33, 2, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (247, 33, 3, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (248, 33, 8, CAST(7.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (249, 33, 14, CAST(13.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (250, 33, 15, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (251, 33, 16, CAST(19.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (253, 33, 24, CAST(-16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (254, 33, 25, CAST(-14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (255, 34, 1, CAST(46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (256, 34, 31, CAST(46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (257, 35, 1, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (258, 35, 2, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (259, 35, 3, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (260, 35, 5, CAST(6.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (261, 35, 6, CAST(10.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (262, 35, 8, CAST(15.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (264, 36, 1, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (265, 36, 6, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (266, 36, 10, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (267, 36, 11, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (268, 36, 14, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (269, 36, 15, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (270, 36, 22, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (272, 36, 70, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (273, 37, 2, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (274, 37, 3, CAST(45.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (275, 37, 8, CAST(7.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (276, 37, 14, CAST(34.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (277, 37, 15, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (278, 37, 16, CAST(7.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (280, 37, 24, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (281, 38, 1, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (282, 38, 2, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (283, 38, 3, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (284, 38, 5, CAST(6.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (285, 38, 6, CAST(8.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (286, 38, 8, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (287, 38, 14, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (288, 38, 15, CAST(3.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (290, 38, 24, CAST(-15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (291, 38, 25, CAST(-12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (292, 39, 2, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (293, 39, 3, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (294, 39, 11, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (295, 39, 15, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (296, 39, 16, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (298, 40, 3, CAST(40.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (299, 40, 14, CAST(36.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (300, 41, 13, CAST(1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (301, 41, 14, CAST(55.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (302, 41, 22, CAST(47.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (304, 41, 25, CAST(-2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (305, 42, 12, CAST(57.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (307, 44, 11, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (309, 45, 2, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (310, 45, 8, CAST(16.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (311, 45, 15, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (312, 45, 16, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (314, 45, 24, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (315, 45, 33, CAST(18.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (316, 46, 2, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (317, 46, 3, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (318, 46, 8, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (320, 47, 1, CAST(26.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (321, 47, 2, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (322, 47, 5, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (323, 47, 6, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (324, 47, 8, CAST(6.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (325, 47, 15, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (326, 47, 16, CAST(6.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (328, 47, 74, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (329, 48, 1, CAST(7.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (330, 48, 4, CAST(27.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (331, 48, 5, CAST(3.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (332, 48, 6, CAST(3.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (333, 48, 10, CAST(4.054000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (334, 48, 11, CAST(4.590000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (335, 48, 15, CAST(32.260000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (336, 48, 16, CAST(1.635000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (337, 49, 1, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (338, 49, 5, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (339, 49, 6, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (340, 49, 16, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (342, 49, 24, CAST(-15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (343, 49, 25, CAST(-10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (344, 50, 2, CAST(6.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (345, 50, 8, CAST(5.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (346, 50, 11, CAST(2.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (347, 50, 12, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (348, 50, 15, CAST(12.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (349, 50, 16, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (350, 50, 22, CAST(25.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (352, 51, 2, CAST(6.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (353, 51, 8, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (354, 51, 11, CAST(2.900000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (355, 51, 13, CAST(0.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (356, 51, 15, CAST(13.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (357, 51, 16, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (358, 51, 22, CAST(27.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (360, 52, 1, CAST(1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (361, 52, 2, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (362, 52, 11, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (363, 52, 15, CAST(7.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (364, 52, 22, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (366, 52, 29, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (367, 53, 12, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (368, 53, 14, CAST(55.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (369, 53, 22, CAST(45.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (371, 53, 25, CAST(-1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (372, 54, 1, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (373, 54, 2, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (374, 54, 5, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (375, 54, 6, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (376, 54, 8, CAST(10.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (377, 54, 15, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (379, 54, 35, CAST(25.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (380, 55, 1, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (381, 55, 5, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (382, 55, 6, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (383, 55, 11, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (384, 55, 16, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (386, 55, 24, CAST(-15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (387, 55, 25, CAST(-10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (388, 56, 19, CAST(17.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (389, 58, 4, CAST(47.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (390, 58, 15, CAST(43.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (392, 58, 48, CAST(47.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (393, 59, 14, CAST(0.020000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (394, 59, 17, CAST(0.000500000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (395, 59, 18, CAST(31.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (397, 60, 2, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (398, 60, 3, CAST(30.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (399, 60, 8, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (400, 60, 15, CAST(10.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (401, 60, 16, CAST(15.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (403, 60, 24, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (404, 60, 79, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (405, 61, 1, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (406, 61, 2, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (407, 61, 5, CAST(8.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (408, 61, 6, CAST(14.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (409, 61, 8, CAST(20.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (411, 61, 24, CAST(-46.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (412, 61, 25, CAST(-43.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (413, 61, 73, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (414, 62, 10, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (415, 62, 11, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (416, 62, 16, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (418, 62, 24, CAST(52.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (419, 62, 25, CAST(52.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (420, 62, 69, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (421, 63, 13, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (423, 64, 17, CAST(0.001000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (424, 64, 20, CAST(35.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (426, 66, 18, CAST(31.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (427, 70, 1, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (428, 70, 2, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (429, 70, 5, CAST(4.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (430, 70, 6, CAST(12.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (431, 70, 8, CAST(15.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (432, 70, 15, CAST(9.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (433, 70, 19, CAST(0.100000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (435, 70, 65, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (436, 71, 1, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (437, 71, 2, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (438, 71, 5, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (439, 71, 6, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (440, 71, 19, CAST(0.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (442, 72, 2, CAST(6.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (443, 72, 11, CAST(1.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (444, 72, 12, CAST(0.870000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (445, 72, 13, CAST(0.088000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (446, 72, 15, CAST(11.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (447, 72, 16, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (448, 72, 22, CAST(29.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (449, 72, 29, CAST(22.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (450, 73, 1, CAST(7.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (451, 73, 2, CAST(13.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (452, 73, 16, CAST(16.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (453, 74, 52, CAST(100.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (454, 75, 51, CAST(100.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (455, 77, 19, CAST(20.900000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (457, 77, 60, CAST(20.900000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (458, 78, 2, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (459, 78, 8, CAST(3.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (460, 78, 11, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (461, 78, 14, CAST(36.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (462, 78, 15, CAST(7.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (463, 78, 16, CAST(7.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (464, 78, 22, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (466, 78, 44, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (467, 79, 1, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (468, 79, 2, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (469, 79, 5, CAST(1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (470, 79, 6, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (471, 79, 8, CAST(5.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (472, 79, 12, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (473, 79, 14, CAST(24.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (474, 79, 15, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (475, 79, 16, CAST(1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (476, 79, 22, CAST(21.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (478, 80, 1, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (479, 80, 2, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (480, 80, 3, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (481, 80, 5, CAST(1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (482, 80, 6, CAST(4.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (483, 80, 8, CAST(4.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (484, 80, 11, CAST(0.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (485, 80, 13, CAST(0.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (486, 80, 14, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (487, 80, 15, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (488, 80, 16, CAST(3.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (489, 80, 22, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (491, 82, 1, CAST(30.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (492, 82, 5, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (493, 82, 6, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (494, 82, 31, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (495, 83, 1, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (496, 83, 6, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (497, 83, 15, CAST(12.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (498, 85, 1, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (499, 85, 2, CAST(34.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (500, 85, 6, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (501, 85, 8, CAST(34.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (502, 86, 14, CAST(55.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (503, 86, 22, CAST(50.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (504, 86, 29, CAST(60.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (505, 88, 1, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (506, 88, 2, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (507, 88, 4, CAST(17.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (508, 88, 5, CAST(5.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (509, 88, 6, CAST(8.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (510, 88, 8, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (511, 88, 10, CAST(1.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (512, 88, 11, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (513, 88, 15, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (514, 88, 19, CAST(0.020000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (515, 88, 20, CAST(0.010000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (517, 88, 32, CAST(0.070000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (518, 88, 67, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (519, 89, 1, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (520, 89, 2, CAST(11.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (521, 89, 5, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (522, 89, 6, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (523, 89, 8, CAST(9.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (524, 89, 11, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (525, 89, 19, CAST(0.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (526, 89, 68, CAST(3.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (527, 90, 1, CAST(2.700000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (528, 90, 2, CAST(2.570000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (529, 90, 5, CAST(0.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (530, 90, 6, CAST(1.900000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (531, 90, 11, CAST(1.100000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (532, 90, 13, CAST(0.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (533, 90, 15, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (534, 90, 22, CAST(27.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (536, 91, 1, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (537, 91, 2, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (538, 91, 5, CAST(2.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (539, 91, 6, CAST(13.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (540, 91, 8, CAST(14.400000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (541, 91, 11, CAST(3.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (542, 91, 19, CAST(0.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (543, 91, 68, CAST(1.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (544, 92, 11, CAST(1.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (545, 92, 16, CAST(0.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (546, 92, 17, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (547, 92, 18, CAST(0.065000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (548, 93, 3, CAST(30.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (549, 93, 14, CAST(34.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (550, 93, 15, CAST(10.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (551, 93, 16, CAST(15.300000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (553, 93, 24, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (554, 94, 1, CAST(0.000100000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (555, 94, 11, CAST(2.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (556, 94, 14, CAST(36.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (557, 94, 15, CAST(7.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (558, 94, 16, CAST(7.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (559, 94, 22, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (561, 94, 44, CAST(32.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (562, 97, 1, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (563, 97, 2, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (564, 97, 3, CAST(15.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (565, 97, 6, CAST(10.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (566, 97, 8, CAST(4.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (567, 97, 15, CAST(23.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (569, 98, 1, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (570, 98, 2, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (571, 98, 5, CAST(8.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (572, 98, 6, CAST(11.800000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (573, 98, 8, CAST(13.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (574, 98, 15, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (575, 98, 16, CAST(6.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (577, 99, 1, CAST(24.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (578, 99, 5, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (579, 99, 6, CAST(12.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (580, 99, 15, CAST(17.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (582, 99, 77, CAST(24.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (583, 99, 78, CAST(17.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (584, 101, 10, CAST(5.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (585, 101, 11, CAST(65.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (586, 102, 1, CAST(39.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (587, 102, 9, CAST(35.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (589, 102, 31, CAST(4.500000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (590, 103, 29, CAST(2000.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (591, 103, 83, CAST(2000.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (592, 104, 1, CAST(7.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (593, 104, 2, CAST(14.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (594, 104, 4, CAST(20.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (595, 104, 8, CAST(13.200000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (596, 104, 15, CAST(33.100000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (597, 104, 16, CAST(6.600000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (598, 105, 1, CAST(16.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (599, 105, 3, CAST(28.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (600, 105, 5, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (601, 105, 6, CAST(8.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[tblCPais_ProductNutrient] ([lngIdProductNutrient], [lngProductId], [lngNutrientId], [decNutrientValue]) VALUES (604, 2, 87, CAST(10.000000000 AS Decimal(18, 9)))
GO
SET IDENTITY_INSERT [dbo].[tblCPais_ProductNutrient] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysConfigurationItem] ON 
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (1, 1, N'User Manual', N'All', N'D:\Clients\Triferto\BlendProgramma\Manual\Triferto User Manual Blend.docx')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (2, 1, N'Location', N'All', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (8, 1, N'User', N'All', N'6')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (10, 1, N'Level', N'All', N'05')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (11, 1, N'LevelMatrix', N'All', N'05')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (12, 1, N'LevelMemory', N'All', N'05')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (13, 1, N'ShowMessage', N'All', N'0')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (19, 1, N'Restriction', N'All', N'-1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (20, 1, N'AddedProduct', N'All', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (23, 1, N'RestrictionNumber', N'All', N'5')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (24, 1, N'Product', N'All', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (28, 1, N'Level', N'Vincent', N'05')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (29, 1, N'LevelMemory', N'Vincent', N'05')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (30, 1, N'LevelMatrix', N'Vincent', N'05')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (31, 1, N'RestrictionNumber', N'Vincent', N'5')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (32, 1, N'Restriction', N'Vincent', N'-1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (33, 1, N'ShowMessage', N'Vincent', N'-1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (34, 1, N'AddedProduct', N'Vincent', N'-1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (35, 1, N'Product', N'Vincent', N'3')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (36, 1, N'Location', N'Vincent', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (37, 1, N'ConfirmDeletion', N'All', N'Yes')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (38, 1, N'FixedNutrient01', N'All', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (40, 1, N'FixedNutrient02', N'All', N'2')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (42, 1, N'FixedNutrient03', N'All', N'3')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (43, 1, N'FixedNutrient04', N'All', NULL)
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (44, 1, N'FixedNutrient05', N'All', NULL)
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (45, 1, N'CompositionType', N'All', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (46, 1, N'CompositionType', N'Vincent', N'1')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (47, 1, N'Prefix', N'All', N'Samenstelling ADMBis')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (48, 1, N'CaliumPoor', N'All', N'4')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (58, 1, N'Magnesium', N'All', N'11')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (59, 1, N'Chlorine', N'All', N'14')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (60, 1, N'Sodium', N'All', N'22')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (61, 1, N'Sulphur', N'All', N'15')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (62, 1, N'ExcelPathResult', N'All', N'D:\Clients\Triferto\BlendProgramma\Offerten\')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (63, 1, N'ExcelPathRecept', N'All', N'D:\Clients\Triferto\BlendProgramma\Recepten en begeleidingsbrieven\')
GO
INSERT [dbo].[tblCPais_sysConfigurationItem] ([lngIdConfigurationItem], [lngProjectId], [strConfigurationItem], [strUser], [strValue]) VALUES (64, 1, N'Comment', N'All', N'LET OP: Prijs geldig tot 31 oktober 2008.')
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysConfigurationItem] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysProject] ON 
GO
INSERT [dbo].[tblCPais_sysProject] ([lngIdProject], [strProject]) VALUES (1, N'Blend Calculation')
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysProject] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysRibbon] ON 
GO
INSERT [dbo].[tblCPais_sysRibbon] ([lngIdRibbon], [lngProjectId], [strRibbonName], [xmlRibbon]) VALUES (1, 1, N'HideAll', N'<customUI xmlns="http://schemas.microsoft.com/office/2006/01/customui"><ribbon startFromScratch="true" /></customUI>')
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysRibbon] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysTable] ON 
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (1, N'pagContactPerson', N'Contact Persoon', 1)
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (2, N'pagPackaging', N'Emballage', 1)
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (4, N'pagExtraCost', N'Extra kost', 1)
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (5, N'pagProduct', N'Product', 1)
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (6, N'pagNutrient', N'Nutriënt', 1)
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (7, N'pagLocation', N'Locatie', 1)
GO
INSERT [dbo].[tblCPais_sysTable] ([lngIdTable], [strInputTableTab], [strInputTableDescription], [lngProjectId]) VALUES (8, N'pagClient', N'Klant', 1)
GO
SET IDENTITY_INSERT [dbo].[tblCPais_sysTable] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indClientUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_Client] ADD  CONSTRAINT [indClientUnique] UNIQUE NONCLUSTERED 
(
	[strClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [intClientContactPersonUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_ClientContactPerson] ADD  CONSTRAINT [intClientContactPersonUnique] UNIQUE NONCLUSTERED 
(
	[lngClientId] ASC,
	[lngContactPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indCompositionUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_Composition] ADD  CONSTRAINT [indCompositionUnique] UNIQUE NONCLUSTERED 
(
	[strCompositionDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionClient]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionClient] ON [dbo].[tblCPais_Composition]
(
	[lngClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionContactPerson]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionContactPerson] ON [dbo].[tblCPais_Composition]
(
	[lngContactPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionLocation]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionLocation] ON [dbo].[tblCPais_Composition]
(
	[lngLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionExerciseUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_CompositionExercise] ADD  CONSTRAINT [indCompositionExerciseUnique] UNIQUE NONCLUSTERED 
(
	[lngCompositionId] ASC,
	[lngNutrientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionExerciseComposition]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionExerciseComposition] ON [dbo].[tblCPais_CompositionExercise]
(
	[lngCompositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionExerciseNutrient]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionExerciseNutrient] ON [dbo].[tblCPais_CompositionExercise]
(
	[lngNutrientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionResultUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_CompositionResult] ADD  CONSTRAINT [indCompositionResultUnique] UNIQUE NONCLUSTERED 
(
	[lngCompositionId] ASC,
	[lngProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionResultComposition]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionResultComposition] ON [dbo].[tblCPais_CompositionResult]
(
	[lngCompositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indCompositionResultProduct]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionResultProduct] ON [dbo].[tblCPais_CompositionResult]
(
	[lngProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indCompositionTypeUnique]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indCompositionTypeUnique] ON [dbo].[tblCPais_CompositionType]
(
	[strCompositionTypeDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indContactPersonContactPersonName]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indContactPersonContactPersonName] ON [dbo].[tblCPais_ContactPerson]
(
	[strContactPersonName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indExtraCostExtraCostDescription]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_ExtraCost] ADD  CONSTRAINT [indExtraCostExtraCostDescription] UNIQUE NONCLUSTERED 
(
	[strExtraCostDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indLocationLocationDescription]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_Location] ADD  CONSTRAINT [indLocationLocationDescription] UNIQUE NONCLUSTERED 
(
	[strLocationDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indLocationExtraCostUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_LocationExtraCost] ADD  CONSTRAINT [indLocationExtraCostUnique] UNIQUE NONCLUSTERED 
(
	[lngLocationId] ASC,
	[lngExtraCostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indLocationExtraCostExtraCost]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indLocationExtraCostExtraCost] ON [dbo].[tblCPais_LocationExtraCost]
(
	[lngExtraCostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [LocationExtraCostLocation]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [LocationExtraCostLocation] ON [dbo].[tblCPais_LocationExtraCost]
(
	[lngLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indLocationProductUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_LocationProduct] ADD  CONSTRAINT [indLocationProductUnique] UNIQUE NONCLUSTERED 
(
	[lngLocationId] ASC,
	[lngProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indLocationProductLocation]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indLocationProductLocation] ON [dbo].[tblCPais_LocationProduct]
(
	[lngLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indLocationProductProduct]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indLocationProductProduct] ON [dbo].[tblCPais_LocationProduct]
(
	[lngProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indNutrientUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_Nutrient] ADD  CONSTRAINT [indNutrientUnique] UNIQUE NONCLUSTERED 
(
	[strNutrientDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indPackagingUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_Packaging] ADD  CONSTRAINT [indPackagingUnique] UNIQUE NONCLUSTERED 
(
	[strPackagingDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indProductUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_Product] ADD  CONSTRAINT [indProductUnique] UNIQUE NONCLUSTERED 
(
	[strProductDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indProductNutrientUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_ProductNutrient] ADD  CONSTRAINT [indProductNutrientUnique] UNIQUE NONCLUSTERED 
(
	[lngProductId] ASC,
	[lngNutrientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indProductNutrientNutrient]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indProductNutrientNutrient] ON [dbo].[tblCPais_ProductNutrient]
(
	[lngNutrientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [indProductNutrientProduct]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indProductNutrientProduct] ON [dbo].[tblCPais_ProductNutrient]
(
	[lngProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indConfigurationItemUnique]    Script Date: 08/12/2021 12:21:23 ******/
ALTER TABLE [dbo].[tblCPais_sysConfigurationItem] ADD  CONSTRAINT [indConfigurationItemUnique] UNIQUE NONCLUSTERED 
(
	[lngProjectId] ASC,
	[strConfigurationItem] ASC,
	[strUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indRibbonUnique]    Script Date: 08/12/2021 12:21:23 ******/
CREATE NONCLUSTERED INDEX [indRibbonUnique] ON [dbo].[tblCPais_sysRibbon]
(
	[lngProjectId] ASC,
	[strRibbonName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCPais_Composition] ADD  CONSTRAINT [DF_tblCPais_Composition_decOrderWeight]  DEFAULT ((1000)) FOR [decOrderWeight]
GO
ALTER TABLE [dbo].[tblCPais_Composition] ADD  CONSTRAINT [DF_tblCPais_Composition_decHectare]  DEFAULT ((1)) FOR [decHectare]
GO
ALTER TABLE [dbo].[tblCPais_Composition] ADD  CONSTRAINT [DF_tblCPais_Composition_dtmComposition]  DEFAULT (getdate()) FOR [dtmComposition]
GO
ALTER TABLE [dbo].[tblCPais_Composition] ADD  CONSTRAINT [DF_tblCPais_Composition_bytKindOfComposition]  DEFAULT ((1)) FOR [lngCompositionTypeId]
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise] ADD  CONSTRAINT [DF_tblCPais_CompositionExercise_decMinimum]  DEFAULT ((0)) FOR [decMinimum]
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise] ADD  CONSTRAINT [DF_tblCPais_CompositionExercise_decMaximum]  DEFAULT ((9999.99)) FOR [decMaximum]
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise] ADD  CONSTRAINT [DF_tblCPais_CompositionExercise_blnAllowed]  DEFAULT ((1)) FOR [blnAllowed]
GO
ALTER TABLE [dbo].[tblCPais_CompositionResult] ADD  CONSTRAINT [DF_tblCPais_CompositionResult_decCompositionResultWeight]  DEFAULT ((0)) FOR [decCompositionResultWeight]
GO
ALTER TABLE [dbo].[tblCPais_ExtraCost] ADD  CONSTRAINT [DF_tblCPais_ExtraKosten_dblPrijs]  DEFAULT ((0)) FOR [decExtraCostPrice]
GO
ALTER TABLE [dbo].[tblCPais_Location] ADD  CONSTRAINT [DF_tblCPais_Location_lngMaximumBlendRun]  DEFAULT ((1)) FOR [lngMaximumBlendRun]
GO
ALTER TABLE [dbo].[tblCPais_LocationExtraCost] ADD  CONSTRAINT [DF_tblCPais_LocationExtraCost_decLocationExtraCostPrice]  DEFAULT ((1)) FOR [decLocationExtraCostPrice]
GO
ALTER TABLE [dbo].[tblCPais_LocationPackaging] ADD  CONSTRAINT [DF_tblCPais_LocationPackaging_decLocationPackagingPrice]  DEFAULT ((1)) FOR [decLocationPackagingPrice]
GO
ALTER TABLE [dbo].[tblCPais_LocationProduct] ADD  CONSTRAINT [DF_tblCPais_LocationProduct_decLocationProductPrice]  DEFAULT ((1)) FOR [decLocationProductPrice]
GO
ALTER TABLE [dbo].[tblCPais_Nutrient] ADD  CONSTRAINT [DF_tblCPais_Nutrient_blnNutrientExerciseValue]  DEFAULT ((1)) FOR [blnNutrientExerciseValue]
GO
ALTER TABLE [dbo].[tblCPais_Packaging] ADD  CONSTRAINT [DF_tblCPais_Emballage_dblPrijs]  DEFAULT ((1)) FOR [decPackagingPrice]
GO
ALTER TABLE [dbo].[tblCPais_Product] ADD  CONSTRAINT [DF_tblCPais_Product_decProductDefaultPrice]  DEFAULT ((1)) FOR [decProductDefaultPrice]
GO
ALTER TABLE [dbo].[tblCPais_Product] ADD  CONSTRAINT [DF_tblCPais_Product_decDensity]  DEFAULT ((1)) FOR [decDensity]
GO
ALTER TABLE [dbo].[tblCPais_ProductNutrient] ADD  CONSTRAINT [DF_tblCPais_ProductIngredient_decIngredientValue]  DEFAULT ((0)) FOR [decNutrientValue]
GO
ALTER TABLE [dbo].[tblCPais_ClientContactPerson]  WITH CHECK ADD  CONSTRAINT [relClientClientContactPerson] FOREIGN KEY([lngClientId])
REFERENCES [dbo].[tblCPais_Client] ([lngIdClient])
GO
ALTER TABLE [dbo].[tblCPais_ClientContactPerson] CHECK CONSTRAINT [relClientClientContactPerson]
GO
ALTER TABLE [dbo].[tblCPais_ClientContactPerson]  WITH CHECK ADD  CONSTRAINT [relContactPersonClientContactPerson] FOREIGN KEY([lngContactPersonId])
REFERENCES [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson])
GO
ALTER TABLE [dbo].[tblCPais_ClientContactPerson] CHECK CONSTRAINT [relContactPersonClientContactPerson]
GO
ALTER TABLE [dbo].[tblCPais_Composition]  WITH CHECK ADD  CONSTRAINT [relClientComposition] FOREIGN KEY([lngClientId])
REFERENCES [dbo].[tblCPais_Client] ([lngIdClient])
GO
ALTER TABLE [dbo].[tblCPais_Composition] CHECK CONSTRAINT [relClientComposition]
GO
ALTER TABLE [dbo].[tblCPais_Composition]  WITH CHECK ADD  CONSTRAINT [relCompositionTypeComposition] FOREIGN KEY([lngCompositionTypeId])
REFERENCES [dbo].[tblCPais_CompositionType] ([lngIdCompositionType])
GO
ALTER TABLE [dbo].[tblCPais_Composition] CHECK CONSTRAINT [relCompositionTypeComposition]
GO
ALTER TABLE [dbo].[tblCPais_Composition]  WITH CHECK ADD  CONSTRAINT [relContactPersonComposition] FOREIGN KEY([lngContactPersonId])
REFERENCES [dbo].[tblCPais_ContactPerson] ([lngIdContactPerson])
GO
ALTER TABLE [dbo].[tblCPais_Composition] CHECK CONSTRAINT [relContactPersonComposition]
GO
ALTER TABLE [dbo].[tblCPais_Composition]  WITH CHECK ADD  CONSTRAINT [relLocationComposition] FOREIGN KEY([lngLocationId])
REFERENCES [dbo].[tblCPais_Location] ([lngIdLocation])
GO
ALTER TABLE [dbo].[tblCPais_Composition] CHECK CONSTRAINT [relLocationComposition]
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise]  WITH CHECK ADD  CONSTRAINT [relCompositionCompositionExercise] FOREIGN KEY([lngCompositionId])
REFERENCES [dbo].[tblCPais_Composition] ([lngIdComposition])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise] CHECK CONSTRAINT [relCompositionCompositionExercise]
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise]  WITH CHECK ADD  CONSTRAINT [relNutrientCompositionExercise] FOREIGN KEY([lngNutrientId])
REFERENCES [dbo].[tblCPais_Nutrient] ([lngIdNutrient])
GO
ALTER TABLE [dbo].[tblCPais_CompositionExercise] CHECK CONSTRAINT [relNutrientCompositionExercise]
GO
ALTER TABLE [dbo].[tblCPais_CompositionResult]  WITH CHECK ADD  CONSTRAINT [relCompositionCompositionResult] FOREIGN KEY([lngCompositionId])
REFERENCES [dbo].[tblCPais_Composition] ([lngIdComposition])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCPais_CompositionResult] CHECK CONSTRAINT [relCompositionCompositionResult]
GO
ALTER TABLE [dbo].[tblCPais_CompositionResult]  WITH CHECK ADD  CONSTRAINT [relProductCompositionResult] FOREIGN KEY([lngProductId])
REFERENCES [dbo].[tblCPais_Product] ([lngIdProduct])
GO
ALTER TABLE [dbo].[tblCPais_CompositionResult] CHECK CONSTRAINT [relProductCompositionResult]
GO
ALTER TABLE [dbo].[tblCPais_LocationExtraCost]  WITH CHECK ADD  CONSTRAINT [relExtraCostLocationExtraCost] FOREIGN KEY([lngExtraCostId])
REFERENCES [dbo].[tblCPais_ExtraCost] ([lngIdExtraCost])
GO
ALTER TABLE [dbo].[tblCPais_LocationExtraCost] CHECK CONSTRAINT [relExtraCostLocationExtraCost]
GO
ALTER TABLE [dbo].[tblCPais_LocationExtraCost]  WITH CHECK ADD  CONSTRAINT [relLocationLocationExtraCost] FOREIGN KEY([lngLocationId])
REFERENCES [dbo].[tblCPais_Location] ([lngIdLocation])
GO
ALTER TABLE [dbo].[tblCPais_LocationExtraCost] CHECK CONSTRAINT [relLocationLocationExtraCost]
GO
ALTER TABLE [dbo].[tblCPais_LocationPackaging]  WITH CHECK ADD  CONSTRAINT [relLocationLocationPackaging] FOREIGN KEY([lngLocationId])
REFERENCES [dbo].[tblCPais_Location] ([lngIdLocation])
GO
ALTER TABLE [dbo].[tblCPais_LocationPackaging] CHECK CONSTRAINT [relLocationLocationPackaging]
GO
ALTER TABLE [dbo].[tblCPais_LocationPackaging]  WITH CHECK ADD  CONSTRAINT [relPackagingLocationPackaging] FOREIGN KEY([lngPackagingId])
REFERENCES [dbo].[tblCPais_Packaging] ([lngIdPackaging])
GO
ALTER TABLE [dbo].[tblCPais_LocationPackaging] CHECK CONSTRAINT [relPackagingLocationPackaging]
GO
ALTER TABLE [dbo].[tblCPais_LocationProduct]  WITH CHECK ADD  CONSTRAINT [relLocationLocationProduct] FOREIGN KEY([lngLocationId])
REFERENCES [dbo].[tblCPais_Location] ([lngIdLocation])
GO
ALTER TABLE [dbo].[tblCPais_LocationProduct] CHECK CONSTRAINT [relLocationLocationProduct]
GO
ALTER TABLE [dbo].[tblCPais_LocationProduct]  WITH CHECK ADD  CONSTRAINT [relProductLocationProduct] FOREIGN KEY([lngProductId])
REFERENCES [dbo].[tblCPais_Product] ([lngIdProduct])
GO
ALTER TABLE [dbo].[tblCPais_LocationProduct] CHECK CONSTRAINT [relProductLocationProduct]
GO
ALTER TABLE [dbo].[tblCPais_ProductNutrient]  WITH CHECK ADD  CONSTRAINT [relNutrientProductNutrient] FOREIGN KEY([lngNutrientId])
REFERENCES [dbo].[tblCPais_Nutrient] ([lngIdNutrient])
GO
ALTER TABLE [dbo].[tblCPais_ProductNutrient] CHECK CONSTRAINT [relNutrientProductNutrient]
GO
ALTER TABLE [dbo].[tblCPais_ProductNutrient]  WITH CHECK ADD  CONSTRAINT [relProductProductNutrient] FOREIGN KEY([lngProductId])
REFERENCES [dbo].[tblCPais_Product] ([lngIdProduct])
GO
ALTER TABLE [dbo].[tblCPais_ProductNutrient] CHECK CONSTRAINT [relProductProductNutrient]
GO
ALTER TABLE [dbo].[tblCPais_sysConfigurationItem]  WITH CHECK ADD  CONSTRAINT [relsysProjectsysConfigurationItem] FOREIGN KEY([lngProjectId])
REFERENCES [dbo].[tblCPais_sysProject] ([lngIdProject])
GO
ALTER TABLE [dbo].[tblCPais_sysConfigurationItem] CHECK CONSTRAINT [relsysProjectsysConfigurationItem]
GO
ALTER TABLE [dbo].[tblCPais_sysRibbon]  WITH CHECK ADD  CONSTRAINT [relProjectRibbon] FOREIGN KEY([lngProjectId])
REFERENCES [dbo].[tblCPais_sysProject] ([lngIdProject])
GO
ALTER TABLE [dbo].[tblCPais_sysRibbon] CHECK CONSTRAINT [relProjectRibbon]
GO
ALTER TABLE [dbo].[tblCPais_sysTable]  WITH CHECK ADD  CONSTRAINT [relsysProjectsysTable] FOREIGN KEY([lngProjectId])
REFERENCES [dbo].[tblCPais_sysProject] ([lngIdProject])
GO
ALTER TABLE [dbo].[tblCPais_sysTable] CHECK CONSTRAINT [relsysProjectsysTable]
GO
/****** Object:  StoredProcedure [dbo].[Calculate]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Calculate]
	@lngComposition [int],
	@lngCompositionType [int],
	@strProject [nvarchar](4000),
	@strUser [nvarchar](4000),
	@strResult [nvarchar](4000) OUTPUT
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [BlendCalculation].[BlendCalculation.clsCPaisStoredProcedure].[Calculate]
GO
/****** Object:  StoredProcedure [dbo].[spCPais_Client]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_Client]
AS

/*
List of client
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		lngIdClient,
		strClientName,
		strClientStreetNumber,
		strClientZipCode,
		strClientCity,
		strClientPhone,
		strClientFax,
		strClientEmail
	FROM
		dbo.tblCPais_Client WITH (ReadPast)
	ORDER BY
		strClientName

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_ClientContactPerson]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_ClientContactPerson] 
	(
	@Client bigint)
AS

/*
List of contact persons for a specific client
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_ClientContactPerson.*
	FROM
		dbo.tblCPais_ClientContactPerson WITH (ReadPast) INNER JOIN
		dbo.tblCPais_ContactPerson WITH (ReadPast) ON dbo.tblCPais_ClientContactPerson.lngContactPersonId = dbo.tblCPais_ContactPerson.lngIdContactPerson
	WHERE
		dbo.tblCPais_ClientContactPerson.lngClientId = @Client
	ORDER BY
		dbo.tblCPais_ContactPerson.strContactPersonName
	
END



GO
/****** Object:  StoredProcedure [dbo].[spCPais_Composition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_Composition] 
	(
	@CompositionType bigint)
AS

/*
List of composition
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		*
	FROM
		tblCPais_Composition WITH (ReadPast)
	WHERE
		lngCompositionTypeID = @CompositionType
	ORDER BY
		lngCompositionNumber DESC,
		strCompositionDescription

END


GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionExerciseForComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionExerciseForComposition]
	(
	@lngIdComposition bigint)
AS

/*
List of nutrients and mimimum and maximum values for a specific composition
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_CompositionExercise.*
	FROM
		dbo.tblCPais_CompositionExercise WITH (ReadPast)
	WHERE
		lngCompositionId = @lngIdComposition

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionNutrientResultForComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionNutrientResultForComposition]
	(
	@Composition bigint,
	@Location bigint)
AS

/*
List of nutrient result for a specific composition
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Nutrient.strNutrientDescription,
		CONVERT(float, SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100)) AS Weigth 
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	WHERE
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @Composition)
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_ProductNutrient.lngNutrientId,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionProductResultCountForComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionProductResultCountForComposition]
	(
	@Composition bigint)

AS

/*
Product count in result for a specific composition
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		Count(dbo.tblCPais_CompositionResult.lngIdCompositionResult) AS NumberOfProducts
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast)
	WHERE
		(dbo.tblCPais_CompositionResult.lngCompositionId = @Composition) AND
		(dbo.tblCPais_CompositionResult.lngProductId <> 0)	

END


GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionProductResultForComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionProductResultForComposition]
	(
	@Composition bigint,
	@Location bigint,
	@CompositionType bigint)

AS

/*
List of product result for a specific composition
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

DECLARE @Value bigint

IF @CompositionType = 1 OR @CompositionType = 3

	BEGIN
		SET @Value = 1000
	END

ELSE

	BEGIN
		IF @CompositionType = 2 OR @CompositionType = 4 
			BEGIN
				SET @Value = 100
			END
	END

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_CompositionResult.lngIdCompositionResult,
		dbo.tblCPais_Product.strProductDescription, 
		dbo.tblCPais_CompositionResult.decCompositionResultWeight,
		dbo.tblCPais_LocationProduct.lngLocationId, 
		convert(float, dbo.tblCPais_CompositionResult.decCompositionResultWeight * dbo.tblCPais_LocationProduct.decLocationProductPrice / @Value) AS Price, 
		dbo.tblCPais_CompositionResult.lngCompositionId
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
        dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct LEFT OUTER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId
	WHERE
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @Composition) AND
		(dbo.tblCPais_CompositionResult.lngProductId <> 0)

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionResultForComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionResultForComposition] 
	(
	@lngIdComposition bigint)
AS

/*
List of composition result
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		tblCPais_CompositionResult.*,
		tblCPais_Product.strProductDescription
	FROM
		tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct
	WHERE
		(lngCompositionId = @lngIdComposition) AND
		(lngProductId <> 0)

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionResultForCompositionAndLocation]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionResultForCompositionAndLocation] 
	(
	@lngIdComposition bigint,
	@Location bigint)
AS

/*
List of composition result
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		tblCPais_CompositionResult.*,
		tblCPais_Product.strProductDescription,
		convert(float, tblCPais_LocationProduct.decLocationProductPrice * decCompositionResultWeight / 1000) as Price
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId
	WHERE
		(lngCompositionId = @lngIdComposition) AND
		(lngLocationId = @Location) AND
		(tblCPais_CompositionResult.lngProductId <> 0)

END


GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionResultForCompositionMessage]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionResultForCompositionMessage] 
	(
	@lngIdComposition bigint)
AS

/*
List of composition result
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		tblCPais_CompositionResult.strMessage
	FROM
		tblCPais_CompositionResult WITH (ReadPast)
	WHERE
		(lngCompositionId = @lngIdComposition) AND
		(lngProductId = 0)

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_CompositionType]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CompositionType] 
AS

/*
List of composition type
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdCompositionType,
		strCompositionTypeDescription
	FROM
		dbo.tblCPais_CompositionType WITH (ReadPast)
	ORDER BY
		strCompositionTypeDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_ContactPerson]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_ContactPerson]
AS

/*
List of contact person
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdContactPerson,
		strContactPersonName,
		strFaxNumber
	FROM
		dbo.tblCPais_ContactPerson WITH (ReadPast)
	ORDER BY
		strContactPersonName

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_ContactPersonForClient]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_ContactPersonForClient]
	(
	@Client bigint)
AS

/*
List of contact persons for a specific client
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN


	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_ContactPerson.lngIdContactPerson,
		dbo.tblCPais_ContactPerson.strContactPersonName, 
		dbo.tblCPais_ContactPerson.strFaxNumber
	FROM
		dbo.tblCPais_ClientContactPerson WITH (ReadPast) INNER JOIN
		dbo.tblCPais_ContactPerson WITH (ReadPast) ON dbo.tblCPais_ClientContactPerson.lngContactPersonId = dbo.tblCPais_ContactPerson.lngIdContactPerson
	WHERE
		(dbo.tblCPais_ClientContactPerson.lngClientId = @Client)
	ORDER BY
		dbo.tblCPais_ContactPerson.strContactPersonName

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CopyExtraCostPricesToAllLocations]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CopyExtraCostPricesToAllLocations]
	(
	@ExtraCostPrice decimal(9,2),
	@ExtraCostKey bigint)
AS

/*
Extra Cost value is copied to all locations
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	UPDATE
		dbo.tblCPais_LocationExtraCost
	SET
		decLocationExtraCostPrice = @ExtraCostPrice
	WHERE
		(lngExtraCostId = @ExtraCostKey)

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CopyExtraCostToAllLocations]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CopyExtraCostToAllLocations] 
	(
	@ExtraCostPrice decimal(9,2),
	@ExtraCostKey bigint)
AS

/*
Extra Cost is added to all locations (if not already done)
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	SET NOCOUNT ON;

	INSERT INTO tblCPais_LocationExtraCost
		SELECT
			lngIdLocation,
			@ExtraCostKey,
			@ExtraCostPrice
		FROM
			dbo.tblCPais_Location WITH (ReadPast)
		WHERE
			lngIdLocation NOT IN
				(
				SELECT
					lngLocationId
				FROM
					dbo.tblCPais_LocationExtraCost WITH (ReadPast)
				WHERE
					(lngExtraCostId = @ExtraCostKey))
END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_CopyPackagingPricesToAllLocations]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CopyPackagingPricesToAllLocations]
	(
	@PackagingPrice decimal(9,2),
	@PackagingKey bigint)
AS

/*
Packaging price value is copied to all locations
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	UPDATE
		dbo.tblCPais_LocationPackaging
	SET
		decLocationPackagingPrice = @PackagingPrice
	WHERE
		(lngPackagingId = @PackagingKey)

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CopyPackagingToAllLocations]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CopyPackagingToAllLocations] 
	(
	@PackagingPrice decimal(9,2),
	@PackagingKey bigint)
AS

/*
Packaging is added to all locations (if not already done)
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	SET NOCOUNT ON;

	INSERT INTO tblCPais_LocationPackaging
		SELECT
			lngIdLocation,
			@PackagingKey,
			@PackagingPrice
		FROM
			dbo.tblCPais_Location WITH (ReadPast)
		WHERE
			lngIdLocation NOT IN
				(
				SELECT
					lngLocationId
				FROM
					dbo.tblCPais_LocationPackaging WITH (ReadPast)
				WHERE
					(lngPackagingId = @PackagingKey))
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_CopyProductPricesToAllLocations]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CopyProductPricesToAllLocations]
	(
	@ProductPrice decimal(9,2),
	@ProductKey bigint)
AS

/*
Extra Cost value is copied to all locations
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	UPDATE
		dbo.tblCPais_LocationProduct
	SET
		decLocationProductPrice = @ProductPrice
	WHERE
		(lngProductId = @ProductKey)

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_CopyProductToAllLocations]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_CopyProductToAllLocations] 
	(
	@ProductPrice decimal(9,2),
	@ProductKey bigint)
AS

/*
Product is added to all locations (if not already done)
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	SET NOCOUNT ON;

	INSERT INTO tblCPais_LocationProduct
		SELECT
			lngIdLocation,
			@ProductKey,
			@ProductPrice
		FROM
			dbo.tblCPais_Location WITH (ReadPast)
		WHERE
			lngIdLocation NOT IN
				(
				SELECT
					lngLocationId
				FROM
					dbo.tblCPais_LocationProduct WITH (ReadPast)
				WHERE
					(lngProductId = @ProductKey))
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_DeleteCompositionResult]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_DeleteCompositionResult] 
	(
	@lngIdComposition bigint)
AS

/*
Delete composition result
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	DELETE
	FROM
		dbo.tblCPais_CompositionResult
	WHERE
		lngCompositionId = @lngIdComposition

	COMMIT TRANSACTION;
END


GO
/****** Object:  StoredProcedure [dbo].[spCPais_ExtraCost]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_ExtraCost] 
AS

/*
List of extra cost
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdExtraCost,
		strExtraCostDescription,
		strExtraCostReport,
		decExtraCostPrice
	FROM
		dbo.tblCPais_ExtraCost WITH (ReadPast)
	ORDER BY
		strExtraCostDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_ExtraCostForLocation]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_ExtraCostForLocation]
	(
	@Location bigint)
AS

/*
List of extra costs for a specific location
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		0 as blnChoosen,
		dbo.tblCPais_ExtraCost.lngIdExtraCost,
		dbo.tblCPais_ExtraCost.strExtraCostDescription, 
		dbo.tblCPais_ExtraCost.strExtraCostReport, 
		dbo.tblCPais_ExtraCost.decExtraCostPrice 
	FROM
		dbo.tblCPais_LocationExtraCost WITH (ReadPast) INNER JOIN
		dbo.tblCPais_ExtraCost WITH (ReadPast) ON dbo.tblCPais_LocationExtraCost.lngExtraCostId = dbo.tblCPais_ExtraCost.lngIdExtraCost
	WHERE
		dbo.tblCPais_LocationExtraCost.lngLocationId = @Location

END


GO
/****** Object:  StoredProcedure [dbo].[spCPais_FindLargestNumberForPrefix]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_FindLargestNumberForPrefix]
	(
	@Prefix nvarchar(50),
	@CompositionNumber bigint OUTPUT)
AS

/*
Find the largest number for a specific prefix
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Called by
	-- spCPais_InsertComposition(String, BigInt, BigInt, BigInt, BigInt, BigInt, BigInt, BigInt, BigInt)

*/

BEGIN

	SET NOCOUNT ON;
	SELECT TOP 1
		@CompositionNumber = lngCompositionNumber
	FROM
		dbo.tblCPais_Composition WITH (ReadPast)
	WHERE
		(strCompositionDescription LIKE @Prefix+'%')
	ORDER BY lngCompositionNumber DESC

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_InsertComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_InsertComposition]
	(
	@Prefix nvarchar(50),
	@CompositionType bigint,
	@Location bigint,
	@Nutrient01 bigint,
	@Nutrient02 bigint,
	@Nutrient03 bigint,
	@Nutrient04 bigint,
	@Nutrient05 bigint,
	@Comment nvarchar(1000),
	@KeyComposition BigInt OUTPUT)
AS

/*
Insert a compostion into tblCPais_Composition
Remember the key
Add fixed nutrients
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Calls
	-- spCPais_FindLargestNumberForPrefix(String, BigInt)
	-- spCPais_InsertCompositionExercise(BigInt, BigInt)
*/

BEGIN
	BEGIN TRANSACTION;

	DECLARE @Number bigint

	SET NOCOUNT ON;
    EXECUTE spCPais_FindLargestNumberForPrefix @Prefix, @Number OUTPUT

	IF @Number IS NULL
		SET @Number = 1
	ELSE
		SET @Number = @Number + 1

	INSERT INTO tblCPais_Composition
		(
		strCompositionDescription,
		lngCompositionNumber,
		lngCompositionTypeId,
		lngLocationId,
		strCompositionComment)
	VALUES
		(
		@Prefix+' '+CONVERT(nvarchar(10), @Number),
		@Number,
		@CompositionType,
		@Location,
		@Comment)

	SET @KeyComposition = @@Identity

	IF @Nutrient01 <> 0
	    EXECUTE spCPais_InsertCompositionExercise @KeyComposition, @Nutrient01
	
	IF @Nutrient02 <> 0
	    EXECUTE spCPais_InsertCompositionExercise @KeyComposition, @Nutrient02
	
	IF @Nutrient03 <> 0
	    EXECUTE spCPais_InsertCompositionExercise @KeyComposition, @Nutrient03
	
	IF @Nutrient04 <> 0
	    EXECUTE spCPais_InsertCompositionExercise @KeyComposition, @Nutrient04
	
	IF @Nutrient05 <> 0
	    EXECUTE spCPais_InsertCompositionExercise @KeyComposition, @Nutrient05
	
	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_InsertCompositionExercise]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_InsertCompositionExercise]
	(
	@Composition bigint,
	@Nutrient bigint)
AS

/*
Insert a composition exercise into tblCPais_CompositionExercise
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Called by
	-- spCPais_InsertComposition(String, BigInt, BigInt, BigInt, BigInt, BigInt, BigInt, BigInt, BigInt)
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	INSERT INTO tblCPais_CompositionExercise
		(
		lngCompositionId,
		lngNutrientId)
	VALUES
		(
		@Composition,
		@Nutrient)

	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_InsertCompositionResult]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_InsertCompositionResult]
	(
	@Composition bigint,
	@Product bigint,
	@ResultWeight decimal(30,10))
AS

/*
Insert a composition result into tblCPais_CompositionResult
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	INSERT INTO tblCPais_CompositionResult
		(
		lngCompositionId,
		lngProductId,
		decCompositionResultWeight)
	VALUES
		(
		@Composition,
		@Product,
		@ResultWeight)

	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_Location]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_Location] 
AS

/*
List of location
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdLocation,
		strLocationDescription,
		strLocationStreetNumber,
		strLocationZipCode,
		strLocationCity,
		strLocationPhone,
		strLocationFax, 
		lngMaximumBlendRun
	FROM
		dbo.tblCPais_Location WITH (ReadPast)
	ORDER BY
		strLocationDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_LocationCurrent]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_LocationCurrent] 
	(
	@LocationKey bigint)
AS

/*
Location that is actually choosen
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdLocation,
		strLocationDescription,
		strLocationStreetNumber,
		strLocationZipCode,
		strLocationCity,
		strLocationPhone,
		strLocationFax, 
		lngMaximumBlendRun
	FROM
		dbo.tblCPais_Location WITH (ReadPast)
	WHERE
		lngIdLocation = @LocationKey

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_LocationProduct]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_LocationProduct] 
	(
	@Location bigint)
AS

/*
List of products for a specific location
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_LocationProduct.*
	FROM
		dbo.tblCPais_LocationProduct WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_LocationProduct.lngProductId = dbo.tblCPais_Product.lngIdProduct
	WHERE
		dbo.tblCPais_LocationProduct.lngLocationId = @Location
	ORDER BY
		dbo.tblCPais_Product.strProductDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_MineralsDelivered]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_MineralsDelivered]
	(
	@Composition bigint,
	@Location bigint,
	@FixedNutrient01 bigint,
	@FixedNutrient02 bigint,
	@FixedNutrient03 bigint,
	@FixedNutrient04 bigint,
	@FixedNutrient05 bigint,
	@CaliumPoor bigint,
	@Magnesium bigint,
	@Chlorine bigint,
	@Sodium bigint,
	@Sulphur bigint)
AS

/*
Info for printing an order
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

DECLARE @Nutrient01 bigint
DECLARE @Nutrient02 bigint
DECLARE @Nutrient03 bigint
DECLARE @Nutrient04 bigint
DECLARE @Nutrient05 bigint

IF @FixedNutrient01 IS Null
	BEGIN
		SET @Nutrient01 = 0
	END
ELSE
	BEGIN
		SET @Nutrient01 = @FixedNutrient01
	END

IF @FixedNutrient02 IS Null
	BEGIN
		SET @Nutrient02 = 0
	END
ELSE
	BEGIN
		SET @Nutrient02 = @FixedNutrient02
	END

IF @FixedNutrient03 IS Null
	BEGIN
		SET @Nutrient03 = 0
	END
ELSE
	BEGIN
		SET @Nutrient03 = @FixedNutrient03
	END

IF @FixedNutrient04 IS Null
	BEGIN
		SET @Nutrient04 = 0
	END
ELSE
	BEGIN
		SET @Nutrient04 = @FixedNutrient04
	END

IF @FixedNutrient05 IS Null
	BEGIN
		SET @Nutrient05 = 0
	END
ELSE
	BEGIN
		SET @Nutrient05 = @FixedNutrient05
	END

IF @CaliumPoor IS Null
	BEGIN
		SET @CaliumPoor = 0
	END

IF @Chlorine IS Null
	BEGIN
		SET @Chlorine = 0
	END

IF @Magnesium IS Null
	BEGIN
		SET @Magnesium = 0
	END

IF @Sodium IS Null
	BEGIN
		SET @Sodium = 0
	END

IF @Sulphur IS Null
	BEGIN
		SET @Sulphur = 0
	END

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Composition.lngIdComposition,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight,
		dbo.tblCPais_Composition.decHectare,
		dbo.tblCPais_Composition.decOrderWeight,
		dbo.tblCPais_Composition.decHectare * SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS TotalWeightHa,
		dbo.tblCPais_Composition.decOrderWeight * SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) / 100 AS TotalWeight100Kg
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Composition WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngCompositionId = dbo.tblCPais_Composition.lngIdComposition INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_Composition.lngIdComposition,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		dbo.tblCPais_Composition.decHectare,
		dbo.tblCPais_Composition.decOrderWeight
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_Composition.lngIdComposition = @Composition) AND
			(
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient01 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient02 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient03 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient04 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient05 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @CaliumPoor OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Magnesium OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Chlorine OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Sodium OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Sulphur)

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_Nutrient]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_Nutrient] 
AS

/*
List of nutrient
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdNutrient,
		strNutrientDescription,
		blnNutrientExerciseValue
	FROM
		dbo.tblCPais_Nutrient WITH (ReadPast)
	ORDER BY
		strNutrientDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_NutrientExercise]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_NutrientExercise] 
AS

/*
List of nutrient
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdNutrient,
		strNutrientDescription,
		blnNutrientExerciseValue
	FROM
		dbo.tblCPais_Nutrient WITH (ReadPast)
	WHERE
		blnNutrientExerciseValue = 1
	ORDER BY
		strNutrientDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_NutrientForProduct]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_NutrientForProduct]
	(
	@Product bigint)

AS

/*
List of nutrients for specific product
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_ProductNutrient.lngIdProductNutrient,
		dbo.tblCPais_ProductNutrient.lngProductId,
		dbo.tblCPais_ProductNutrient.lngNutrientId,
		dbo.tblCPais_ProductNutrient.decNutrientValue
	FROM
		dbo.tblCPais_ProductNutrient WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	WHERE
		lngProductId = @Product
	ORDER BY
		dbo.tblCPais_Nutrient.strNutrientDescription

END


GO
/****** Object:  StoredProcedure [dbo].[spCPais_Packaging]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_Packaging] 
AS

/*
List of packaging
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdPackaging,
		strPackagingDescription,
		decPackagingPrice
	FROM
		dbo.tblCPais_Packaging WITH (ReadPast)
	ORDER BY
		strPackagingDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_PackagingForLocation]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_PackagingForLocation]
	(
	@Location bigint)
AS

/*
List of packaging for a specific location
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Packaging.lngIdPackaging,
		dbo.tblCPais_Packaging.strPackagingDescription, 
		dbo.tblCPais_Packaging.decPackagingPrice
	FROM
		dbo.tblCPais_LocationPackaging WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Packaging WITH (ReadPast) ON dbo.tblCPais_LocationPackaging.lngPackagingId = dbo.tblCPais_Packaging.lngIdPackaging
	WHERE
		dbo.tblCPais_LocationPackaging.lngLocationId = @Location

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_Product]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_Product] 
AS

/*
List of product
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT 
		lngIdProduct,
		strProductDescription,
		decProductDefaultPrice
	FROM
		dbo.tblCPais_Product WITH (ReadPast)
	WHERE
		lngIdProduct <> 0
	ORDER BY
		strProductDescription

END



GO
/****** Object:  StoredProcedure [dbo].[spCPais_ProductForNutrient]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_ProductForNutrient]
	(
	@Nutrient bigint)

AS

/*
List of products for specific nutrient
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_ProductNutrient.lngIdProductNutrient,
		dbo.tblCPais_ProductNutrient.lngProductId,
		dbo.tblCPais_ProductNutrient.lngNutrientId,
		dbo.tblCPais_ProductNutrient.decNutrientValue
	FROM
		dbo.tblCPais_ProductNutrient WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngProductId = dbo.tblCPais_Product.lngIdProduct
	WHERE
		lngNutrientId = @Nutrient
	ORDER BY
		dbo.tblCPais_Product.strProductDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptCaliumLetter]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptCaliumLetter]
	(
	@Location bigint,
	@lngCompositionId bigint,
	@CaliumPoor bigint)
AS

/*
Basic calium nutrient values of an order letter
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
 		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @lngCompositionId) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @CaliumPoor) AND
		(dbo.tblCPais_Nutrient.strNutrientDescription LIKE '%Kalium ch%')

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptCaliumPoorLetter]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptCaliumPoorLetter]
	(
	@Location bigint,
	@lngCompositionId bigint,
	@FixedNutrient03 bigint)
AS

/*
Basic calium poor nutrient values of an order letter
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
 		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @lngCompositionId) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @FixedNutrient03) AND
		(dbo.tblCPais_Nutrient.strNutrientDescription LIKE '%Kalium ca%')

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptCompositionExerciseForComposition]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptCompositionExerciseForComposition]
	(
	@lngIdComposition bigint)
AS

/*
List of nutrients and mimimum and maximum values for a specific composition
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_CompositionExercise.*,
		dbo.tblCPais_Nutrient.strNutrientDescription
	FROM
		dbo.tblCPais_CompositionExercise WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_CompositionExercise.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	WHERE
		lngCompositionId = @lngIdComposition

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptExcel]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptExcel]
	(
	@Location bigint)
AS

/*
List of client
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Client.strClientName AS klant,
		CONVERT(DATETIME,
			CONVERT(VARCHAR(4), YEAR(dbo.tblCPais_Composition.dtmComposition)) + '/' +
			CONVERT(VARCHAR(2), MONTH(dbo.tblCPais_Composition.dtmComposition)) + '/' + 
			CONVERT(VARCHAR(2), DAY(dbo.tblCPais_Composition.dtmComposition))) AS [Offerte datum],
		dbo.tblCPais_Composition.strCompositionDescription AS Samenstelling,
		dbo.tblCPais_Location.strLocationDescription AS Location,
		12.5 + 1000 / SUM(dbo.tblCPais_CompositionResult.decCompositionResultWeight)
			* SUM(dbo.tblCPais_LocationProduct.decLocationProductPrice * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 1000) AS [Bedrag per ton]
	FROM
		dbo.tblCPais_LocationProduct WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_LocationProduct.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_Client WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Composition WITH (ReadPast) ON dbo.tblCPais_Client.lngIdClient = dbo.tblCPais_Composition.lngClientId INNER JOIN
		dbo.tblCPais_CompositionResult WITH (ReadPast) ON dbo.tblCPais_Composition.lngIdComposition = dbo.tblCPais_CompositionResult.lngCompositionId ON 
		dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_CompositionResult.lngProductId INNER JOIN
		dbo.tblCPais_Location WITH (ReadPast) ON dbo.tblCPais_LocationProduct.lngLocationId = dbo.tblCPais_Location.lngIdLocation AND dbo.tblCPais_Composition.lngLocationId = dbo.tblCPais_Location.lngIdLocation
	GROUP BY
		dbo.tblCPais_Composition.lngIdComposition,
		dbo.tblCPais_Composition.lngCompositionNumber, 
		dbo.tblCPais_Composition.strCompositionDescription,
		dbo.tblCPais_Composition.dtmComposition,
		dbo.tblCPais_Composition.lngLocationId,
		dbo.tblCPais_Location.strLocationDescription,
		dbo.tblCPais_Composition.decHectare,
		dbo.tblCPais_Client.strClientName
	-- HAVING
	--	dbo.tblCPais_Composition.lngLocationId = @Location
	ORDER BY
		dbo.tblCPais_Composition.lngCompositionNumber DESC,
		dbo.tblCPais_Composition.strCompositionDescription DESC

END




GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptExcelOriginal]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptExcelOriginal]
	(
	@Location bigint)
AS

/*
List of client
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Client.strClientName AS klant,
		CONVERT(DATETIME, CONVERT(VARCHAR(4), YEAR(dbo.tblCPais_Composition.dtmComposition)) + '/' +
                CONVERT(VARCHAR(4), MONTH(dbo.tblCPais_Composition.dtmComposition)) + '/' +
                CONVERT(VARCHAR(4), DAY(dbo.tblCPais_Composition.dtmComposition))) AS [Offerte datum],
		dbo.tblCPais_Composition.strCompositionDescription AS Samenstelling,
		12.5 + (1000 / SUM(dbo.tblCPais_CompositionResult.decCompositionResultWeight) * SUM(dbo.tblCPais_LocationProduct.decLocationProductPrice * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 1000)) AS [Bedrag per ton]
	FROM
		dbo.tblCPais_LocationProduct WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_LocationProduct.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_Client WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Composition WITH (ReadPast) ON dbo.tblCPais_Client.lngIdClient = dbo.tblCPais_Composition.lngClientId INNER JOIN
		dbo.tblCPais_CompositionResult WITH (ReadPast) ON dbo.tblCPais_Composition.lngIdComposition = dbo.tblCPais_CompositionResult.lngCompositionId ON 
		dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_CompositionResult.lngProductId
	GROUP BY
		dbo.tblCPais_Composition.dtmComposition,
		dbo.tblCPais_Composition.lngIdComposition,
		dbo.tblCPais_Composition.strCompositionDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		dbo.tblCPais_Composition.decHectare,
		dbo.tblCPais_Client.strClientName
	HAVING
		dbo.tblCPais_LocationProduct.lngLocationId = @Location
	ORDER BY
		dbo.tblCPais_Composition.lngIdComposition DESC
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptExtraNutrientLetter]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptExtraNutrientLetter]
	(
	@Location bigint,
	@lngIdComposition bigint,
	@FixedNutrient01 bigint,
	@FixedNutrient02 bigint,
	@FixedNutrient03 bigint,
	@FixedNutrient04 bigint,
	@FixedNutrient05 bigint,
	@CaliumPoor bigint)
AS

/*
Extra nutrient values of an order letter
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

DECLARE @Nutrient01 bigint
DECLARE @Nutrient02 bigint
DECLARE @Nutrient03 bigint
DECLARE @Nutrient04 bigint
DECLARE @Nutrient05 bigint

IF @FixedNutrient01 IS Null
	BEGIN
		SET @Nutrient01 = 0
	END
ELSE
	BEGIN
		SET @Nutrient01 = @FixedNutrient01
	END

IF @FixedNutrient02 IS Null
	BEGIN
		SET @Nutrient02 = 0
	END
ELSE
	BEGIN
		SET @Nutrient02 = @FixedNutrient02
	END

IF @FixedNutrient03 IS Null
	BEGIN
		SET @Nutrient03 = 0
	END
ELSE
	BEGIN
		SET @Nutrient03 = @FixedNutrient03
	END

IF @FixedNutrient04 IS Null
	BEGIN
		SET @Nutrient04 = 0
	END
ELSE
	BEGIN
		SET @Nutrient04 = @FixedNutrient04
	END

IF @FixedNutrient05 IS Null
	BEGIN
		SET @Nutrient05 = 0
	END
ELSE
	BEGIN
		SET @Nutrient05 = @FixedNutrient05
	END

IF @CaliumPoor IS Null
	BEGIN
		SET @CaliumPoor = 0
	END

BEGIN

	SET NOCOUNT ON;
	SELECT
 		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId as Location,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight,
		@Nutrient01 as FixedNutrient01,
		@Nutrient02 as FixedNutrient02,
		@Nutrient03 as FixedNutrient03,
		@Nutrient04 as FixedNutrient04,
		@Nutrient05 as FixedNutrient05,
		@CaliumPoor as CaliumPoor
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @lngIdComposition) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @Nutrient01) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @Nutrient02) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @Nutrient03) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @Nutrient04) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @Nutrient05) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @CaliumPoor) AND
		(dbo.tblCPais_Nutrient.strNutrientDescription NOT LIKE '%stikstof%') AND
		(dbo.tblCPais_Nutrient.strNutrientDescription NOT LIKE '%P2O5%') AND
		(dbo.tblCPais_Nutrient.strNutrientDescription NOT LIKE '%Kalium%') AND
		(dbo.tblCPais_Nutrient.strNutrientDescription NOT LIKE '%zbw%') AND
		(dbo.tblCPais_Nutrient.strNutrientDescription NOT LIKE '%Chloor%') AND
		(dbo.tblCPais_Nutrient.strNutrientDescription NOT LIKE '%gedw%')
	
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptNitrogenLetter]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptNitrogenLetter]
	(
	@Location bigint,
	@lngCompositionId bigint,
	@FixedNutrient01 bigint)
AS

/*
Basic nitrogen nutrient values of an order letter
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
 		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @lngCompositionId) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @FixedNutrient01) AND
		(dbo.tblCPais_Nutrient.strNutrientDescription LIKE '%stikstof%')

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptNutrientLetter]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptNutrientLetter]
	(
	@Location bigint,
	@lngIdComposition bigint,
	@FixedNutrient01 bigint,
	@FixedNutrient02 bigint,
	@FixedNutrient03 bigint,
	@FixedNutrient04 bigint,
	@FixedNutrient05 bigint,
	@CaliumPoor bigint)
AS

/*
Basic nutrient values of an order letter
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

DECLARE @Nutrient01 bigint
DECLARE @Nutrient02 bigint
DECLARE @Nutrient03 bigint
DECLARE @Nutrient04 bigint
DECLARE @Nutrient05 bigint

IF @FixedNutrient01 IS Null
	BEGIN
		SET @Nutrient01 = 0
	END
ELSE
	BEGIN
		SET @Nutrient01 = @FixedNutrient01
	END

IF @FixedNutrient02 IS Null
	BEGIN
		SET @Nutrient02 = 0
	END
ELSE
	BEGIN
		SET @Nutrient02 = @FixedNutrient02
	END

IF @FixedNutrient03 IS Null
	BEGIN
		SET @Nutrient03 = 0
	END
ELSE
	BEGIN
		SET @Nutrient03 = @FixedNutrient03
	END

IF @FixedNutrient04 IS Null
	BEGIN
		SET @Nutrient04 = 0
	END
ELSE
	BEGIN
		SET @Nutrient04 = @FixedNutrient04
	END

IF @FixedNutrient05 IS Null
	BEGIN
		SET @Nutrient05 = 0
	END
ELSE
	BEGIN
		SET @Nutrient05 = @FixedNutrient05
	END

IF @CaliumPoor IS Null
	BEGIN
		SET @CaliumPoor = 0
	END

BEGIN

	SET NOCOUNT ON;
	SELECT
 		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId as Location,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight,
		@Nutrient01 as FixedNutrient01,
		@Nutrient02 as FixedNutrient02,
		@Nutrient03 as FixedNutrient03,
		@Nutrient04 as FixedNutrient04,
		@Nutrient05 as FixedNutrient05,
		@CaliumPoor as CaliumPoor
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @lngIdComposition) AND
			(
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient01 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient02 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient03 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient04 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @Nutrient05 OR
			dbo.tblCPais_Nutrient.lngIdNutrient = @CaliumPoor) 

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptOrderBlend]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptOrderBlend]
	(
	@Composition bigint,
	@Location bigint,
	@FixedNutrient01 bigint,
	@FixedNutrient02 bigint,
	@FixedNutrient03 bigint,
	@FixedNutrient04 bigint,
	@FixedNutrient05 bigint,
	@CaliumPoor bigint)
AS

/*
Info for printing an order
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

DECLARE @Nutrient01 bigint
DECLARE @Nutrient02 bigint
DECLARE @Nutrient03 bigint
DECLARE @Nutrient04 bigint
DECLARE @Nutrient05 bigint

IF @FixedNutrient01 IS Null
	BEGIN
		SET @Nutrient01 = 0
	END
ELSE
	BEGIN
		SET @Nutrient01 = @FixedNutrient01
	END

IF @FixedNutrient02 IS Null
	BEGIN
		SET @Nutrient02 = 0
	END
ELSE
	BEGIN
		SET @Nutrient02 = @FixedNutrient02
	END

IF @FixedNutrient03 IS Null
	BEGIN
		SET @Nutrient03 = 0
	END
ELSE
	BEGIN
		SET @Nutrient03 = @FixedNutrient03
	END

IF @FixedNutrient04 IS Null
	BEGIN
		SET @Nutrient04 = 0
	END
ELSE
	BEGIN
		SET @Nutrient04 = @FixedNutrient04
	END

IF @FixedNutrient05 IS Null
	BEGIN
		SET @Nutrient05 = 0
	END
ELSE
	BEGIN
		SET @Nutrient05 = @FixedNutrient05
	END

IF @CaliumPoor IS Null
	BEGIN
		SET @CaliumPoor = 0
	END

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Composition.lngIdComposition,
		dbo.tblCPais_Composition.strCompositionDescription,
		dbo.tblCPais_Composition.dtmComposition,
		@Location as Location,
		dbo.tblCPais_Location.strLocationDescription,
		dbo.tblCPais_Location.strLocationStreetNumber,
		dbo.tblCPais_Location.strLocationZipCode,
		dbo.tblCPais_Location.strLocationCity,
		dbo.tblCPais_Location.strLocationPhone,
		dbo.tblCPais_Location.strLocationFax,
		dbo.tblCPais_Location.lngMaximumBlendRun,
		dbo.tblCPais_Composition.decOrderWeight,
		dbo.tblCPais_Composition.decHectare,
		dbo.tblCPais_Composition.strCompositionComment,
		dbo.tblCPais_Composition.strPlot,
		dbo.tblCPais_Composition.strPlant,
		dbo.tblCPais_Client.strClientName,
		dbo.tblCPais_ContactPerson.strContactPersonName,
		dbo.tblCPais_Client.strClientStreetNumber,
		dbo.tblCPais_Client.strClientZipCode,
		dbo.tblCPais_Client.strClientCity,
		dbo.tblCPais_Client.strClientPhone,
		dbo.tblCPais_Client.strClientFax,
		@Nutrient01 as FixedNutrient01,
		@Nutrient02 as FixedNutrient02,
		@Nutrient03 as FixedNutrient03,
		@Nutrient04 as FixedNutrient04,
		@Nutrient05 as FixedNutrient05,
		@CaliumPoor as CaliumPoor
	FROM
		dbo.tblCPais_Composition WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Location WITH (ReadPast) ON dbo.tblCPais_Composition.lngLocationId = dbo.tblCPais_Location.lngIdLocation LEFT OUTER JOIN
		dbo.tblCPais_ContactPerson WITH (ReadPast) ON dbo.tblCPais_Composition.lngContactPersonId = dbo.tblCPais_ContactPerson.lngIdContactPerson LEFT OUTER JOIN
		dbo.tblCPais_Client WITH (ReadPast) ON dbo.tblCPais_Composition.lngClientId = dbo.tblCPais_Client.lngIdClient
	WHERE
		dbo.tblCPais_Composition.lngIdComposition = @Composition

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptPhosphateLetter]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptPhosphateLetter]
	(
	@Location bigint,
	@lngCompositionId bigint,
	@FixedNutrient02 bigint)
AS

/*
Basic phosphate nutrient values of an order letter
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
 		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId,
		SUM(dbo.tblCPais_ProductNutrient.decNutrientValue * dbo.tblCPais_CompositionResult.decCompositionResultWeight / 100) AS Weight
	FROM
		dbo.tblCPais_CompositionResult WITH (ReadPast) INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_CompositionResult.lngProductId = dbo.tblCPais_Product.lngIdProduct INNER JOIN
		dbo.tblCPais_LocationProduct WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_LocationProduct.lngProductId INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Product.lngIdProduct = dbo.tblCPais_ProductNutrient.lngProductId INNER JOIN
		dbo.tblCPais_Nutrient WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngNutrientId = dbo.tblCPais_Nutrient.lngIdNutrient
	GROUP BY
		dbo.tblCPais_CompositionResult.lngCompositionId,
		dbo.tblCPais_Nutrient.lngIdNutrient,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_LocationProduct.lngLocationId
	HAVING
		(dbo.tblCPais_LocationProduct.lngLocationId = @Location) AND
		(dbo.tblCPais_CompositionResult.lngCompositionId = @lngCompositionId) AND
		(dbo.tblCPais_Nutrient.lngIdNutrient <> @FixedNutrient02) AND
		(dbo.tblCPais_Nutrient.strNutrientDescription LIKE '%P2O5%')

END

GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptProduct]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptProduct] 
AS

/*
List of products
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	
	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Product.strProductDescription,
		dbo.tblCPais_Product.decProductDefaultPrice
	FROM
		dbo.tblCPais_Product WITH (ReadPast)
	ORDER BY
		dbo.tblCPais_Product.strProductDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_rptProductNutrient]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_rptProductNutrient] 
AS

/*
List of product with nutrient
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN
	
	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_Product.strProductDescription,
		dbo.tblCPais_Nutrient.strNutrientDescription,
		dbo.tblCPais_ProductNutrient.decNutrientValue, 
		dbo.tblCPais_Product.decProductDefaultPrice
	FROM
		dbo.tblCPais_Nutrient WITH (ReadPast) INNER JOIN
		dbo.tblCPais_ProductNutrient WITH (ReadPast) ON dbo.tblCPais_Nutrient.lngIdNutrient = dbo.tblCPais_ProductNutrient.lngNutrientId INNER JOIN
		dbo.tblCPais_Product WITH (ReadPast) ON dbo.tblCPais_ProductNutrient.lngProductId = dbo.tblCPais_Product.lngIdProduct

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysCheckPermission]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysCheckPermission]
	(
	@ObjectName nvarchar(100))
AS

/*
Check the permission of a specific object
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT permissions(Object_id(@objectname)) AS PermissionCode

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysFindConfigurationItem]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysFindConfigurationItem]
	(
	@Project nvarchar(50),
	@ConfigurationItem nvarchar(50),
	@User nvarchar(50))
AS

/*
Find a configuration item for a specific project with a specific name
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_sysProject.strProject,
		dbo.tblCPais_sysConfigurationItem.strConfigurationItem,
		dbo.tblCPais_sysConfigurationItem.strValue
	FROM
		dbo.tblCPais_sysConfigurationItem WITH (ReadPast) INNER JOIN
		dbo.tblCPais_sysProject WITH (ReadPast) ON dbo.tblCPais_sysConfigurationItem.lngProjectId = dbo.tblCPais_sysProject.lngIdProject
	WHERE
		(dbo.tblCPais_sysProject.strProject = @Project) AND 
		(dbo.tblCPais_sysConfigurationItem.strConfigurationItem = @ConfigurationItem) AND
		(dbo.tblCPais_sysConfigurationItem.strUser = @User) 

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysFindConfigurationItemWithProjectAndName]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysFindConfigurationItemWithProjectAndName]
	(
	@Project BigInt,
	@ConfigurationItem nvarchar(50),
	@User nvarchar(50),
	@KeyConfigurationItem BigInt OUTPUT)
AS

/*
Find a project in tblCPais_sysProject with description
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Called by
	-- spCPais_sysInsertConfigurationItem(BigInt, String, String, String, BigInt)
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		@KeyConfigurationItem = lngIdConfigurationItem
	FROM
		tblCPais_sysConfigurationItem WITH (ReadPast)
	WHERE
		(lngProjectId = @Project) AND
		(strUser = @User) AND	
		(strConfigurationItem = @ConfigurationItem)

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysFindProjectWithDescription]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysFindProjectWithDescription]
	(
	@Description nvarchar(50),
	@KeyProject BigInt OUTPUT)
AS

/*
Find a project in tblCPais_sysProject with description
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Called by
	-- spCPais_sysInsertProject(String, BigInt)
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		@KeyProject = lngIdProject
	FROM
		tblCPais_sysProject WITH (ReadPast)
	WHERE
		strProject = @Description

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysFindRibbon]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spCPais_sysFindRibbon]
	(
	@Ribbon nvarchar(50),
	@Project nvarchar(50))
AS

/*
Find a ribbon for a specific project with a specific name
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_sysRibbon.xmlRibbon
	FROM
		dbo.tblCPais_sysRibbon WITH (ReadPast) INNER JOIN
		dbo.tblCPais_sysProject WITH (ReadPast) ON dbo.tblCPais_sysRibbon.lngProjectId = dbo.tblCPais_sysProject.lngIdProject 
	WHERE
		(dbo.tblCPais_sysProject.strProject = @Project) AND 
		(dbo.tblCPais_sysRibbon.strRibbonName = @Ribbon) 

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysInsertConfigurationItem]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysInsertConfigurationItem]
	(
	@Project BigInt,
	@ConfigurationItem nVarChar(50),
	@User nVarChar(50),
	@Value nVarChar(100),
	@KeyConfigurationItem BigInt OUTPUT)
AS

/*
Insert a configurationItem into tblCPais_sysConfigurationItem
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Calls
	-- spCPais_sysFindConfigurationItemWithProjectAndName(BigInt, String, String, BigInt)
	-- spCPais_sysUpdateConfigurationItem(BigInt, String, String)
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	EXECUTE spCPais_sysFindConfigurationItemWithProjectAndName @Project, @ConfigurationItem, @User, @KeyConfigurationItem = @KeyConfigurationItem OUTPUT

	If @KeyConfigurationItem IS Null
	BEGIN

		INSERT INTO tblCPais_sysConfigurationItem
			(
			lngProjectId,
			strConfigurationItem,
			strUser,
			strValue)
		VALUES
			(
			@Project,
			@ConfigurationItem,
			@User,
			@Value)

		SET @KeyConfigurationItem = @@Identity
	END
	ELSE
	BEGIN
		 EXECUTE spCPais_sysUpdateConfigurationItem @KeyConfigurationItem, @Value
	END

	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysInsertProject]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_sysInsertProject]
	(
	@Description nVarChar(50),
	@KeyProject BigInt OUTPUT)
AS

/*
Insert a project into tblVdWProject
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Calls
	-- spCPais_sysFindProjectWithDescription(String, BigInt)
	-- spCPais_sysUpdateProject(BigInt, String)
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	EXECUTE spCPais_sysFindProjectWithDescription @Description, @KeyProject = @KeyProject OUTPUT

	IF @KeyProject IS Null
	BEGIN

		INSERT INTO tblCPais_sysProject
			(
			strProject)
		VALUES
			(
			@Description)
		
		SET @KeyProject = @@Identity

	END
	BEGIN
		EXECUTE spCPais_sysUpdateProject @KeyProject, @Description
	END

	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysTable]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCPais_sysTable]
	(
	@Project nvarchar(50))
AS

/*
Find tablelist of a specific project
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		dbo.tblCPais_sysTable.strInputTableTab,
		dbo.tblCPais_sysTable.strInputTableDescription,
		dbo.tblCPais_sysProject.strProject
	FROM
		dbo.tblCPais_sysProject WITH (ReadPast) INNER JOIN
		dbo.tblCPais_sysTable WITH (ReadPast) ON dbo.tblCPais_sysProject.lngIdProject = dbo.tblCPais_sysTable.lngProjectId
	WHERE
		(dbo.tblCPais_sysProject.strProject = @Project)
	ORDER BY
		dbo.tblCPais_sysTable.strInputTableDescription

END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysUpdateConfigurationItem]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysUpdateConfigurationItem]
	(
	@KeyConfigurationItem BigInt,
	@Value nVarChar(100))
AS

/*
Update a ConfigurationItem into tblCPais_sysConfigurationItem
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Called by
	-- spCPais_sysInsertConfigurationItem(BigInt, String, String, String, BigInt)
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	UPDATE
		tblCPais_sysConfigurationItem
	SET
		strValue = @Value
	WHERE
		(lngIdConfigurationItem = @KeyConfigurationItem) AND
		(strValue <> @Value)

	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysUpdateProject]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysUpdateProject]
	(
	@KeyProject BigInt,
	@Description nVarChar(50))
AS

/*
Update a project into tblVdWsysProject
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
-- Called by
	-- spCPais_sysInsertProject(String, BigInt)
*/

BEGIN
	BEGIN TRANSACTION;

	SET NOCOUNT ON;
	UPDATE
		tblCPais_sysProject
	SET
		strProject = @Description
	WHERE
		(lngIdProject = @KeyProject) AND
		(strProject <> @Description)

	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spCPais_sysUser]    Script Date: 08/12/2021 12:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCPais_sysUser]
	(
	@Name nvarchar(128))
AS

/*
Find a user key of a specific name
-- VVDW - Version 1.0
-- Used in
	-- Blend Calculation
*/

BEGIN

	SET NOCOUNT ON;
	SELECT
		uid
	FROM
		dbo.sysUsers WITH (ReadPast)
	WHERE
		name = @Name

END
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calculate'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFile', @value=N'clsCPaisStoredProcedure.vb' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calculate'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFileLine', @value=9 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calculate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'[spCPais_CompositionNutrientResultForComposition].[strNutrientDescription]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionNutrientResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionProductResultCountForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_CompositionResultForComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_rptProductNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spCPais_sysFindConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'BlendCalculationTable'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFile', @value=N'clsCPaisUserDefinedFunction.vb' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'BlendCalculationTable'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFileLine', @value=14 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'BlendCalculationTable'
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'ASSEMBLY',@level0name=N'BlendCalculation'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyProjectRoot', @value=N'D:\Clients\Triferto\BlendProgramma\User Defined Function\BlendCalculation\BlendCalculation' , @level0type=N'ASSEMBLY',@level0name=N'BlendCalculation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'lngIdClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'lngIdClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'lngIdClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'lngIdClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'lngIdClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client', @level2type=N'COLUMN',@level2name=N'strClientEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngIdComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngIdComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngIdComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngIdComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngIdComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strCompositionComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decOrderWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decOrderWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decOrderWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decOrderWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decOrderWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decHectare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decHectare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decHectare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decHectare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'decHectare'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'dtmComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'dtmComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'dtmComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'dtmComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'dtmComposition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngCompositionTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngCompositionTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngCompositionTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngCompositionTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngCompositionTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngClientId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngClientId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngClientId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngClientId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngClientId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngContactPersonId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngContactPersonId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngContactPersonId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngContactPersonId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'lngContactPersonId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlant'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlant'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlant'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlant'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition', @level2type=N'COLUMN',@level2name=N'strPlant'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Composition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngIdCompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngIdCompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngIdCompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngIdCompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngIdCompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngCompositionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngCompositionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngCompositionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngCompositionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngCompositionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngProductId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngProductId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngProductId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngProductId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'lngProductId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'decCompositionResultWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'decCompositionResultWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'decCompositionResultWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=3195 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'decCompositionResultWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult', @level2type=N'COLUMN',@level2name=N'decCompositionResultWeight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_CompositionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'lngIdContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'lngIdContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'lngIdContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'lngIdContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'lngIdContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'strContactPersonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'strContactPersonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'strContactPersonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'strContactPersonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson', @level2type=N'COLUMN',@level2name=N'strContactPersonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'strExtraCostReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'decExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'decExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'decExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'decExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost', @level2type=N'COLUMN',@level2name=N'decExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_ExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngIdLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngIdLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngIdLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngIdLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngIdLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationStreetNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'strLocationFax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngMaximumBlendRun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngMaximumBlendRun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngMaximumBlendRun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngMaximumBlendRun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location', @level2type=N'COLUMN',@level2name=N'lngMaximumBlendRun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdLocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdLocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdLocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdLocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngIdLocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngLocationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngExtraCostId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngExtraCostId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngExtraCostId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1755 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngExtraCostId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'lngExtraCostId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'decLocationExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'decLocationExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'decLocationExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'decLocationExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost', @level2type=N'COLUMN',@level2name=N'decLocationExtraCostPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_LocationExtraCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'lngIdNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'lngIdNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'lngIdNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'lngIdNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'lngIdNutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'strNutrientDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'strNutrientDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'strNutrientDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'strNutrientDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'strNutrientDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'blnNutrientExerciseValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'blnNutrientExerciseValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'blnNutrientExerciseValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'blnNutrientExerciseValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient', @level2type=N'COLUMN',@level2name=N'blnNutrientExerciseValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Nutrient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'lngIdPackaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'lngIdPackaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'lngIdPackaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'lngIdPackaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'lngIdPackaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'strPackagingDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'strPackagingDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'strPackagingDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'strPackagingDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'strPackagingDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'decPackagingPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'decPackagingPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'decPackagingPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'decPackagingPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging', @level2type=N'COLUMN',@level2name=N'decPackagingPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Packaging'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'lngIdProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'lngIdProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'lngIdProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'lngIdProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'lngIdProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'strProductDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'strProductDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'strProductDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'strProductDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'strProductDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'decProductDefaultPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'decProductDefaultPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'decProductDefaultPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'decProductDefaultPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product', @level2type=N'COLUMN',@level2name=N'decProductDefaultPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngIdConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngIdConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngIdConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngIdConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngIdConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2370 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=5025 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem', @level2type=N'COLUMN',@level2name=N'strValue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysConfigurationItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'lngIdProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'lngIdProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'lngIdProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'lngIdProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'lngIdProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'strProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'strProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'strProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'strProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject', @level2type=N'COLUMN',@level2name=N'strProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkChildFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LinkMasterFields', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[None]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysProject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'strRibbonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'strRibbonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'strRibbonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'strRibbonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'strRibbonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'xmlRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'xmlRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'xmlRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=7335 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'xmlRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon', @level2type=N'COLUMN',@level2name=N'xmlRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowHeight', @value=1050 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysRibbon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngIdTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngIdTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngIdTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngIdTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngIdTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableTab'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableTab'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableTab'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableTab'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableTab'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2730 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'strInputTableDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable', @level2type=N'COLUMN',@level2name=N'lngProjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCPais_sysTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[75] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 8
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "sysusers (sys)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 61
               Right = 200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCPais_sysUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCPais_sysUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCPais_sysUser'
GO
USE [master]
GO
ALTER DATABASE [Blend] SET  READ_WRITE 
GO
