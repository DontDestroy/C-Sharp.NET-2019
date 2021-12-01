USE [master]
GO
/****** Object:  Database [cpBeerAndUser]    Script Date: 23/11/2021 12:26:26 ******/
CREATE DATABASE [cpBeerAndUser]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cpBeerAndUser', FILENAME = N'S:\Data\cpBeerAndUser.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cpBeerAndUser_log', FILENAME = N'S:\Data\cpBeerAndUser_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [cpBeerAndUser] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cpBeerAndUser].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cpBeerAndUser] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET ARITHABORT OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [cpBeerAndUser] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cpBeerAndUser] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cpBeerAndUser] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cpBeerAndUser] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cpBeerAndUser] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [cpBeerAndUser] SET  MULTI_USER 
GO
ALTER DATABASE [cpBeerAndUser] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cpBeerAndUser] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cpBeerAndUser] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cpBeerAndUser] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [cpBeerAndUser] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [cpBeerAndUser] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [cpBeerAndUser] SET QUERY_STORE = OFF
GO
USE [cpBeerAndUser]
GO
/****** Object:  Table [dbo].[tblCPBeer]    Script Date: 23/11/2021 12:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPBeer](
	[intIdBeer] [int] IDENTITY(1,1) NOT NULL,
	[strBeerName] [nvarchar](100) NOT NULL,
	[intBrewerId] [int] NOT NULL,
	[intKindOfBeerId] [int] NOT NULL,
	[decAlcohol] [decimal](18, 0) NULL,
	[decPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_tblCPBeer] PRIMARY KEY CLUSTERED 
(
	[intIdBeer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPBrewer]    Script Date: 23/11/2021 12:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPBrewer](
	[intIdBrewer] [int] IDENTITY(1,1) NOT NULL,
	[strBrewerName] [nvarchar](50) NOT NULL,
	[strBrewerAddress] [nvarchar](50) NULL,
	[strBrewerZipCode] [nvarchar](4) NULL,
	[strBrewerCity] [nvarchar](50) NULL,
	[intBrewerProduction] [int] NULL,
 CONSTRAINT [PK_tblCPBrewer] PRIMARY KEY CLUSTERED 
(
	[intIdBrewer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPKindOfBeer]    Script Date: 23/11/2021 12:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPKindOfBeer](
	[intIdKindOfBeer] [int] IDENTITY(1,1) NOT NULL,
	[strKindOfBeerDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblCPKindOfBeer] PRIMARY KEY CLUSTERED 
(
	[intIdKindOfBeer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCPUser]    Script Date: 23/11/2021 12:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPUser](
	[intIdUser] [int] IDENTITY(1,1) NOT NULL,
	[strFirstName] [nvarchar](50) NOT NULL,
	[strLastName] [nvarchar](50) NOT NULL,
	[strEmailAddress] [nvarchar](100) NOT NULL,
	[dtmBirth] [date] NULL,
	[intFavouriteBeerId] [int] NULL,
 CONSTRAINT [PK_tblCPUser] PRIMARY KEY CLUSTERED 
(
	[intIdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCPBeer] ON 
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (4, N'A.C.O.', 104, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (5, N'Aalbeeks St. Corneliusbier  (=Kapittel pater (Het))', 113, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (7, N'Aardbeien witbier', 56, 53, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (8, N'Aarschots kruikenbier (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (10, N'Abt Bijbier (Nen)', 33, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (11, N'Adler', 51, 42, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (12, N'Aerts 1900', 81, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (13, N'Affligem blond (Abdij)', 100, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (14, N'Affligem christmas ale (Abdij)', 100, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (15, N'Affligem dubbel (Abdij)', 100, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (16, N'Affligem patersvat', 100, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (17, N'Affligem tripel (Abdij)', 100, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (18, N'Akila pilsener', 68, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (20, N'Aldegonde brune', 72, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (21, N'Aldegonde cuvee', 72, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (22, N'Aldegonde speciale', 72, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (23, N'Ale brau (=Vega pils)', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (24, N'Alexander Rodenbach', 92, 62, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (25, N'Alfa (=Huyghe blond)', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (26, N'Alfri', 93, 2, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (27, N'Alken faro', 2, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (28, N'Alken faro', 69, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (29, N'Alken special blonde', 2, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (30, N'Alken special blonde', 69, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (31, N'Alken-Maes export', 69, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (32, N'All Black', 21, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (34, N'Ambiorix dubbel', 99, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (38, N'Amelie', 76, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (39, N'Amelie cerise', 76, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (40, N'Amuzantje (=Lamoral Degmont)', 112, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (41, N'Anglo pils', 2, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (42, N'Ankerpils (=Wieze pils)', 125, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (43, N'Anpavi (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (48, N'Anvinoise  (=Beloeil (La biere de))', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (49, N'Arabier', 32, 11, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (51, N'Ardenne blonde (Biere d'')', 21, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (52, N'Argus pils (=Premium pilsener)', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (53, N'Argus witte (=Limburgse witte)', 103, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (54, N'Arjaun (=Lamoral Degmont)', 112, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (55, N'Aro pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (58, N'Arsouye blonde  (=St. Benoit blonde)', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (59, N'Arsouye brune  (=St. Benoit brune (brassin special))', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (60, N'Artevelde', 56, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (61, N'Artevelde grand cru', 56, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (62, N'Artevelde grand cru op gist', 56, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (63, N'Artevelde op gist', 56, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (64, N'Artisan reuzebier', 29, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (65, N'Astor', 56, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (66, N'Atlas (=Vega pils)', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (68, N'Augustijn', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (69, N'Augustijn grand cru', 14, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (70, N'Aulne 6 sur lie (Abbaye d'')', 100, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (71, N'Aulne 8 selection (Abbaye d'')', 100, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (72, N'Aulne 10 superbe (Abbaye d'')', 100, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (73, N'Aulne blonde des peres (Abbaye d'')', 100, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (74, N'Aulne super noel (Abbaye d'')', 100, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (75, N'Aulne triple (Abbaye d'')', 100, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (77, N'Autreppe (Special)', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (78, N'Auveloise (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (79, N'Bacchus', 114, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (80, N'Bakelandt (=Poperings hommelbier)', 113, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (81, N'Balens kruierke', 56, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (82, N'Ballotil  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (84, N'Baptiste (=Riva triple abdij)', 87, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (85, N'Barbar', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (86, N'Bass pale ale', 6, 4, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (87, N'Bastions cuvee speciale (Les)', 21, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (89, N'Bavaro', 51, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (90, N'Bavik dinner beer blond', 8, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (91, N'Bavik dinner beer faro', 8, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (92, N'Bavik export', 8, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (93, N'Bavik premium pils', 8, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (94, N'Bavik triple bock', 8, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (95, N'Bavik witbier', 8, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (97, N'Becasse framboise lambic  (=Belle Vue frambozen)', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (98, N'Becasse gueuze lambic  (=Belle Vue gueuze)', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (99, N'Becasse kriek  (=Belle Vue kriek)', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (100, N'Becasse kriek primeur ''96', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (101, N'Becasse lambik  (=De Neve lambik)', 9, 31, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (102, N'Bel pils', 74, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (103, N'Belgian ale traditional gueuze', 19, 22, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (105, N'Belgo (=Dupont biologique (Saison))', 37, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (106, N'Bell christmas', 93, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (108, N'Belle Vue framboise', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (109, N'Belle Vue frambozenlambik', 9, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (110, N'Belle Vue gueuze', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (111, N'Belle Vue kriek', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (112, N'Belle Vue kriek L.A.', 11, 22, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (113, N'Belle Vue kriekenlambik', 9, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (114, N'Belle Vue lambik', 9, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (115, N'Belle Vue Selection Lambic gueuze', 9, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (117, N'Bellegems witbier', 43, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (118, N'Beloeil (La biere de)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (119, N'Belseels kerstbier', 18, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (120, N'Berenbier/Biere des Ours', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (121, N'Bergenbrau', 6, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (122, N'Bergeotte normale  (=Regal (Saison))', 17, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (123, N'Bergeotte speciale  (=St. Benoit brune (brassin special))', 17, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (124, N'Beselaars Heksenbier (=Poperings hommelbier)', 113, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (125, N'Bieken', 18, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (127, N'"Bier voor Vader ""A"""', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (128, N'"Bier voor Vader ""D"""', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (129, N'"Bier voor Vader ""E"""', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (130, N'"Bier voor Vader ""R"""', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (131, N'"Bier voor Vader ""V"""', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (132, N'Biertoren blond', 56, 51, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (133, N'Biertoren bruno', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (134, N'Biertoren special', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (135, N'Big Chouffe (=Chouffe )', 1, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (136, N'Billekarreke (=Riva triple abdij)', 87, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (137, N'Bilzers bruin', 103, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (138, N'Binchoise blonde  (=St. Benoit blonde)', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (139, N'Binchoise brune  (=St. Benoit brune (brassin special))', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (140, N'Binchoise special noel', 13, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (143, N'Bios blond', 14, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (144, N'Bios bruin', 14, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (145, N'Bios Vlaamse bourgogne', 14, 62, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (146, N'Bisounette  (=St. Benoit brune)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (147, N'Black Gosh', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (150, N'Bleeken Moriaen (=Kapittel abt (Het))', 113, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (155, N'Blok-bok (Nen)', 33, 12, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (156, N'Blondine', 54, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (157, N'Boals kruikenbier triple (=St. Sebastiaan grand cru)', 105, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (159, N'Bock premium pils', 81, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (160, N'Bockhauser pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (166, N'Boeg pils', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (167, N'Bois Bouquet (Trappiste du)', 91, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (168, N'Bokkereyer', 103, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (169, N'Bokrijk hoevebier 6', 105, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (170, N'Bokrijk hoevebier 8', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (171, N'Bokrijks kruikenbier', 105, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (172, N'Bol d''or', 39, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (173, N'Bonde (Biere de la) (=Kapittel abt (Het))', 113, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (174, N'Bonne Esperance (Abbaye de)', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (175, N'Bons voeux (Avec les -- de la brasserie)', 37, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (176, N'Boon frambozenbier', 19, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (177, N'Boon frambozenbier 1986', 19, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (178, N'Boon geuze', 19, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (179, N'Boon geuze mariage parfait', 19, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (180, N'Boon kriek', 19, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (181, N'Boon kriek mariage parfait', 19, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (182, N'Boon lambik', 19, 56, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (184, N'Bornem dubbel', 14, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (185, N'Bornem tripel', 14, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (186, N'Bosbier', 103, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (187, N'Boskeun', 32, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (188, N'Bosquetia', 17, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (189, N'Boucanier (Biere du) (=Piraat)', 14, 21, CAST(11 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (190, N'Bourgogne des Flandres', 108, 60, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (191, N'Bousval blonde speciale (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (192, N'Bousval brune speciale (=Floreffe double)', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (193, N'Boxer christmas beer (=Affligem christmas ale)', 100, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (196, N'Brave Broeder (=Super 64)', 98, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (197, N'Brigand', 114, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (198, N'Brigand christmas', 114, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (199, N'Brogne donker (Abbaye de) (=Affligem dubbel (Abdij))', 100, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (200, N'Brogne triple (Abbaye de) (=Affligem tripel (Abdij))', 100, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (201, N'Broqueroise de l''abbaye de St. Denis  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (202, N'Brouwers van de Dijle (De) (=Lamot pilsor)', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (204, N'Brouwmeester alcohol vrij bier', 2, 2, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (205, N'Brouwmeester pilsener', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (207, N'Brug ale Belge', 98, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (209, N'Brugs tarwebier', 50, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (210, N'Brugse straffe Hendrik', 106, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (211, N'Brugse tripel', 50, 59, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (213, N'Brunehaut tradition amber', 21, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (214, N'Brunehaut villages blond', 21, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (215, N'Brunette', 54, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (216, N'Bruocsella 1900 grand cru', 22, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (217, N'Brussels gold (=Pax pils)', 103, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (218, N'Brussels gold (=Pax pils)', 103, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (219, N'Brussels white (=Limburgse witte)', 103, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (220, N'Brusselse witte (=Student)', 64, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (221, N'Bruyere blonde  (=Fakir)', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (222, N'Bruyere brune  (=Reserve Marie de Hongrie)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (223, N'Bruynen Moriaen (=Kapittel prior (Het))', 113, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (224, N'Buffalo', 112, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (225, N'Bumke (=Pater Lieven)', 112, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (227, N'Bush beer', 36, 21, CAST(12 AS Decimal(18, 0)), CAST(13 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (228, N'Bush beer 7', 36, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (229, N'Bush de Noel', 36, 21, CAST(12 AS Decimal(18, 0)), CAST(13 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (230, N'Buxus blonde  (=Fakir)', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (231, N'Buxus brune  (=Reserve Marie de Hongrie)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (232, N'C.T.S. Scotch', 6, 46, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (233, N'Cambrinus', 118, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (234, N'Campagnarde  brune', 83, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (235, N'Campbell''s christmas', 6, 46, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (236, N'Campbell''s scotch', 6, 46, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (238, N'Campus', 56, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (239, N'Campus gold', 56, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (240, N'Canebiere', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (241, N'Cantillon faro', 22, 54, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (242, N'Cantillon kriek', 22, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (243, N'Cantillon kriek lambik', 22, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (244, N'Cantillon lambik', 22, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (245, N'Cantillon super gueuze', 22, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (246, N'Cara pils', 69, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (247, N'Caracole ambree', 23, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (249, N'Caracole brune', 23, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (250, N'Caramel biere de table', 41, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (252, N'Carioca classic', 56, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (253, N'Carnav-ale (kruik) (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (254, N'Caves', 118, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (255, N'Caza cuvee speciale (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (256, N'Celis pale bock', 100, 25, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (258, N'Celis white', 100, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (260, N'Cervesia', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (261, N'Cervoise de l''Avouerie d''Anthisnes (=Silly (Saison))', 98, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (262, N'Cervoise de l''Ecluse blonde  (=Fakir)', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (263, N'Cervoise de l''Ecluse brune  (=Reserve Marie de Hongrie)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (264, N'Cervoise de Leptines (=Beloeil (La biere de))', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (265, N'Cervoise de St. Gery  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (266, N'Cervoise des Ancetres grand cru (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (267, N'Cervoise des Francs-Gaulois  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (268, N'Cezarken', 29, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (269, N'Chapeau abricot lambic', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (270, N'Chapeau exotic', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (271, N'Chapeau faro', 110, 19, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (272, N'Chapeau fraises lambic', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (273, N'Chapeau framboise', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (274, N'Chapeau gueuze', 110, 22, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (275, N'Chapeau kriek', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (276, N'Chapeau mirabelle', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (277, N'Chapeau peche', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (278, N'Chapeau tropical', 110, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (281, N'Charlemagne (=Delirium Tremens)', 56, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (282, N'Charleroi (Blanche de)', 21, 53, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (283, N'Charles Quint', 51, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (284, N'Chateau Saint-Henri Cuvee speciale', 72, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (285, N'Chimay blauw', 25, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (286, N'Chimay cinq cents (=Chimay wit)', 25, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (287, N'Chimay grande reserve (=Chimay blauw)', 25, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (288, N'Chimay premiere (=Chimay rood)', 25, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (289, N'Chimay rood', 25, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (290, N'Chimay wit', 25, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (291, N'Chouffe', 1, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (292, N'Chouffe-bok 6666', 1, 12, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (293, N'Christmas-Beer', 29, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (294, N'Ciney blonde', 111, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (295, N'Ciney brune', 111, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (296, N'Ciney speciale', 111, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (301, N'Clermontoise  (=Ploquette )', 94, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (302, N'Club de Stella Artois', 6, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (303, N'Cnudde kriek', 27, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (304, N'Cnudde Oudenaards bruin', 27, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (305, N'Cochonette', 117, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (306, N'Con Domus (Nen)', 33, 11, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (307, N'Contra-pils', 28, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (308, N'Contreras martzen bier', 28, 35, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (309, N'Coq Hardi biere blonde de luxe', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (310, N'Coq Hardi biere bock', 51, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (311, N'Coq Hardi pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (312, N'Coq Hardi speciale', 51, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (314, N'Corsaire biere rouge (Biere du)', 56, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (316, N'Corsendonk Agnus (=Moine (triple))', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (317, N'Corsendonk Pater (=Bornem dubbel)', 14, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (318, N'Couckelaerschen Doedel', 107, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (320, N'Coy''Heimsen (=Kapittel pater (Het))', 113, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (321, N'Crack pils (=Sas pils)', 65, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (322, N'Cristal Alken', 2, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (323, N'Crupetoise  (=St. Benoit brune)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (324, N'Cubana ''59', 57, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (327, N'Cuvee 100 ans Domaine du Bois d''Anchin', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (328, N'Cuvee Chateau des Flandres', 54, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (329, N'Cuvee d''Aristee - biere au miel', 83, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (330, N'Cuvee d''Aristee speciale noel', 83, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (332, N'Cuvee de Briqville (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (333, N'Cuvee de Francorchamps (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (334, N'Cuvee De Koninck', 62, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (335, N'Cuvee de l''An Neuf', 23, 49, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (336, N'Cuvee de l''Ascension blonde (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (337, N'Cuvee de l''Ermitage', 111, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (338, N'Cuvee de l''Ermitage christmas', 111, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (340, N'Cuvee de la Gate', 44, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (341, N'Cuvee de la Pucelette (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (343, N'Cuvee de la Vieille Auberge (=Fagnes (Blonde des))', 119, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (344, N'Cuvee de Namur blonde', 56, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (345, N'Cuvee de Namur brune', 56, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (349, N'Cuvee de Winamplanche (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (350, N'Cuvee de''l Sin Djosef', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (351, N'Cuvee des Flandres triple', 56, 59, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (352, N'Cuvee des moissons blonde (=Vapeur en folie )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (353, N'Cuvee des tietes de pipes blonde (=Fakir)', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (354, N'Cuvee des tietes de pipes brune (=Reserve Marie de Hongrie)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (356, N'Cuvee du P''tit Lu (=Regal (Saison))', 17, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (359, N'Cuvee du Spartacus blonde (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (360, N'Cuvee du Spartacus brune (=Floreffe double)', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (361, N'Cuvee du Tcheste (=Mc Chouffe)', 1, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (362, N'Cuvee du Tronquoy (=Pipaix (Saison de))', 117, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (364, N'Cuvee Jean d''Avesnes ambree', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (365, N'Cuvee Jean d''Avesnes blanche', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (366, N'Cuvee Li Crochon (=St. Benoit brune (brassin special))', 17, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (367, N'Cuvee Melletoise (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (369, N'Cuvee Rene grand cru (=Lindemans gueuze gefilterd)', 67, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (370, N'Cuvee Saint. Roch (=Soleilmont double)', 64, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (371, N'Cuvee speciale blanche des Bastions', 21, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (373, N'Cuvee speciale du 80e (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (376, N'Cuvee speciale Patro Salette (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (377, N'Cuvee St-Francois Xavier', 72, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (379, N'Cuvee St. Berthuin (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (380, N'Cuvee St. Hadelin blonde (=St. Benoit blonde)', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (381, N'Cuvee St. Hadelin brune (=St. Benoit brune)', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (387, N'Daens', 113, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (388, N'Daiselnaere (=Steenbrugge (Abdij))', 50, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (389, N'Darbyste (Biere)', 15, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (390, N'De Koninck', 62, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (392, N'De Koninck gueuze (=De Neve gueuze ongefilterd)', 11, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (393, N'De Koninck kriek (=De Neve kriek)', 11, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (395, N'De Neve frambozen', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (396, N'De Neve gueuze gefilterd', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (397, N'De Neve gueuze ongefilterd', 11, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (398, N'De Neve kriek', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (399, N'De Neve lambik', 9, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (400, N'De Ryck (Special)', 95, 33, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (401, N'De Ryck christmas pale ale', 95, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (402, N'De Ryck kriek', 95, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (403, N'De Troch gueuze ongefilterd', 110, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (404, N'Deca Lux pils', 30, 42, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (405, N'Deins paasbier', 112, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (406, N'Delhaize blond tafelbier (=Piedboeuf blonde)', 58, 51, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (407, N'Delhaize bruin tafelbier (=Piedboeuf dubbel - foncee)', 58, 51, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (408, N'Delhaize christmas (=Affligem christmas ale (Abdij))', 100, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (409, N'Delhaize wit bier', 100, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (410, N'Delirium Tremens', 56, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (411, N'Dentergems witbier - Riva blanche', 87, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (412, N'Derby blond (=Piedboeuf blonde)', 58, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (413, N'Derby bruin (=Piedboeuf dubbel - foncee)', 58, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (414, N'Derby pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (415, N'Deugniet (=Moine (triple))', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (416, N'Dieleghem ambree (Abbaye de)', 64, 6, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (417, N'Dieleghem blonde (Abbaye de) (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (418, N'Dieleghem foncee (Abbaye de) (=Floreffe double)', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (419, N'Dikke Mathile', 107, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (420, N'Dikkenek', 100, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (421, N'Dirk Martensbier (=Bornem tripel)', 14, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (422, N'Divine', 98, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (423, N'Dobbelken (=Ichtegem''s oud bruin)', 107, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (424, N'Dolmenius (=St. Benoit blonde)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (425, N'Domaine du bois d''Anchin', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (426, N'Domein bleek (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (427, N'Domein donker (=Bornem dubbel)', 14, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (428, N'Dommelsch malt', 6, 3, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (431, N'Double Enghien blonde', 98, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (432, N'Double Enghien brune', 98, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (433, N'Doux chemin de l''amour (Le) (=Fagnes (Blonde des))', 119, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (434, N'Drie Fonteinen faro', 35, 54, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (435, N'Drie Fonteinen frambozenlambik', 35, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (436, N'Drie Fonteinen gueuze', 35, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (437, N'Drie Fonteinen kriek', 35, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (438, N'Drie Fonteinen kriek van het vat', 35, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (439, N'Drie Fonteinen kriekenlambik', 35, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (442, N'Drongens plezierke (=Ambiorix dubbel)', 99, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (443, N'Drossaard blond', 56, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (444, N'Drossaard donker', 103, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (445, N'Duchesse de Bourgogne', 118, 62, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (446, N'Duivels bier', 115, 60, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (447, N'Dulle Teve', 32, 11, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (448, N'Dupont biologique (Saison)', 37, 45, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (449, N'Dupont vieille provision (Saison)', 37, 45, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (450, N'Durboyse ambree', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (451, N'Durboyse blonde', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (452, N'Durboyse blonde  (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (453, N'Durboyse brune  (=Floreffe double)', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (454, N'Duvel groen', 74, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (455, N'Duvel rood', 74, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (456, N'Eautex de Brunehaut', 21, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (457, N'Ecume des jours', 21, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (458, N'Edel-Brau', 107, 3, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (461, N'El Vert Doudou (=Pipaix (Saison de))', 117, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (462, N'El'' Simpelourd', 21, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (465, N'Ename dubbel', 93, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (466, N'Ename tripel', 93, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (467, N'Engel (Nen)', 33, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (468, N'Engeltjes bier', 104, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (469, N'Ensor', 107, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (472, N'Epeautre (Saison d'')', 15, 45, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (473, N'Erezee (Saison d'') - Automne', 44, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (474, N'Erezee (Saison d'') - Ete', 44, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (475, N'Erezee (Saison d'') - Hiver', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (476, N'Erezee (Saison d'') - Printemps', 44, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (478, N'Essen Bakkersmolen Wildert blond', 91, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (479, N'Essen Bakkersmolen Wildert bruin', 91, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (480, N'Etoile (La speciale) (=Vapeur rousse )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (481, N'Eupener caramel', 41, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (482, N'Eupener export', 41, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (483, N'Eupener extra light', 41, 34, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (484, N'Eupener klosterbier special bock', 41, 12, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (485, N'Eupener pils', 41, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (487, N'Eurotica', 117, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (488, N'Ever', 14, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (489, N'Eylenbosch framboise lambic', 42, 22, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (490, N'Eylenbosch gueuze lambic', 42, 22, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (491, N'Eylenbosch kriek lambic', 42, 22, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (492, N'Ezel (=Gapers bier)', 118, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (494, N'Facon export', 43, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (495, N'Facon extra stout', 43, 49, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (496, N'Facon oud bruin', 43, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (497, N'Facon pils', 43, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (498, N'Facon scotch-christmas', 43, 46, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (499, N'Facon tafelbier blond', 43, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (500, N'Facon tafelbier bruin', 43, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (503, N'Fagnes (Blonde des)', 119, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (504, N'Fagnes (Rousse des)', 119, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (505, N'Fakir', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (508, N'Fancy', 8, 8, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (510, N'Fantome', 44, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (511, N'Fantome brewery (The best of)', 44, 36, CAST(12 AS Decimal(18, 0)), CAST(13 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (512, N'Fantome de noel', 44, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (513, N'Fantomette', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (516, N'Felix kriekbier', 26, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (517, N'Felix Oudenaards kriekbier', 26, 61, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (518, N'Felix Oudenaards oud bruin', 26, 61, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (519, N'Felix pils', 26, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (520, N'Felix speciaal Oudenaards', 26, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (522, N'Feuilles Mortes (Les) (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (523, N'Fiertelbier (=Kapittel abt (Het))', 113, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (525, N'Filee  (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (526, N'Fink brau (=Premium pilsener)', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (527, N'Fink brau (=Wieze pils)', 125, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (528, N'Fire fox', 56, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (529, N'Fitt', 125, 2, CAST(15 AS Decimal(18, 0)), CAST(16 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (530, N'Flanders triple grand cru (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (532, N'Flandrien', 68, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (533, N'Fleurie de Wanze', 1, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (534, N'Flierefluiter (Ne) (=Affligem blond (Abdij))', 100, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (537, N'Floreffe (Blanche de)', 64, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (538, N'Floreffe blonde', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (539, N'Floreffe double', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (540, N'Floreffe la meilleure', 64, 36, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (541, N'Floreffe triple (=Bonne Esperance (Abbaye de))', 64, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (542, N'Florisgaarden chocolat', 56, 53, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (543, N'Florisgaarden fraises', 56, 53, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (544, N'Florisgaarden griotte', 56, 53, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (545, N'Florisgaarden ninkeberry', 56, 53, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (546, N'Florisgaarden passion', 56, 53, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (547, N'Florisgaarden witbier', 56, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (548, N'Florival blond (Abdij) (=Affligem blond (Abdij))', 100, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (549, N'Florival bruin (Abdij) (=Affligem dubbel (Abdij))', 100, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (550, N'Foire verte de l''eau d''heure cuvee speciale', 97, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (552, N'Follie  (=Vapeur legere)', 117, 34, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (553, N'Foret (=Dupont biologique (Saison))', 37, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (554, N'Foudroyante de Bruxelles (Blanche) (=Student)', 64, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (555, N'Foudroyante framboise (=Lindemans framboise)', 67, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (556, N'Foudroyante gueuze (=Lindemans gueuze gefilterd)', 67, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (557, N'Foudroyante kriek (=Lindemans kriek)', 67, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (558, N'Foudroyante myrtille', 67, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (559, N'Foudroyante peche (=Pecheresse)', 67, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (560, N'Four chapitre  (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (565, N'Francorchamps (Blanche de) (=Student)', 64, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (566, N'Frenette', 117, 8, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (567, N'Freutche (=1900 (Saison))', 64, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (568, N'Frontaliere  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (569, N'Fumee d''Anvers', 120, 44, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (570, N'"Gaillarde de ""la Posterie"" cuvee spec. (=Bons voeux (Avec les -- de la brasserie))"', 37, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (571, N'Gala pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (572, N'Galmaarden dubbel Meesters bier', 71, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (574, N'Galmaarden tripel Meesters bier', 71, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (575, N'Gambrinus bock (=Sernia bock)', 58, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (576, N'Gambrinus pils (=Sernia pils)', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (577, N'Gapers bier', 118, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (578, N'Gauloise ambree', 17, 6, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (579, N'Gauloise blonde', 17, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (580, N'Gauloise brune', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (581, N'Gaumaise blonde', 48, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (582, N'Gaumaise brune', 48, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (583, N'Gaverhopke (''t) blond', 47, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (584, N'Gaverhopke (''t) bruin 12', 47, 36, CAST(12 AS Decimal(18, 0)), CAST(13 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (585, N'Gaverhopke (''t) bruin 8', 47, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (586, N'Gayette  (=St. Benoit brune)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (587, N'GB special amber (=Op-ale)', 100, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (588, N'GB tafelbier tripel (=Bavaro)', 51, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (591, N'Geants (Speciale des) (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (592, N'Geldonia blonde  (=St. Benoit blonde)', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (593, N'Geldonia brune  (=St. Benoit brune)', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (594, N'Gembloux (Biere de l''abbaye de) (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (595, N'Gentse tripel', 54, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (597, N'Gigi double blonde', 48, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (598, N'Gigi speciale', 48, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (599, N'Gildenbier', 51, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (600, N'Ginder ale', 6, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (601, N'Girardin framboise', 49, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (602, N'Girardin gueuze 1882', 49, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (603, N'Girardin kriek 1882', 49, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (604, N'Girardin kriekenlambik', 49, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (605, N'Girardin lambik', 49, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (607, N'Godefroy', 74, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (608, N'Godefroy premium pils (=Bel pils)', 74, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (609, N'Goen (Ne) (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (610, N'Goldburg', 8, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (612, N'Golden dragon beer (=Gulden Draak)', 14, 21, CAST(11 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (613, N'Golden Kenia', 56, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (614, N'Golding Campina', 69, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (617, N'Gouden Carolus', 4, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (620, N'Gougnies  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (621, N'Grand bi-ere de blondine', 104, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (623, N'Grande Axhoise', 76, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (626, N'Green''s beer', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (628, N'Grenadiere speciale ambree', 72, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (629, N'Grimbergen blond', 111, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (630, N'Grimbergen dubbel', 111, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (631, N'Grimbergen optimo bruno', 111, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (632, N'Grimbergen tripel', 111, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (633, N'Grisette', 100, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (634, N'Grisette biere du cayoteu (=Super 64)', 98, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (635, N'Gueule noire  - Koempelbier (=Villers Saint-Ghislain brune (Speciale))', 98, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (636, N'Gueuze framboisee des Ardennes (=Timmermans framboise lambic)', 108, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (637, N'Guillotine', 56, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (638, N'Gulden Draak', 14, 36, CAST(11 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (639, N'Guldenberg', 85, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (641, N'Haacht blonde', 51, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (642, N'Haacht export (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (643, N'Haacht pils', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (644, N'Haecht witbier', 51, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (645, N'Halloween pumpkin ale (=Pumpkin ale)', 120, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (647, N'Hanssens gueuze', 53, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (648, N'Hanssens kriek', 53, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (649, N'Hapkin', 68, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (651, N'Harelbekenaar van de abdijhoeve - pater (=Kapittel pater (Het))', 113, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (652, N'Harelbekenaar van de abdijhoeve - wit (=Watou''s wit bier)', 113, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (655, N'Heerenbier', 18, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (656, N'Hei-kneuter', 125, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (658, N'Heliante', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (659, N'Helios', 6, 42, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (660, N'Hellekapelle', 12, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (661, N'Helleketelbier', 12, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (662, N'Helles export', 99, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (664, N'Hercule', 40, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (665, N'Hercule a Vapeur  (=Vapeur rousse )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (666, N'Heren van Bets (De) (=Silly (Saison))', 98, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (667, N'Hertog Jan pilsener', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (668, N'Hesbaye  ambree', 76, 6, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (669, N'Hesbaye  blanche', 76, 53, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (670, N'Hesbaye  blonde', 76, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (671, N'Hesbaye  brune', 76, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (672, N'Hesbaye  cuvee speciale', 76, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (673, N'Hesbaye  noire', 76, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (675, N'Hesbaye  saison', 76, 45, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (677, N'Heymissen dubbel (Abdijbier van)', 122, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (678, N'Heymissen tripel (Abdijbier van)', 122, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (682, N'Hoekse witte', 112, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (683, N'Hoeve bier', 107, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (684, N'Hoge Bi-er', 104, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (686, N'Honnelles (Blanche des)', 91, 53, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (687, N'Hoofse gaffel (=Lamoral Degmont)', 112, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (688, N'Hoppe ambachtelijke pils (=Sparta pils)', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (689, N'Horse ale', 6, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (690, N'Hotteuse 5', 93, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (691, N'Hotteuse grand cru', 93, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (693, N'Houlette  (=Regal (Saison))', 17, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (694, N'Hure  (=Saxo)', 23, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (695, N'Huyghe blond', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (696, N'Huyghe bruin', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (697, N'Huyghe export', 56, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (698, N'Huyghe faro', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (699, N'Ichtegem''s oud bruin', 107, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (700, N'Iguanodon (=Fakir)', 13, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (701, N'Incartade  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (702, N'Interpils (=Wieze pils)', 125, 42, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (705, N'Jack-Op', 11, 60, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (709, N'Jamelovienne  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (710, N'Jan Buuc (=Katje special)', 65, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (711, N'Jan van Gent', 66, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (716, N'Jobarde (=Vapeur en folie )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (717, N'John Martin''s special', 57, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (720, N'Joyeuse blonde  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (721, N'Joyeuse brune  (=Moinette brune)', 37, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (723, N'Judas', 111, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (724, N'Julius', 6, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (725, N'Jumeaux ambree (Biere des)', 44, 6, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (726, N'Jumeaux blonde (Biere des)', 44, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (727, N'Jumelage (La biere du)', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (729, N'Jupiler', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (730, N'Jupiler NA', 6, 3, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (731, N'K.I.H.O. X-mas blond', 59, 33, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (732, N'K.I.H.O. X-mas bruin', 59, 14, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (737, N'Kamilleken (=Lamoral Degmont)', 112, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (739, N'Kapel van Schoor (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (740, N'Kapittel abt (Het)', 113, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (741, N'Kapittel dubbel (Het)', 113, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (742, N'Kapittel pater (Het)', 113, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (743, N'Kapittel prior (Het)', 113, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (744, N'Karibik pils', 56, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (745, N'Karlsquell pils (=Kwik pils)', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (746, N'Karmeliet tripel', 20, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (748, N'Kasteel van Ramegnies-Chin (Bier v/h)', 43, 36, CAST(12 AS Decimal(18, 0)), CAST(13 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (749, N'Kasteelbier gouden triple', 114, 59, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (750, N'Kasteelbier Ingelmunster', 114, 36, CAST(11 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (751, N'Kasteelbier Ooidonk (=Kasteelbier Ingelmunster)', 114, 36, CAST(11 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (752, N'Katje special', 65, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (753, N'Keerse tripel (=St. Sebastiaan grand cru)', 105, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (754, N'Keizersberg abdijbier (=Bornem tripel)', 14, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (755, N'Kelmeser (Der blonde) (=Fakir)', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (756, N'Kelottes 75cl', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (757, N'Kempenaar (Ne)', 113, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (758, N'Kerelsbier donker (=Katje special)', 65, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (759, N'Kerelsbier licht (=Sasbrau)', 65, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (761, N'Kerstbie(r)', 12, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (762, N'Kerstbol', 39, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (763, N'Kerstklok', 18, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (764, N'Kerstpater', 112, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (765, N'Keyport beer (=Safir)', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (766, N'Keyser (=Pax pils)', 103, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (767, N'Kilo (de)', 49, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (768, N'King''s pils (=Facon pils)', 43, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (769, N'Kirally (=Pipaix (Saison de))', 117, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (771, N'Klinkaert', 14, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (772, N'Klooster Zusters Annonciaden (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (773, N'Kluyserbier (=Poorter)', 105, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (774, N'Kortessems blondje', 76, 53, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (778, N'Kronenbourg', 2, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (779, N'Kruger export', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (780, N'Kurstenbrau (=Vega pils)', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (781, N'Kuurnse bruine', 8, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (782, N'Kuurnse witte', 8, 53, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (786, N'Lamoral Degmont', 112, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (787, N'Lamoral tripel', 112, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (788, N'Lamot pilsor', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (789, N'Laplaignoise  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (792, N'Lazarus bier', 104, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (793, N'Lefebvre blonde', 64, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (794, N'Lefebvre brune', 64, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (795, N'Lefebvre triple blonde', 64, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (796, N'Leffe birra rossa', 102, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (797, N'Leffe blonde', 102, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (798, N'Leffe brune', 102, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (799, N'Leffe radieuse', 102, 36, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (801, N'Leffe vieille cuvee 8', 102, 36, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (802, N'Lembeek''s', 19, 8, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (803, N'Lentebier', 17, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (804, N'Leroy blond', 65, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (805, N'Leroy bruin', 65, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (806, N'Leroy christmas', 65, 46, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (807, N'Leroy stout', 65, 49, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (808, N'Leuvendige witte (Nen)', 33, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (811, N'Lichtervelds blond', 32, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (812, N'Liefmans frambozenbier', 66, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (813, N'Liefmans gluhkriek', 66, 61, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (814, N'Liefmans goudenband', 66, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (815, N'Liefmans kriek', 66, 61, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (816, N'Liefmans odnar', 66, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (817, N'Liefmans oud bruin', 66, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (818, N'Limburgse witte', 103, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (819, N'Lindemans cassis', 67, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (820, N'Lindemans faro lambic', 67, 54, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (821, N'Lindemans framboise', 67, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (822, N'Lindemans gueuze gefilterd', 67, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (823, N'Lindemans gueuze ongefilterd', 67, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (824, N'Lindemans kriek', 67, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (825, N'Lindemans kriekenlambik', 67, 56, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (826, N'Lindemans lambik', 67, 56, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (827, N'Lion (Biere du)', 119, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (829, N'Livinus blonde (=Kapittel abt (Het))', 113, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (830, N'Livinus brune (=Kapittel prior (Het))', 113, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (831, N'Loburg', 6, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (833, N'Lokernaere (E) (=Yperman)', 65, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (835, N'Loteling blond', 120, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (836, N'Loteling bruin', 120, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (837, N'Loterbol', 39, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (839, N'Louvoise  (=St. Benoit blonde)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (840, N'Louwaege dubbel blond', 68, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (841, N'Louwaege export', 68, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (842, N'Louwaege faro', 68, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (843, N'Louwaege stout', 68, 49, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (844, N'Louwaege''s pils', 68, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (845, N'Louwke Poep', 14, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (846, N'Lowiden', 113, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (847, N'Lowie Kators', 14, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (848, N'Lowie V (=Cnudde Oudenaards bruin)', 27, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (849, N'Lucifer', 87, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (854, N'Maerlant (=Bornem tripel)', 14, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (855, N'Maes cool beer', 69, 26, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (856, N'Maes export', 69, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (857, N'Maes pils', 69, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (858, N'Magonette', 109, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (859, N'Malmedy blonde (Biere speciale de) (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (860, N'Malmedy brune (Biere speciale de) (=Floreffe double)', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (861, N'Malognarde blonde', 13, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (862, N'Malognarde brune  (=Reserve Marie de Hongrie)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (863, N'Malonne (Abbaye de - Abdij van) bruin bier', 51, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (864, N'Maltosa', 51, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (865, N'Manneken Pis (=Oud Zottegems bier)', 29, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (866, N'Manou des Sources (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (869, N'Marchande tripel', 21, 59, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (870, N'Marckloff', 45, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (871, N'Marckloff Valentin', 45, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (872, N'Maredsous 10', 74, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (873, N'Maredsous 6 blond', 74, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (874, N'Maredsous 6 donker', 74, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (875, N'Maredsous 8', 74, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (876, N'Marlagne blanche', 72, 53, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (877, N'Marlagne blonde', 72, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (878, N'Marquise', 56, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (879, N'Mars (Biere de)', 6, 35, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (882, N'Martens pils', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (883, N'Martens tafelstout', 70, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (885, N'Match blond tafelbier', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (886, N'Match bruin tafelbier', 56, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (887, N'Match tripel tafelbier', 56, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (888, N'Mateen Belgian ale triple', 56, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (889, N'Mater wit bier', 93, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (891, N'Mc Chouffe', 1, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (892, N'Mc Ewans christmas', 57, 46, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (893, N'Mc Ewans scotch ale', 57, 46, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (894, N'Mc Gregor', 56, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (895, N'Mechelschen bruynen', 4, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (897, N'Meneer', 96, 11, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (898, N'Mengbier', 10, 60, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (899, N'Mengsel La Folie/Saison de Pipaix', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (900, N'Menhir (Blonde du)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (901, N'Mercator', 120, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (903, N'Minty', 56, 33, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (904, N'Miroir christmas', 73, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (905, N'Miroir paasbier', 73, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (906, N'Miroir speciale', 73, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (907, N'Miroir speciale dark', 73, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (908, N'Moeder Overste (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (909, N'Moine (triple)', 17, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (910, N'Moinette biolegere/zacht', 37, 8, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (911, N'Moinette biologique', 37, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (912, N'Moinette blonde', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (913, N'Moinette brune', 37, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (914, N'Moinette des iguanodons de Bernissart (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (915, N'Moinette des Sorcieres de Warquignies  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (916, N'Molenbier', 95, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (917, N'Molenbier (=Bokkereyer)', 103, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (918, N'Molenbier (Tessenderlo) (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (922, N'Moneuse', 15, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (923, N'Moneuse speciale noel', 15, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (925, N'Mont Saint-Aubert', 21, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (926, N'Montagnarde', 91, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (927, N'Mort Subite cassis', 60, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (928, N'Mort Subite framboise', 60, 22, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (929, N'Mort Subite gueuze fond', 60, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (930, N'Mort Subite gueuze gefilterd', 60, 22, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (931, N'Mort Subite kriek', 60, 22, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (932, N'Mort Subite peche', 60, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (934, N'Munck pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (940, N'N''Ice Chouffe', 1, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (941, N'Namur (Blanche de)', 17, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (942, N'Napoleon', 100, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (943, N'Nationale  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (944, N'Neiges (Blanche des)', 56, 53, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (945, N'Neuvilloise', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (946, N'Ninoviet (=Noel-christmas-Weihnacht)', 118, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (951, N'Noel (Blanche de)', 17, 53, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (952, N'Noel (Speciale blanche)', 91, 53, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (953, N'Noel (Speciale)', 100, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (954, N'Noel de Silenrieux', 97, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (955, N'Noel-christmas-Weihnacht', 118, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (956, N'Nonettes (Biere des)', 56, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (957, N'Nostra Domus (Nen)', 33, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (959, N'Nounou (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (960, N'O Mac Kot (Biere de Blaton) (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (961, N'O''Connell''s Dublin ale', 56, 4, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (962, N'Obigeoise', 43, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (963, N'Ochtend kriek (Nen)', 33, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (965, N'Oelegems kruikenbier (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (966, N'Oelegems Titsenbier (=Moinette biologique)', 37, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (967, N'Oeral', 32, 11, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (968, N'Oerbier', 32, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (971, N'Old Musketeer', 65, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (972, N'Oliver Twist (Nen) (=Toison d''or (triple))', 4, 59, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (973, N'Op-ale', 100, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (974, N'Ops-ale', 103, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (975, N'Oregon rodeo beer', 105, 8, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (976, N'Orval', 78, 11, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (977, N'Oud Beersel gueuze', 116, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (978, N'Oud Beersel lambik', 116, 56, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (979, N'Oud Kriekenbier', 29, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (980, N'Oud Zottegems bier', 29, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (981, N'Oud Zottegems bier hergist', 29, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (983, N'Oudenaards wit tarwebier', 26, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (984, N'Oudenburgs abdijbier', 104, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (985, N'Oudenburgs bruin', 104, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (986, N'Oudenburgse tripel', 104, 59, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (988, N'Paasbier', 104, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (990, N'Pacques (Brassin de)', 76, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (993, N'Palm (Dobbel)', 81, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (994, N'Palm (Speciale)', 81, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (995, N'Palm green', 81, 3, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (997, N'Paques (Biere de)', 13, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (998, N'Paranoia groen', 120, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (999, N'Paranoia roze', 120, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1001, N'Parbo bier (=Pax pils)', 103, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1002, N'Park (Abdij van ''t) bruin', 111, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1003, N'Pastorijpoort Balen/Olmen (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1004, N'Pater brune (=Maltosa)', 51, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1008, N'Pater Van Damme', 82, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1009, N'Paulus', 65, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1010, N'Pauwel Kwak', 20, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1011, N'Pave de l''Ours (Le)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1012, N'Pax pils', 103, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1013, N'Pecheresse', 67, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1014, N'Pecheresse (Petite) (=Pecheresse)', 67, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1015, N'Pee Klak grand cru (=Zottegemse grand cru)', 29, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1016, N'Pee Klak Moorsels bier', 107, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1017, N'Pee Klak special', 29, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1019, N'Pellainoise', 76, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1024, N'Perle d''Hastiere  (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1025, N'Pertotale faro', 19, 19, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1026, N'Peter Benoit', 65, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1029, N'Petouille  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1030, N'Petrus (Triple)', 8, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1031, N'Petrus oud bruin', 8, 62, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1032, N'Petrus speciale', 8, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1034, N'Pick-up pils', 121, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1035, N'Piedboeuf blonde', 6, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1036, N'Piedboeuf blonde', 58, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1037, N'Piedboeuf dubbel - foncee', 6, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1038, N'Piedboeuf dubbel - foncee', 58, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1039, N'Piedboeuf tripel - triple', 58, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1041, N'Pierreuse', 76, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1043, N'Pint pilsener (=Premium pilsener)', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1044, N'Pipaix (Saison de)', 117, 45, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1046, N'Pir''eye di Licint 6.5 (Li) (=Fakir)', 13, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1047, N'Pir''eye di Licint 9 (Li) (=Reserve Marie de Hongrie)', 13, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1048, N'Piraat', 14, 21, CAST(11 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1050, N'Pissenlit', 44, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1051, N'Platzen pils (=Sernia pils)', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1053, N'Ploquette', 94, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1054, N'Poiluchette blanche de Thy  (=Neiges (Blanche des))', 56, 53, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1055, N'Poiluchette blonde', 56, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1056, N'Poiluchette brune', 56, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1057, N'Polderbier bitter', 104, 11, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1058, N'Polderbier fruitig', 104, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1060, N'Pompeschitter (De)', 65, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1062, N'Pontonnierke', 104, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1063, N'Pony stout', 8, 49, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1064, N'Poorter', 105, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1065, N'Poperings hommelbier', 113, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1066, N'Postel dobbel', 100, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1067, N'Postel kerstbier', 100, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1068, N'Postel tripel', 100, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1069, N'Praile (Blonde de la)', 83, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1071, N'Praile (Saison de la)', 83, 45, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1073, N'Premium pilsener', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1074, N'Prik pils', 93, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1075, N'Prima', 65, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1076, N'Primeur kriek', 11, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1077, N'Primus', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1078, N'Prisma pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1079, N'Prosit pils', 20, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1081, N'Pumpkin ale', 120, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1082, N'Punch blond', 43, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1083, N'Punch donker', 43, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1084, N'Quenast', 64, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1085, N'Queue de charrue', 118, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1086, N'Queue de charrue blonde (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1087, N'Queue de chat', 44, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1088, N'Quintine', 40, 11, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1090, N'Quintine de noel', 40, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1091, N'Rabat  (=Mc Chouffe)', 1, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1092, N'Rabenhaubt witbier (=Watou''s wit bier)', 113, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1093, N'Rafexport', 28, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1094, N'Raisinoise', 64, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1096, N'Ras super pils (=Pax pils)', 103, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1101, N'Redor pils', 37, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1102, N'Regain (blanche)', 91, 53, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1103, N'Regal (Saison)', 17, 45, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1104, N'Regal christmas', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1105, N'Reinaert amber', 84, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1107, N'Reinaert tripel', 84, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1109, N'Rendux ambree', 3, 6, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1110, N'Rendux brune', 3, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1111, N'Reserve Marie de Hongrie', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1112, N'Reserve Marie de Hongrie speciale Noel', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1113, N'Retro oude methode', 56, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1114, N'Ridder', 65, 8, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1115, N'Rijsel triple beer ambree (=Piraat)', 14, 21, CAST(11 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1116, N'Riva baviere', 87, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1117, N'Riva bruine speciale', 87, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1118, N'Riva pils', 87, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1119, N'Riva triple abdij', 87, 59, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1120, N'Roberg classic', 88, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1121, N'Roberg dark', 88, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1122, N'Roberg junior', 88, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1123, N'Rochefort 6', 89, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1124, N'Rochefort 8', 89, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1125, N'Rochefort 10', 89, 36, CAST(11 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1126, N'Rochefortoise ambree', 90, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1127, N'Rochefortoise blonde', 90, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1129, N'Rochelle', 13, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1130, N'Rochus', 95, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1131, N'Rocs (Abbaye des)', 91, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1133, N'Rocs speciale noel (Abbaye des)', 91, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1134, N'Rodenbach', 92, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1135, N'Rodenbach grand cru', 92, 62, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1136, N'Roman (Special)', 93, 61, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1137, N'Roman bleek', 93, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1138, N'Roman bruin', 93, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1139, N'Roman dobbelen bruinen', 93, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1140, N'Roman export', 93, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1141, N'Roman Oudenaards', 93, 61, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1142, N'Romy luxe', 93, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1143, N'Romy pils', 93, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1144, N'Ronsies Bommelsbier (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1145, N'Roosenberg (Abdij) (=Bornem tripel)', 14, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1146, N'Rose de Gambrinus', 22, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1147, N'Royal pils (=Riva pils)', 87, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1148, N'Royal type ale', 125, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1149, N'Royale blonde', 98, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1150, N'Rubbel sexy lager', 56, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1151, N'Rubens gold', 111, 33, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1152, N'Rubens rood', 17, 53, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1153, N'S-pils', 112, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1154, N'Safir', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1156, N'Samson (L''ambree du)', 72, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1157, N'Samwell pils (=Haacht pils)', 51, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1158, N'San Michael triple', 56, 59, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1159, N'Sanctus', 74, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1162, N'Sas export', 65, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1163, N'Sas pils', 65, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1164, N'Sasbrau', 65, 13, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1168, N'Saxo', 23, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1169, N'Scaldienne', 43, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1170, N'Schaerbeekoise', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1171, N'Schavuit dubbel (=Bornem dubbel)', 14, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1172, N'Schavuit tripel (=Bornem tripel)', 14, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1174, N'Schrans pater (De)', 56, 51, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1175, N'Schulten Brau', 70, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1177, N'Seigneurie  (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1179, N'Serclaes (t'')', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1180, N'Sernia bock', 58, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1181, N'Sernia brune (=C.T.S. Scotch)', 6, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1182, N'Sernia pils', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1183, N'Setz brau', 6, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1185, N'Sexy dubbel lager', 120, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1186, N'Sezoens blond', 70, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1187, N'Sezoens Europe', 70, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1188, N'Sezoens quattro', 70, 5, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1189, N'Sherry Poesy old Beersel', 116, 55, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1191, N'Shopping (Blanche du) (=Charleroi (Blanche de))', 21, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1192, N'SI Boune blonde (=Moine (triple))', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1193, N'Si Boune brune (=St. Benoit brune)', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1194, N'Silbrau dort urtyp', 98, 13, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1196, N'Silly (Bock)', 98, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1197, N'Silly (Saison)', 98, 45, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1198, N'Silly (Scotch)', 98, 46, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1199, N'Silly pils', 98, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1200, N'Silly triple bock', 98, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1201, N'Sinaaise bok (=Bornem tripel)', 14, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1202, N'Sinpalsken', 84, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1203, N'Sioen Maeseycker kloosterbier', 14, 36, CAST(11 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1206, N'Ski-rodt biermuseum blonde (=St. Benoit blonde)', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1207, N'Ski-rodt biermuseum brune (=St. Benoit brune)', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1208, N'Slag lager pils', 99, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1209, N'Slaghmuylder''s kerstbier', 99, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1210, N'Slaghmuylder''s oud bier', 99, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1211, N'Slaghmuylder''s paasbier', 99, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1212, N'Slaghmuylder''s tafel hell', 99, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1213, N'Slijtersbier', 126, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1214, N'Sloeber', 93, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1216, N'Slypke  (=Kapittel pater (Het))', 113, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1217, N'Smisje banaan (''t)', 86, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1218, N'Smisje dubbel (''t)', 86, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1219, N'Smisje honingbier blond (''t)', 86, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1220, N'Smisje honingbier donker (''t)', 86, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1221, N'Smokkelaar (De) (=St. Paul triple)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1222, N'Snoek (=Vlotbier)', 32, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1223, N'Soleilmont double', 64, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1225, N'Soy (Blanche de)', 44, 53, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1226, N'Spar pils', 2, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1227, N'Sparta pils', 14, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1228, N'Spijtighen spelduvel (Den)', 98, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1229, N'St. Adriaan kruikenbier dark (=St. Sebastiaan dark)', 105, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1230, N'St. Adriaan kruikenbier grand cru (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1231, N'St. Adriaans kerstbier', 33, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1232, N'St. Adriaansbier', 33, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1234, N'St. Amandus blond Kortenbergs abdijbier', 30, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1235, N'St. Amandus bruin Kortenbergs abdijbier', 30, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1236, N'St. Arnoldus triple (=Riva triple abdij)', 87, 59, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1237, N'St. Benoit blonde', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1238, N'St. Benoit brune', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1239, N'St. Benoit brune (brassin special)', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1240, N'St. Benoit triple', 17, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1241, N'St. Bernardus abt 12', 101, 21, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1242, N'St. Bernardus blond', 101, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1243, N'St. Bernardus pater 6', 101, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1244, N'St. Bernardus prior 8', 101, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1245, N'St. Bernardus triple', 101, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1246, N'St. Berthuin brune', 64, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1247, N'St. Christophe blonde (=Villers-St. Ghislain blonde (Speciale))', 98, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1248, N'St. Christophe brune (=Villers Saint-Ghislain brune (Speciale))', 98, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1249, N'St. Denise dark (=St. Sebastiaan dark)', 105, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1250, N'St. Denise grand cru (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1252, N'St. Feuillien blonde 1,5 l', 46, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1254, N'St. Feuillien brune 1,5 l', 46, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1256, N'St. Feuillien cuvee de noel (=Affligem christmas ale)', 100, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1257, N'St. Ghislain (Abbaye de) (=Beloeil (La biere de))', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1259, N'St. Hermes abdijbier', 26, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1261, N'St. Hubert', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1264, N'St. Idesbald blond', 56, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1265, N'St. Idesbald bruin', 56, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1266, N'St. Idesbald triple', 56, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1267, N'St. Jozef kriekenbier', 103, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1268, N'St. Lamvinus', 22, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1269, N'St. Laurent double (=St. Paul double)', 105, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1270, N'St. Laurent triple (=St. Paul triple)', 105, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1271, N'St. Leger (=Floreffe blonde)', 64, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1272, N'St. Lenderik', 91, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1273, N'St. Louis cassis kir royal', 114, 64, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1274, N'St. Louis framboise', 114, 64, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1275, N'St. Louis gueuze fond tradition lambic', 114, 65, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1276, N'St. Louis gueuze lambic', 114, 64, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1277, N'St. Louis kriek lambic', 114, 64, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1278, N'St. Louis peche lambic', 114, 64, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1279, N'St. Monon ambree', 3, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1281, N'St. Paul blond', 105, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1282, N'St. Paul double', 105, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1283, N'St. Paul special', 105, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1284, N'St. Paul triple', 105, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1285, N'St. Quentin (Blanche de)', 72, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1286, N'St. Quentin (Brune de)', 72, 14, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1287, N'St. Quentin (Brune de) (=St. Benoit brune (brassin special))', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1288, N'St. Quirin blonde  (=Fakir)', 13, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1289, N'St. Quirin brune  (=Reserve Marie de Hongrie)', 13, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1290, N'St. Sebastiaan dark', 105, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1292, N'St. Sebastiaan grand cru', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1294, N'St.-Gabriel', 44, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1295, N'Stadhuis Lommel (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1296, N'Star blond', 51, 2, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1297, N'Star bruin', 51, 2, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1298, N'Steedje kerstbier', 104, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1299, N'Steedje special', 104, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1300, N'Steedje tripel', 104, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1302, N'Steenbrugge blonde (Abdij)', 50, 33, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1303, N'Steenbrugge dubbel (Abdij)', 50, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1304, N'Steenbrugge tripel (Abdij)', 50, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1305, N'Steendonk Brabants witbier', 81, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1306, N'Steenezel (=Piraat)', 14, 21, CAST(11 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1309, N'Steinbrau pils', 70, 42, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1310, N'Stella Artois', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1311, N'Stella Artois dry', 6, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1312, N'Stella Artois light', 6, 34, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1313, N'Stella Artois NA', 6, 3, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1314, N'Ster ale', 105, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1316, N'Stille Nacht', 32, 36, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1317, N'Stoeren Bonk blond (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1318, N'Stoeren Bonk donker (=Bornem dubbel)', 14, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1320, N'Stropken', 54, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1321, N'Strubbe export', 107, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1322, N'Strubbe faro', 107, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1324, N'Strubbe oud bier', 107, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1325, N'Strubbe pilsen', 107, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1326, N'Strubbe stout', 107, 49, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1327, N'Student', 64, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1328, N'Suma pils (=Sas pils)', 65, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1329, N'Super 64', 98, 33, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1330, N'Super brune', 48, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1331, N'Super des Fagnes (=Moine (triple))', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1333, N'Super Houblo (=Bonne Esperance (Abbaye de))', 64, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1334, N'Super pils', 107, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1335, N'Supra pils (=Safir)', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1336, N'Taupe (Biere de la) (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1337, N'Taverne ''t Brughuis - Muizen (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1338, N'Taverne Old Time - Veltem (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1339, N'Tea beer', 67, 31, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1340, N'Ter Dolen', 34, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1341, N'Ter Dolen winterbier', 34, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1343, N'Teugelbier', 107, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1345, N'Thimougienne', 15, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1346, N'Thouroutenaere (=Hapkin)', 68, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1348, N'Tielts Tanneke (=Brunehaut villages blond)', 21, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1349, N'Tilffoise', 76, 6, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1350, N'Timmermans blanche-wit lambic', 108, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1351, N'Timmermans cassis lambic', 108, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1352, N'Timmermans faro lambic', 108, 19, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1353, N'Timmermans framboise lambic', 108, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1354, N'Timmermans gueuze caveau', 108, 22, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1355, N'Timmermans gueuze lambic', 108, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1356, N'Timmermans kriek lambic', 108, 31, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1357, N'Timmermans lambic', 108, 56, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1358, N'Timmermans Lambicus', 108, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1359, N'Timmermans peche lambic', 108, 31, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1365, N'Toine  (=St. Benoit blonde)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1366, N'Toison d''or (triple)', 4, 59, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1367, N'Tongerlo christmas', 51, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1369, N'Tongerlo dubbel', 51, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1370, N'Tongerlo dubbel blond', 14, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1371, N'Tongerlo tripel', 51, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1372, N'Tonneke', 28, 6, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1373, N'Topmolen - Balen (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1374, N'Torque de Frasnes', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1377, N'Tourtel malt', 2, 3, CAST(0 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1379, N'Tradition des Moines blonde (=St. Benoit blonde)', 17, 33, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1380, N'Tradition des Moines brune (=St. Benoit brune)', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1381, N'Trammelantbier', 107, 15, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1383, N'Tremeloos Damiaanbier', 14, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1384, N'Trial', 69, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1385, N'Tricentenaire  (=St. Benoit blonde)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1388, N'Triplor (family''s beer)', 93, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1389, N'Troetsel-Niel pils (De)', 65, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1390, N'Troublette', 23, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1391, N'Tuborg', 6, 42, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1392, N'Tull bier', 103, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1393, N'Turf (Nen) (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1394, N'TV bier', 125, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1396, N'Ulricher lager', 49, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1397, N'Unic-bier', 48, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1400, N'Upper 19', 125, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1401, N'Vaartlander 25cl & vat', 122, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1402, N'Vaartlander 75cl', 122, 21, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1403, N'Vache (Biere) (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1404, N'Val d''Heure blonde 25 cl (=Regal (Saison))', 17, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1405, N'Val d''Heure blonde 75cl (=Moine (triple))', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1406, N'Val d''Heure brune 25cl (=St. Benoit brune)', 17, 14, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1407, N'Val d''Heure brune 75cl (=St. Benoit brune (brassin special))', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1409, N'Val St. Lambert (Abbaye de) (=Moine (triple))', 17, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1410, N'Val-Dieu (Triple de) (=Brigand)', 114, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1413, N'Vander Linden faro', 115, 54, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1414, N'Vander Linden frambozenbier', 115, 55, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1415, N'Vander Linden lambik', 115, 56, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1419, N'Vapeur legere', 117, 8, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1420, N'Vapeur rousse', 117, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1421, N'Vedett (=Bel pils)', 74, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1422, N'Vega pils', 58, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1423, N'Veltems kruikje (''t) grand cru (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1425, N'Vera dubbel blond', 118, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1426, N'Vera export', 118, 42, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1427, N'Vera ouden bruinen', 118, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1428, N'Vera pils', 118, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1429, N'Vera special', 118, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1430, N'Verabrau urtyp', 118, 13, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1432, N'Verhaeghe echte kriek', 118, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1433, N'Verhaeghe triple blond', 118, 51, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1434, N'Verlinden extra bruin', 56, 51, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1435, N'Verlinden special blond', 56, 51, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1436, N'Verne en folie  (=Vapeur en folie )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1437, N'Verne rousse  (=Vapeur rousse )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1438, N'Verrebroekse Flip (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1439, N'Verte (tripel)', 107, 59, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1440, N'Very Diest', 51, 51, CAST(1 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1441, N'Vezonnoise  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1442, N'Vi Keute di Nameur blonde (=Floreffe blonde)', 64, 33, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1443, N'Vi Keute di Nameur brune (=St. Benoit brune (brassin special))', 17, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1444, N'Vichtenaar', 118, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1446, N'Vieille Bon-Secours blonde', 24, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1448, N'Vieille des Estinnes', 37, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1449, N'Vieille Salme', 1, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1450, N'Vieillotte du Hurlevent  (=Moinette blonde)', 37, 15, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1451, N'Vieux Bruges blanche (=Vlaamsch wit)', 114, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1452, N'Vieux Bruges framboise (=St. Louis framboisee)', 114, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1453, N'Vieux Bruges gueuze lambic (=St. Louis gueuze lambic)', 114, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1454, N'Vieux Bruges kriek lambic (=St. Louis kriek lambic)', 114, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1455, N'Vieux Bruxelles gueuze lambic (=St. Louis gueuze lambic)', 114, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1456, N'Vieux Bruxelles kriek lambic (=Wieze kriek lambic)', 125, 22, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1457, N'Vieux Foudre faro', 115, 54, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1458, N'Vieux Foudre gueuze', 115, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1459, N'Vieux Foudre kriek', 115, 55, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1460, N'Vieux Temps', 6, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1462, N'Viking (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1463, N'Vile Cinse (=St. Benoit brune)', 17, 18, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1467, N'Villers dubbel amber', 120, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1468, N'Villers Saint-Ghislain blonde (Speciale)', 98, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1469, N'Villers Saint-Ghislain brune (Speciale)', 98, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1470, N'Villers triple', 120, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1472, N'Vitus spezialbier (=Villers Saint-Ghislain brune (Speciale))', 98, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1473, N'Vive vie  (=Mengsel La Folie/Saison de Pipaix)', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1474, N'Vlaamsch wit', 114, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1475, N'Vleteren alt', 30, 5, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1476, N'Vleteren super 8', 30, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1478, N'Vondel', 87, 36, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1480, N'Waas klokbier tripel', 18, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1482, N'Waase witte', 18, 53, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1484, N'Walrave export (=Pick-up pils)', 121, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1485, N'Walrave extra tafelbier', 121, 51, CAST(3 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1488, N'Wastobbeke (=Couckelaerschen Doedel)', 107, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1489, N'Watermolen (Balen) (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1490, N'Watneys red barrel', 111, 4, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1491, N'Watneys scotch', 111, 46, CAST(7 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1492, N'Watou''s wit bier', 113, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1493, N'Wellington red lion (=Watneys red barrel)', 111, 4, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1494, N'Wellington scotch ale (=Watneys scotch)', 111, 46, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1495, N'Wentelkriek (=Boon kriek)', 19, 55, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1497, N'West pils (=Sas pils)', 65, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1499, N'Westmalle dubbel', 123, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1500, N'Westmalle tripel', 123, 59, CAST(9 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1501, N'Westvleteren 12', 124, 36, CAST(11 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1502, N'Westvleteren 4', 124, 8, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1503, N'Westvleteren 6', 124, 14, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1504, N'Westvleteren 8', 124, 36, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1505, N'Wevelgemse tripel', 85, 59, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1507, N'Whitbread extra stout', 6, 49, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1508, N'Whitbread pale ale', 6, 4, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1509, N'Wiel''s (=Safir)', 6, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1510, N'Wieze christmas', 125, 14, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1511, N'Wieze export (=Wieze pils)', 125, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1512, N'Wieze kriek lambic', 125, 60, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1513, N'Wieze pils', 125, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1514, N'Wieze scotch 1866', 125, 46, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1516, N'Wilson mild stout', 14, 49, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1517, N'Witkap pater dubbele pater', 99, 14, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1518, N'Witkap pater stimulo', 99, 33, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1519, N'Witkap pater tripel', 99, 59, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1521, N'Wittekop (=Dentergems witbier - Riva blanche)', 87, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1522, N'Woise  (=Vapeur en folie )', 117, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1524, N'Wonder premium light beer', 74, 34, CAST(2 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1525, N'XX Bitter', 85, 11, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1526, N'Yersekes mosselbier', 14, 18, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1527, N'Yperman', 65, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1528, N'Yves pils (=Super pils)', 107, 42, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1529, N'Zaal Kapelhof - Rillaar (=St. Sebastiaan grand cru)', 105, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1530, N'Zafke (Blanche du) (=Student)', 64, 53, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1531, N'Zandberg brau', 118, 13, CAST(4 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1532, N'Zatte Bie (De)', 12, 36, CAST(10 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1533, N'Zedelgemse Martelaar (=Dikke Mathile)', 107, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1534, N'Zelfde (''t)', 20, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1535, N'Zerewever (=Gapers bier)', 118, 18, CAST(7 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1537, N'Zotskap (=Pater Lieven)', 112, 18, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1538, N'Zottegemse grand cru', 29, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1539, N'Zulte', 2, 62, CAST(5 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1540, N'Zwarte Flesch (=Lamoral Degmont)', 112, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1541, N'Zwijntje (=Augustijn)', 14, 15, CAST(8 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1542, N'Zwintje', 74, 6, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)))
GO
INSERT [dbo].[tblCPBeer] ([intIdBeer], [strBeerName], [intBrewerId], [intKindOfBeerId], [decAlcohol], [decPrice]) VALUES (1543, N'Zwoele Berten (=Bornem dubbel)', 14, 14, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[tblCPBeer] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPBrewer] ON 
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (1, N'Achouffe', N'Route du Village 32 a', N'6666', N'Achouffe-Wibrin', 10000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (2, N'Alken', N'Stationstraat 2', N'3570', N'Alken', 950000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (3, N'Ambly', N'Rue Principale 45', N'6953', N'Ambly-Nassogne', 500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (4, N'Anker', N'Guido Gezellelaan 49', N'2800', N'Mechelen', 3000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (6, N'Artois', N'Vaartstraat 94', N'3000', N'Leuven', 4000000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (8, N'Bavik', N'Rijksweg 33', N'8531', N'Bavikhove', 110000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (9, N'Belle Vue - Molenbeek', N'Henegouwenkaai 33', N'1080', N'Sint-Jans-Molenbeek', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (10, N'Belle Vue - Zuun', N'Steenweg naar Bergen', N'1600', N'Sint- Pieters-Leeuw', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (11, N'Belle Vue', N'Delaunoy-straat 58-60', N'1080', N'Sint-Jans-Molenbeek', 300000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (12, N'Bie (De)', N'Stoppelweg 26', N'8978', N'Watou', 280)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (13, N'Binchoise', N'Faubourg St. Paul 38', N'7130', N'Binche', 700)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (14, N'Bios', N'Lindenlaan 25', N'9940', N'Ertvelde', 40000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (15, N'Blaugies', N'Rue de la Frontiere 435', N'7370', N'Blaugies', 280)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (17, N'Bocq', N'Rue de la Brasserie 4', N'5530', N'Purnode', 60000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (18, N'Boelens', N'Kerkstraat 7', N'9111', N'Belsele', 300)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (19, N'Boon', N'Fonteinstraat 65', N'1502', N'Lembeek', 2350)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (20, N'Bosteels', N'Kerkstraat 92', N'9255', N'Buggenhout', 50000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (21, N'Brunehaut', N'Rue des Panneries 17', N'7623', N'Brunehaut', 3800)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (22, N'Cantillon', N'Gheudestraat 56', N'1070', N'Anderlecht', 850)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (23, N'Caracole', N'Cote Marie-Therese 86', N'5500', N'Falmignoul', 350)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (24, N'Caulier', N'Rue Sondeveille 134', N'7600', N'Peruwelz', 1500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (25, N'Chimay', N'Rue de la Trappe 294', N'6464', N'Forges-les-Chimay', 100000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (26, N'Clarysse', N'Krekelput 16-18', N'9700', N'Oudenaarde', 15000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (27, N'Cnudde', N'Fabriekstraat 8', N'9700', N'Eine', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (28, N'Contreras', N'Molenstraat 115', N'9890', N'Gavere', 2000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (29, N'Crombe', N'Hospitaalstraat 10', N'9620', N'Zottegem', 1000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (30, N'Deca', N'Elverdingestraat 4', N'8640', N'Woesten-Vleteren', 10000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (32, N'Dolle Brouwers', N'Roeselarestraat 12b', N'8600', N'Esen- Diksmuide', 1200)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (33, N'Domus', N'Tiensestraat 8', N'3000', N'Leuven', 1000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (34, N'Dool', N'Eikendreef 21', N'3530', N'Helchteren', 1500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (35, N'Drie Fonteinen', N'H. Teirlinckplein 3', N'1650', N'Beersel', 180)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (36, N'Dubuisson', N'Chaussee de Mons 28', N'7904', N'Pipaix', 15840)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (37, N'Dupont', N'Rue Basse 5', N'7904', N'Tourpes-Leuze', 6000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (38, N'Duwac', N'Rue des Rossignols 20', N'7700', N'Mouscron', 900)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (39, N'Duysters', N'Michel Theysstraat 58 a', N'3290', N'Diest', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (40, N'Ellezelloise', N'Guinaumont 75', N'7890', N'Ellezelles', 1000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (41, N'Eupener', N'Paveestrasse 12-14', N'4700', N'Eupen', 20000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (42, N'Eylenbosch - Maes', N'Ninoofsesteenweg 5', N'1703', N'Schepdaal', 12000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (43, N'Facon', N'Kwabrugstraat 27', N'8510', N'Bellegem', 8000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (44, N'Fantome', N'Rue Preal 8', N'6997', N'Soy', 900)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (45, N'Ferme au Chene', N'Rue Comte d''Ursel 36', N'6940', N'Durbuy', 100)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (46, N'Friart', N'Rue d'' Houdeng 20', N'7070', N'Le Roeulx', 18000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (47, N'Gaverhopke', N'Steenbrugstraat 187', N'8530', N'Harelbeke- Stasegem', 800)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (48, N'Gigi', N'Grand rue 96', N'6769', N'Gerouville', 4000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (49, N'Girardin', N'Lindenberg 10', N'1700', N'Sint-Ulriks-Kapelle', 3900)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (50, N'Gouden Boom', N'Langestraat 45', N'8000', N'Brugge', 20000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (51, N'Haacht', N'Provinciesteenweg 28', N'3190', N'Boortmeerbeek', 1100000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (53, N'Hanssens', N'Vroenenbosstraat 15', N'1653', N'Dworp', 500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (54, N'Hopduvel', N'Coupure links 625', N'9000', N'Gent', 550)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (55, N'Hopperd', N'Matestraat 7', N'2230', N'Ramsel', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (56, N'Huyghe', N'Brusselsesteenweg 282', N'9090', N'Melle', 50000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (57, N'John Martin', N'Rue du Cerf 191', N'1332', N'Genval', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (58, N'Jupiler', N'Rue de Vise 243', N'4020', N'Jupille-sur-Meuse', 2200000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (59, N'K.I.H.O.', N'Gebroeders de Smetstraat 1', N'9000', N'Gent', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (60, N'Keersmaeker (De)', N'Lierput 1', N'1730', N'Kobbegem', 60000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (62, N'Koninck - Antwerpen (De)', N'Mechelsesteenweg 291', N'2018', N'Antwerpen', 140000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (64, N'Lefebvre', N'Rue de Croly 54', N'1430', N'Quenast', 15000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (65, N'Leroy', N'Diksmuideseweg 406', N'8904', N'Boezinge', 32000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (66, N'Liefmans', N'Aalststraat 200', N'9700', N'Oudenaarde', 10000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (67, N'Lindemans', N'Lenniksebaan 1479', N'1602', N'Vlezenbeek', 19000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (68, N'Louwaege', N'Markt 14', N'8610', N'Kortemark', 22000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (69, N'Maes', N'Waarloosveld 10', N'2550', N'Waarloos', 1150000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (70, N'Martens', N'Reppelerweg 1', N'3950', N'Bocholt', 600000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (71, N'Meesters', N'Hoogstraat 50', N'1570', N'Galmaarden', 160)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (72, N'Mibrana', N'Place de la station 2', N'5000', N'Namur', 380)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (73, N'Miroir', N'Koningin Astridplein 24-26', N'1090', N'Jette', 100)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (74, N'Moortgat', N'Breendonkdorp 58', N'2870', N'Breendonk-Puurs', 250000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (75, N'Old Bailey', N'Kerkplein 5', N'8880', N'St.-Eloois-Winkel', 1200)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (76, N'Oleye', N'Rue d''Elmette 39', N'4300', N'Oleye-Waremme', 200)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (78, N'Orval', N'Orval 2', N'6823', N'Villers-devant-Orval', 37000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (79, N'Paeleman', N'Boekakker 1', N'9230', N'Wetteren', 350)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (80, N'Pakhuis', N'Vlaamse kaai 76', N'2000', N'Antwerpen', 1200)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (81, N'Palm', N'Steenhuffeldorp 3', N'1840', N'Steenhuffel', 530000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (82, N'Pater Van Damme', N'Jacob Van Maerlantstraat 2', N'8340', N'Damme', 7)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (83, N'Praile', N'Rue de la Praile 3', N'7120', N'Peissant', 24)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (84, N'Proefbrouwerij', N'Smalle Heerweg 78', N'9080', N'Lochristi', 500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (85, N'Ranke', N'Brugstraat 43', N'8560', N'Wevelgem', 100)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (86, N'Regenboog', N'Astridlaan 134', N'8310', N'Assebroek-Brugge', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (87, N'Riva', N'Wontergemstraat 42', N'8720', N'Dentergem', 115000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (88, N'Roberg', N'Rodebergstraat 46', N'8954', N'Westouter', 1000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (89, N'Rochefort', N'Rue de l''abbaye 8', N'5580', N'Rochefort', 15000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (90, N'Rochefortoise', N'Rue du Treux 43b', N'5580', N'Eprave', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (91, N'Rocs', N'Chaussee Brunehaut 37', N'7387', N'Montignies-sur-Roc', 500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (92, N'Rodenbach', N'Spanjestraat 133', N'8800', N'Roeselare', 150000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (93, N'Roman', N'Hauwaert 61', N'9700', N'Oudenaarde-Mater', 100000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (94, N'Ruwet', N'Rue Victor Besme 27', N'4800', N'Verviers', 100)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (95, N'Ryck (De)', N'Kerkstraat 28', N'9550', N'Herzele', 6000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (96, N'Schuur', N'Gobbelsrode 75', N'3220', N'Kortrijk-Dutsel', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (97, N'Silenrieux', N'Rue Noupre 1', N'5630', N'Silenrieux', 500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (98, N'Silly', N'Ville Basse A 141', N'7830', N'Silly', 12000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (99, N'Slaghmuylder', N'Denderhoutembaan 2', N'9400', N'Ninove', 6500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (100, N'Smedt (De)', N'Ringlaan 18', N'1745', N'Opwijk', 50000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (101, N'St. Bernardus', N'Trappistenweg 23', N'8978', N'Watou', 13000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (102, N'St. Guibert', N'Rue de Riquau 1', N'1435', N'Mont-Saint-Guibert', 350000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (103, N'St. Jozef', N'Itterplein 19', N'3960', N'Opitter', 65000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (104, N'Steedje', N'Schoolstraat 45b', N'8460', N'Ettelgem', 1000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (105, N'Sterkens', N'Meerdorp 20', N'2321', N'Meer', 8613)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (106, N'Straffe Hendrik', N'Walplein 26', N'8000', N'Brugge', 5800)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (107, N'Strubbe', N'Markt 1', N'8480', N'Ichtegem', 20000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (108, N'Timmermans', N'Kerkstraat 11', N'1701', N'Itterbeek', 10000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (109, N'Tour', N'Rue Chera 9', N'4180', N'Comblain-la-Tour', 240)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (110, N'Troch (De)', N'Langestraat 20', N'1741', N'Ternat-Wambeek', 3500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (111, N'Union', N'Rue Derbeque 7', N'6040', N'Jumet', 200000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (112, N'Van Den Bossche', N'Sint-Lievensplein 16', N'9550', N'Sint- Lievens-Esse', 1700)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (113, N'Van Eecke', N'Douvieweg 2', N'8978', N'Watou', 10000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (114, N'Van Honsebrouck', N'Oostrozebekestraat 43', N'8770', N'Ingelmunster', 80000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (115, N'Vander Linden', N'Brouwerijstraat 2', N'1500', N'Halle', 2000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (116, N'Vandervelden Henri', N'Laarheidestraat 230', N'1650', N'Beersel', 500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (117, N'Vapeur', N'Rue de Marechal 1', N'7904', N'Pipaix-Leuze', 1000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (118, N'Verhaeghe', N'Beukenhofstraat 96', N'8570', N'Vichte', 7200)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (119, N'Vervifontaine', N'xxx', N'0', N'fontaine-Jalhay', 0)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (120, N'Villers', N'Liezeledorp 37', N'2870', N'Liezele-Puurs', 1450)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (121, N'Walrave', N'Lepelstraat 36', N'9270', N'Laarne', 2500)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (122, N'Weldebroec', N'Mechelse Steenweg 53', N'2830', N'Willebroek', 800)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (123, N'Westmalle', N'Antwerpsesteenweg 496', N'2390', N'Malle', 125000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (124, N'Westvleteren', N'Donkerstraat 12', N'8640', N'Westvleteren', 4000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (125, N'Wieze', N'Nieuwstraat 1', N'9280', N'Wieze', 120000)
GO
INSERT [dbo].[tblCPBrewer] ([intIdBrewer], [strBrewerName], [strBrewerAddress], [strBrewerZipCode], [strBrewerCity], [intBrewerProduction]) VALUES (126, N'Zwingel', N'Damweg 6', N'8530', N'Harelbeke', 250)
GO
SET IDENTITY_INSERT [dbo].[tblCPBrewer] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPKindOfBeer] ON 
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (2, N'Alcoholarm')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (3, N'Alcoholvrij')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (4, N'Ale')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (5, N'Alt')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (6, N'Amber')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (8, N'Bierette')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (11, N'Bitter')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (12, N'Donkerbok')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (13, N'Dort')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (14, N'Dubbel Donker')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (15, N'Edelbier')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (18, N'Extra')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (19, N'Faro')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (21, N'Gerstewijn')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (22, N'Geuze')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (25, N'Helderbok')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (26, N'IJsbier')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (31, N'Lambik')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (33, N'Lichtblond')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (34, N'Light')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (35, N'Mars')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (36, N'Massieve Ale')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (42, N'Pils')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (44, N'Rookbier')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (45, N'Saison')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (46, N'Scotch')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (49, N'Stout')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (51, N'Tafelbier')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (53, N'Tarwebier of witbier')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (54, N'Traditionele Faro')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (55, N'Traditionele Geuze')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (56, N'Traditionele Lambik')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (59, N'Tripel')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (60, N'Versnijbier')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (61, N'Vlaams Bruin')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (62, N'Vlaams Rood')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (64, N'West-Vlaamse Geuze')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (65, N'West-Vlaamse spontane Geuze')
GO
INSERT [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer], [strKindOfBeerDescription]) VALUES (67, N'')
GO
SET IDENTITY_INSERT [dbo].[tblCPKindOfBeer] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPUser] ON 
GO
INSERT [dbo].[tblCPUser] ([intIdUser], [strFirstName], [strLastName], [strEmailAddress], [dtmBirth], [intFavouriteBeerId]) VALUES (1, N'Vincent', N'Van De Walle', N'vincent@copypaste.be', CAST(N'1970-05-06' AS Date), NULL)
GO
SET IDENTITY_INSERT [dbo].[tblCPUser] OFF
GO
ALTER TABLE [dbo].[tblCPBeer]  WITH CHECK ADD  CONSTRAINT [FK_tblCPBeer_tblCPBrewer] FOREIGN KEY([intBrewerId])
REFERENCES [dbo].[tblCPBrewer] ([intIdBrewer])
GO
ALTER TABLE [dbo].[tblCPBeer] CHECK CONSTRAINT [FK_tblCPBeer_tblCPBrewer]
GO
ALTER TABLE [dbo].[tblCPBeer]  WITH CHECK ADD  CONSTRAINT [FK_tblCPBeer_tblCPKindOfBeer] FOREIGN KEY([intKindOfBeerId])
REFERENCES [dbo].[tblCPKindOfBeer] ([intIdKindOfBeer])
GO
ALTER TABLE [dbo].[tblCPBeer] CHECK CONSTRAINT [FK_tblCPBeer_tblCPKindOfBeer]
GO
ALTER TABLE [dbo].[tblCPUser]  WITH CHECK ADD  CONSTRAINT [FK_tblCPUser_tblCPBeer] FOREIGN KEY([intFavouriteBeerId])
REFERENCES [dbo].[tblCPBeer] ([intIdBeer])
GO
ALTER TABLE [dbo].[tblCPUser] CHECK CONSTRAINT [FK_tblCPUser_tblCPBeer]
GO
USE [master]
GO
ALTER DATABASE [cpBeerAndUser] SET  READ_WRITE 
GO
