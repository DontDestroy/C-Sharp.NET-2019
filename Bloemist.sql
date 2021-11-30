USE [master]
GO
/****** Object:  Database [Bloemist]    Script Date: 30/11/2021 07:29:30 ******/
CREATE DATABASE [Bloemist]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Plantv', FILENAME = N'S:\Data\Bloemist.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Plantv_log', FILENAME = N'S:\Data\Bloemist_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Bloemist] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bloemist].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bloemist] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bloemist] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bloemist] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bloemist] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bloemist] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bloemist] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Bloemist] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bloemist] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bloemist] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bloemist] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bloemist] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bloemist] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bloemist] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bloemist] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bloemist] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bloemist] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bloemist] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bloemist] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bloemist] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bloemist] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bloemist] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bloemist] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bloemist] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bloemist] SET  MULTI_USER 
GO
ALTER DATABASE [Bloemist] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bloemist] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bloemist] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bloemist] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bloemist] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bloemist] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bloemist] SET QUERY_STORE = OFF
GO
USE [Bloemist]
GO
/****** Object:  Table [dbo].[Bestelling]    Script Date: 30/11/2021 07:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bestelling](
	[BestelNummer] [varchar](4) NOT NULL,
	[LeverancierCode] [varchar](3) NULL,
	[BestelDatum] [datetime] NULL,
	[LeverDatum] [datetime] NULL,
	[Bedrag] [decimal](15, 5) NULL,
 CONSTRAINT [PK_Bestelling] PRIMARY KEY CLUSTERED 
(
	[BestelNummer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BestelRegel]    Script Date: 30/11/2021 07:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BestelRegel](
	[BestelNummer] [varchar](4) NOT NULL,
	[ArtikelCodeLeverancier] [varchar](5) NOT NULL,
	[Aantal] [decimal](15, 5) NULL,
	[BestelRegelPrijs] [decimal](15, 5) NULL,
 CONSTRAINT [PK_BestelRegel] PRIMARY KEY CLUSTERED 
(
	[BestelNummer] ASC,
	[ArtikelCodeLeverancier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Leverancier]    Script Date: 30/11/2021 07:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leverancier](
	[LeverancierCode] [varchar](3) NOT NULL,
	[LeverancierNaam] [varchar](20) NULL,
	[Adres] [varchar](25) NULL,
	[WoonPlaats] [varchar](15) NULL,
 CONSTRAINT [PK_Leverancier] PRIMARY KEY CLUSTERED 
(
	[LeverancierCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Offerte]    Script Date: 30/11/2021 07:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offerte](
	[LeverancierCode] [varchar](3) NOT NULL,
	[ArtikelCode] [varchar](3) NOT NULL,
	[ArtikelCodeLeverancier] [varchar](5) NULL,
	[LeverTijd] [decimal](15, 5) NULL,
	[OffertePrijs] [decimal](15, 5) NULL,
 CONSTRAINT [PK_Offerte] PRIMARY KEY CLUSTERED 
(
	[LeverancierCode] ASC,
	[ArtikelCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plant]    Script Date: 30/11/2021 07:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plant](
	[ArtikelCode] [varchar](3) NOT NULL,
	[PlantenNaam] [varchar](16) NULL,
	[Soort] [varchar](7) NULL,
	[Kleur] [varchar](7) NULL,
	[Hoogte] [smallint] NULL,
	[BloeiBegin] [smallint] NULL,
	[BloeiEind] [smallint] NULL,
	[Prijs] [decimal](15, 5) NULL,
 CONSTRAINT [PK_Plant] PRIMARY KEY CLUSTERED 
(
	[ArtikelCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantCategorie]    Script Date: 30/11/2021 07:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantCategorie](
	[Categorie] [varchar](10) NOT NULL,
	[HoogteMinimum] [decimal](15, 5) NULL,
	[HoogteMaximum] [decimal](15, 5) NULL,
	[Afstand] [decimal](15, 5) NULL,
 CONSTRAINT [PK_PLSchema] PRIMARY KEY CLUSTERED 
(
	[Categorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0121', N'013', CAST(N'2021-01-17T00:00:00.000' AS DateTime), CAST(N'2021-01-31T00:00:00.000' AS DateTime), CAST(590.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0174', N'004', CAST(N'2021-02-25T00:00:00.000' AS DateTime), CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(117.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0175', N'004', CAST(N'2021-02-27T00:00:00.000' AS DateTime), CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(395.51000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0181', N'009', CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-27T00:00:00.000' AS DateTime), CAST(577.22000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0184', N'022', CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-16T00:00:00.000' AS DateTime), CAST(240.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0186', N'020', CAST(N'2021-03-11T00:00:00.000' AS DateTime), CAST(N'2021-03-18T00:00:00.000' AS DateTime), CAST(414.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0190', N'014', CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(659.84000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0191', N'013', CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(N'2021-03-27T00:00:00.000' AS DateTime), CAST(1211.41000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0192', N'035', CAST(N'2021-03-13T00:00:00.000' AS DateTime), CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(317.52000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0197', N'035', CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(N'2021-03-23T00:00:00.000' AS DateTime), CAST(928.27000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0200', N'004', CAST(N'2021-03-14T00:00:00.000' AS DateTime), CAST(N'2021-03-21T00:00:00.000' AS DateTime), CAST(72.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0201', N'004', CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(N'2021-04-02T00:00:00.000' AS DateTime), CAST(221.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0202', N'014', CAST(N'2021-03-26T00:00:00.000' AS DateTime), CAST(N'2021-04-05T00:00:00.000' AS DateTime), CAST(530.43000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0203', N'019', CAST(N'2021-04-01T00:00:00.000' AS DateTime), CAST(N'2021-04-15T00:00:00.000' AS DateTime), CAST(556.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0204', N'034', CAST(N'2021-04-01T00:00:00.000' AS DateTime), CAST(N'2021-04-15T00:00:00.000' AS DateTime), CAST(492.53000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Bestelling] ([BestelNummer], [LeverancierCode], [BestelDatum], [LeverDatum], [Bedrag]) VALUES (N'0206', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0121', N'A154', CAST(150.00000 AS Decimal(15, 5)), CAST(0.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0121', N'B006', CAST(150.00000 AS Decimal(15, 5)), CAST(0.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0121', N'B111', CAST(25.00000 AS Decimal(15, 5)), CAST(2.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0121', N'B396', CAST(50.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0121', N'E098', CAST(50.00000 AS Decimal(15, 5)), CAST(1.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0121', N'G202', CAST(25.00000 AS Decimal(15, 5)), CAST(6.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0174', N'A421', CAST(50.00000 AS Decimal(15, 5)), CAST(1.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0174', N'B148', CAST(25.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0174', N'B331', CAST(25.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0174', N'C274', CAST(25.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'A004', CAST(50.00000 AS Decimal(15, 5)), CAST(0.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'A075', CAST(250.00000 AS Decimal(15, 5)), CAST(0.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'A103', CAST(400.00000 AS Decimal(15, 5)), CAST(0.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'A184', CAST(50.00000 AS Decimal(15, 5)), CAST(0.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'A385', CAST(100.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'A421', CAST(50.00000 AS Decimal(15, 5)), CAST(0.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'B148', CAST(50.00000 AS Decimal(15, 5)), CAST(0.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'B331', CAST(10.00000 AS Decimal(15, 5)), CAST(0.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'B337', CAST(100.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'C274', CAST(25.00000 AS Decimal(15, 5)), CAST(0.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0175', N'D225', CAST(25.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0181', N'044', CAST(10.00000 AS Decimal(15, 5)), CAST(3.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0181', N'045', CAST(5.00000 AS Decimal(15, 5)), CAST(7.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0181', N'099', CAST(20.00000 AS Decimal(15, 5)), CAST(6.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0181', N'114', CAST(3.00000 AS Decimal(15, 5)), CAST(9.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0181', N'116', CAST(25.00000 AS Decimal(15, 5)), CAST(15.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0184', N'E-003', CAST(200.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0186', N'162', CAST(100.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0186', N'281', CAST(100.00000 AS Decimal(15, 5)), CAST(3.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0186', N'471', CAST(25.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'001-2', CAST(100.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'103-2', CAST(100.00000 AS Decimal(15, 5)), CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'118-V', CAST(200.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'209-V', CAST(25.00000 AS Decimal(15, 5)), CAST(1.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'255-1', CAST(200.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'263-V', CAST(50.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'281-2', CAST(25.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0190', N'393-V', CAST(20.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'A101', CAST(100.00000 AS Decimal(15, 5)), CAST(1.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'A103', CAST(1000.00000 AS Decimal(15, 5)), CAST(0.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'A154', CAST(100.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'A472', CAST(250.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'B101', CAST(50.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'B111', CAST(50.00000 AS Decimal(15, 5)), CAST(2.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'B396', CAST(50.00000 AS Decimal(15, 5)), CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'B578', CAST(10.00000 AS Decimal(15, 5)), CAST(11.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'C051', CAST(10.00000 AS Decimal(15, 5)), CAST(7.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'D029', CAST(15.00000 AS Decimal(15, 5)), CAST(6.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'D296', CAST(10.00000 AS Decimal(15, 5)), CAST(7.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'D742', CAST(25.00000 AS Decimal(15, 5)), CAST(2.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'E098', CAST(50.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'G001', CAST(25.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'G430', CAST(30.00000 AS Decimal(15, 5)), CAST(2.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0191', N'H510', CAST(40.00000 AS Decimal(15, 5)), CAST(1.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0192', N'ST1P1', CAST(100.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0192', N'ST2P1', CAST(25.00000 AS Decimal(15, 5)), CAST(1.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0192', N'ST3P2', CAST(24.00000 AS Decimal(15, 5)), CAST(5.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0192', N'ST4P5', CAST(12.00000 AS Decimal(15, 5)), CAST(0.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0197', N'ST1P9', CAST(50.00000 AS Decimal(15, 5)), CAST(3.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0197', N'ST2P1', CAST(25.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0197', N'ST2P6', CAST(50.00000 AS Decimal(15, 5)), CAST(2.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0197', N'ST3P1', CAST(36.00000 AS Decimal(15, 5)), CAST(4.85000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0197', N'ST4P1', CAST(48.00000 AS Decimal(15, 5)), CAST(8.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0197', N'ST4P5', CAST(24.00000 AS Decimal(15, 5)), CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0200', N'A004', CAST(25.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0200', N'A184', CAST(25.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0200', N'B148', CAST(25.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0200', N'B331', CAST(10.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'A004', CAST(25.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'A184', CAST(25.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'A385', CAST(25.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'A421', CAST(50.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'B148', CAST(25.00000 AS Decimal(15, 5)), CAST(0.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'B331', CAST(25.00000 AS Decimal(15, 5)), CAST(0.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'C274', CAST(25.00000 AS Decimal(15, 5)), CAST(0.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0201', N'D225', CAST(50.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0202', N'162-V', CAST(75.00000 AS Decimal(15, 5)), CAST(1.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0202', N'201-V', CAST(25.00000 AS Decimal(15, 5)), CAST(2.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0202', N'255-1', CAST(150.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0202', N'327-1', CAST(150.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0202', N'408-V', CAST(100.00000 AS Decimal(15, 5)), CAST(2.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0202', N'498-1', CAST(100.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0203', N'ALTH', CAST(25.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0203', N'CENT', CAST(50.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0203', N'CYNO', CAST(50.00000 AS Decimal(15, 5)), CAST(1.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0203', N'GYPS', CAST(25.00000 AS Decimal(15, 5)), CAST(2.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0203', N'KNIP', CAST(50.00000 AS Decimal(15, 5)), CAST(2.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0203', N'LUPI', CAST(200.00000 AS Decimal(15, 5)), CAST(1.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0204', N'ALTH', CAST(50.00000 AS Decimal(15, 5)), CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0204', N'BEGO', CAST(50.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0204', N'CAMP', CAST(150.00000 AS Decimal(15, 5)), CAST(1.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0204', N'CHEI', CAST(50.00000 AS Decimal(15, 5)), CAST(0.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0204', N'DELP', CAST(100.00000 AS Decimal(15, 5)), CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[BestelRegel] ([BestelNummer], [ArtikelCodeLeverancier], [Aantal], [BestelRegelPrijs]) VALUES (N'0206', N'201-V', CAST(10.00000 AS Decimal(15, 5)), CAST(20.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'004', N'HOVENIER G.H.', N'ZANDWEG 50', N'LISSE')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'009', N'BAUMGARTEN R.', N'TAKSTRAAT 13', N'HILLEGOM')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'011', N'STRUIK BV.', N'BESSENLAAN 1', N'LISSE')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'013', N'SPITMAN EN ZN.', N'ACHTERTUIN 9', N'AALSMEER')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'014', N'DEZAAIER L.J.A.', N'DE GRONDEN 101', N'LISSE')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'019', N'MOOIWEER FA.', N'VERLENGDE ZOMERSTR. 24', N'AALSMEER')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'020', N'BLOEM L.Z.H.W.', N'LINNAEUSHOF 17', N'HILLEGOM')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'021', N'TRA A.', N'KOELEPLEKSTRAAT 10', N'LISSE')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'022', N'ERICA BV.', N'BERKENWEG 87', N'HEEMSTEDE')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'034', N'DE GROENE KAS BV.', N'GLASWEG 1', N'AALSMEER')
GO
INSERT [dbo].[Leverancier] ([LeverancierCode], [LeverancierNaam], [Adres], [WoonPlaats]) VALUES (N'035', N'FLORA BV.', N'OEVERSTRAAT 76', N'AALSMEER')
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'036', N'A004', CAST(7.00000 AS Decimal(15, 5)), CAST(1.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'074', N'B337', CAST(7.00000 AS Decimal(15, 5)), CAST(1.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'095', N'A385', CAST(7.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'102', N'B331', CAST(7.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'157', N'A103', CAST(7.00000 AS Decimal(15, 5)), CAST(0.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'380', N'B148', CAST(7.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'426', N'A075', CAST(7.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'434', N'D225', CAST(7.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'455', N'A421', CAST(7.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'470', N'C274', CAST(7.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'004', N'478', N'A184', CAST(7.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'001', N'050', CAST(21.00000 AS Decimal(15, 5)), CAST(8.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'027', N'091', CAST(21.00000 AS Decimal(15, 5)), CAST(7.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'066', N'103', CAST(21.00000 AS Decimal(15, 5)), CAST(6.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'103', N'024', CAST(21.00000 AS Decimal(15, 5)), CAST(7.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'104', N'014', CAST(21.00000 AS Decimal(15, 5)), CAST(7.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'117', N'029', CAST(21.00000 AS Decimal(15, 5)), CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'162', N'145', CAST(21.00000 AS Decimal(15, 5)), CAST(4.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'178', N'081', CAST(21.00000 AS Decimal(15, 5)), CAST(3.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'195', N'013', CAST(21.00000 AS Decimal(15, 5)), CAST(6.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'209', N'114', CAST(21.00000 AS Decimal(15, 5)), CAST(8.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'210', N'097', CAST(21.00000 AS Decimal(15, 5)), CAST(0.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'257', N'044', CAST(21.00000 AS Decimal(15, 5)), CAST(3.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'263', N'116', CAST(21.00000 AS Decimal(15, 5)), CAST(14.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'281', N'115', CAST(21.00000 AS Decimal(15, 5)), CAST(5.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'286', N'078', CAST(21.00000 AS Decimal(15, 5)), CAST(10.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'362', N'099', CAST(21.00000 AS Decimal(15, 5)), CAST(5.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'364', N'021', CAST(21.00000 AS Decimal(15, 5)), CAST(2.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'393', N'064', CAST(21.00000 AS Decimal(15, 5)), CAST(4.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'397', N'045', CAST(21.00000 AS Decimal(15, 5)), CAST(6.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'408', N'023', CAST(21.00000 AS Decimal(15, 5)), CAST(10.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'420', N'011', CAST(21.00000 AS Decimal(15, 5)), CAST(9.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'471', N'085', CAST(21.00000 AS Decimal(15, 5)), CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'009', N'498', N'002', CAST(21.00000 AS Decimal(15, 5)), CAST(2.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'001', N'H10R', CAST(14.00000 AS Decimal(15, 5)), CAST(10.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'012', N'H75P', CAST(14.00000 AS Decimal(15, 5)), CAST(10.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'103', N'H19O', CAST(14.00000 AS Decimal(15, 5)), CAST(9.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'117', N'H17', CAST(14.00000 AS Decimal(15, 5)), CAST(2.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'195', N'H14W', CAST(14.00000 AS Decimal(15, 5)), CAST(7.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'255', N'E23W', CAST(10.00000 AS Decimal(15, 5)), CAST(1.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'263', N'H99G', CAST(14.00000 AS Decimal(15, 5)), CAST(16.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'327', N'E11X', CAST(10.00000 AS Decimal(15, 5)), CAST(1.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'335', N'E01R', CAST(21.00000 AS Decimal(15, 5)), CAST(2.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'365', N'E05R', CAST(10.00000 AS Decimal(15, 5)), CAST(0.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'397', N'H14R', CAST(14.00000 AS Decimal(15, 5)), CAST(7.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'011', N'408', N'H09', CAST(14.00000 AS Decimal(15, 5)), CAST(11.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'001', N'B578', CAST(14.00000 AS Decimal(15, 5)), CAST(12.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'031', N'G202', CAST(14.00000 AS Decimal(15, 5)), CAST(6.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'036', N'A101', CAST(7.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'047', N'D555', CAST(14.00000 AS Decimal(15, 5)), CAST(12.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'056', N'D321', CAST(10.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'067', N'A002', CAST(10.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'071', N'G001', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'082', N'A395', CAST(10.00000 AS Decimal(15, 5)), CAST(2.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'087', N'E098', CAST(10.00000 AS Decimal(15, 5)), CAST(1.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'123', N'B101', CAST(7.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'184', N'A103', CAST(7.00000 AS Decimal(15, 5)), CAST(0.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'200', N'C243', CAST(14.00000 AS Decimal(15, 5)), CAST(11.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'228', N'E409', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'262', N'C119', CAST(14.00000 AS Decimal(15, 5)), CAST(6.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'281', N'C051', CAST(14.00000 AS Decimal(15, 5)), CAST(8.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'300', N'F342', CAST(10.00000 AS Decimal(15, 5)), CAST(6.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'311', N'B396', CAST(10.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'312', N'G430', CAST(10.00000 AS Decimal(15, 5)), CAST(2.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'314', N'A154', CAST(7.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'316', N'H510', CAST(10.00000 AS Decimal(15, 5)), CAST(1.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'332', N'F823', CAST(10.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'362', N'D296', CAST(14.00000 AS Decimal(15, 5)), CAST(8.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'364', N'D742', CAST(14.00000 AS Decimal(15, 5)), CAST(3.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'365', N'B006', CAST(14.00000 AS Decimal(15, 5)), CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'372', N'A230', CAST(10.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'383', N'A472', CAST(7.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'391', N'A520', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'393', N'B024', CAST(14.00000 AS Decimal(15, 5)), CAST(6.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'422', N'B111', CAST(10.00000 AS Decimal(15, 5)), CAST(2.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'437', N'A677', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'013', N'471', N'D029', CAST(14.00000 AS Decimal(15, 5)), CAST(6.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'013', N'117-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'023', N'103-2', CAST(10.00000 AS Decimal(15, 5)), CAST(1.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'035', N'471-2', CAST(10.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'050', N'255-1', CAST(10.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'054', N'263-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'056', N'393-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'068', N'209-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'071', N'300-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'087', N'286-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'102', N'281-2', CAST(10.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'123', N'498-1', CAST(10.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'147', N'327-1', CAST(10.00000 AS Decimal(15, 5)), CAST(0.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'157', N'365-V', CAST(10.00000 AS Decimal(15, 5)), CAST(0.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'164', N'257-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'212', N'012-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'228', N'162-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'297', N'082-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'311', N'362-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'316', N'408-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'351', N'264-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'363', N'397-V', CAST(10.00000 AS Decimal(15, 5)), CAST(2.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'372', N'027-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'380', N'400-2', CAST(10.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'384', N'067-V', CAST(10.00000 AS Decimal(15, 5)), CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'390', N'201-V', CAST(10.00000 AS Decimal(15, 5)), CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'398', N'273-2', CAST(10.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'438', N'335-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'455', N'001-2', CAST(10.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'467', N'118-V', CAST(10.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'014', N'478', N'195-1', CAST(10.00000 AS Decimal(15, 5)), CAST(0.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'013', N'ERYN', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'056', N'CYNO', CAST(14.00000 AS Decimal(15, 5)), CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'061', N'ALTH', CAST(14.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'067', N'POTE', CAST(14.00000 AS Decimal(15, 5)), CAST(1.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'071', N'LAMI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'078', N'PAEO', CAST(14.00000 AS Decimal(15, 5)), CAST(2.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'080', N'CENT', CAST(14.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'082', N'ACMO', CAST(14.00000 AS Decimal(15, 5)), CAST(2.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'087', N'CAMP', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'089', N'LUPI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'164', N'CHRY', CAST(14.00000 AS Decimal(15, 5)), CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'175', N'ACON', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'207', N'ROSM', CAST(14.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'212', N'DELP', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'234', N'MATR', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'316', N'GEUM', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'363', N'GYPS', CAST(14.00000 AS Decimal(15, 5)), CAST(2.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'372', N'EUPH', CAST(14.00000 AS Decimal(15, 5)), CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'425', N'ALSC', CAST(14.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'438', N'DIAN', CAST(14.00000 AS Decimal(15, 5)), CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'467', N'HELI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'019', N'486', N'KNIP', CAST(14.00000 AS Decimal(15, 5)), CAST(2.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'036', N'103', CAST(7.00000 AS Decimal(15, 5)), CAST(1.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'123', N'209', CAST(7.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'126', N'281', CAST(7.00000 AS Decimal(15, 5)), CAST(2.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'143', N'471', CAST(7.00000 AS Decimal(15, 5)), CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'147', N'393', CAST(7.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'169', N'263', CAST(7.00000 AS Decimal(15, 5)), CAST(0.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'184', N'195', CAST(7.00000 AS Decimal(15, 5)), CAST(0.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'253', N'066', CAST(7.00000 AS Decimal(15, 5)), CAST(0.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'266', N'257', CAST(7.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'314', N'498', CAST(7.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'361', N'047', CAST(7.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'383', N'362', CAST(7.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'434', N'210', CAST(7.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'468', N'162', CAST(7.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'020', N'470', N'001', CAST(7.00000 AS Decimal(15, 5)), CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'001', N'ROD', CAST(10.00000 AS Decimal(15, 5)), CAST(9.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'012', N'SER', CAST(10.00000 AS Decimal(15, 5)), CAST(9.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'019', N'VUU', CAST(10.00000 AS Decimal(15, 5)), CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'103', N'AZA', CAST(10.00000 AS Decimal(15, 5)), CAST(8.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'108', N'FOR', CAST(10.00000 AS Decimal(15, 5)), CAST(2.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'117', N'KOR', CAST(10.00000 AS Decimal(15, 5)), CAST(2.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'195', N'MAG', CAST(10.00000 AS Decimal(15, 5)), CAST(7.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'210', N'LIG', CAST(10.00000 AS Decimal(15, 5)), CAST(0.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'242', N'ZUU', CAST(10.00000 AS Decimal(15, 5)), CAST(1.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'263', N'TOV', CAST(10.00000 AS Decimal(15, 5)), CAST(16.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'364', N'BRE', CAST(10.00000 AS Decimal(15, 5)), CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'397', N'PEP', CAST(10.00000 AS Decimal(15, 5)), CAST(7.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'408', N'HUL', CAST(10.00000 AS Decimal(15, 5)), CAST(11.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'021', N'471', N'OLI', CAST(10.00000 AS Decimal(15, 5)), CAST(5.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'028', N'B-104', CAST(14.00000 AS Decimal(15, 5)), CAST(22.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'039', N'B-076', CAST(14.00000 AS Decimal(15, 5)), CAST(2.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'103', N'S-118', CAST(14.00000 AS Decimal(15, 5)), CAST(9.45000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'210', N'S-015', CAST(14.00000 AS Decimal(15, 5)), CAST(0.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'281', N'B-034', CAST(14.00000 AS Decimal(15, 5)), CAST(6.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'286', N'B-011', CAST(14.00000 AS Decimal(15, 5)), CAST(12.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'335', N'E-002', CAST(10.00000 AS Decimal(15, 5)), CAST(2.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'364', N'S-154', CAST(14.00000 AS Decimal(15, 5)), CAST(2.70000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'365', N'E-003', CAST(10.00000 AS Decimal(15, 5)), CAST(0.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'393', N'B-003', CAST(14.00000 AS Decimal(15, 5)), CAST(5.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'022', N'471', N'S-077', CAST(14.00000 AS Decimal(15, 5)), CAST(5.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'013', N'ERYN', CAST(14.00000 AS Decimal(15, 5)), CAST(1.85000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'024', N'ECHI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.85000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'031', N'VITI', CAST(14.00000 AS Decimal(15, 5)), CAST(6.20000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'050', N'TAGE', CAST(14.00000 AS Decimal(15, 5)), CAST(0.35000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'061', N'ALTH', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'074', N'CHEI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'082', N'ACMO', CAST(14.00000 AS Decimal(15, 5)), CAST(2.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'087', N'CAMP', CAST(14.00000 AS Decimal(15, 5)), CAST(1.85000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'089', N'LUPI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'105', N'ARDR', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'120', N'OCBA', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'123', N'BEGO', CAST(14.00000 AS Decimal(15, 5)), CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'143', N'PHLO', CAST(14.00000 AS Decimal(15, 5)), CAST(0.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'153', N'AQUI', CAST(14.00000 AS Decimal(15, 5)), CAST(1.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'157', N'VIOL', CAST(14.00000 AS Decimal(15, 5)), CAST(0.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'164', N'CHMA', CAST(14.00000 AS Decimal(15, 5)), CAST(1.55000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'212', N'DELP', CAST(14.00000 AS Decimal(15, 5)), CAST(1.85000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'224', N'ANGR', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'253', N'WIST', CAST(14.00000 AS Decimal(15, 5)), CAST(0.05000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'285', N'PAPA', CAST(14.00000 AS Decimal(15, 5)), CAST(3.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'300', N'CORT', CAST(14.00000 AS Decimal(15, 5)), CAST(5.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'319', N'RUSC', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'380', N'PARH', CAST(14.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'390', N'ANEM', CAST(14.00000 AS Decimal(15, 5)), CAST(2.15000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'391', N'SALV', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'398', N'CYNO', CAST(14.00000 AS Decimal(15, 5)), CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'427', N'HEDE', CAST(14.00000 AS Decimal(15, 5)), CAST(4.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'455', N'PRIM', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'462', N'ANCE', CAST(14.00000 AS Decimal(15, 5)), CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'468', N'ANTI', CAST(14.00000 AS Decimal(15, 5)), CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'034', N'469', N'TULI', CAST(14.00000 AS Decimal(15, 5)), CAST(0.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'042', N'ST4P6', CAST(10.00000 AS Decimal(15, 5)), CAST(3.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'054', N'ST2P2', CAST(10.00000 AS Decimal(15, 5)), CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'061', N'ST1P6', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'068', N'ST2P6', CAST(10.00000 AS Decimal(15, 5)), CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'082', N'ST2P3', CAST(10.00000 AS Decimal(15, 5)), CAST(2.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'089', N'ST1P1', CAST(10.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'130', N'ST1P4', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'180', N'ST3P1', CAST(10.00000 AS Decimal(15, 5)), CAST(4.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'190', N'ST4P5', CAST(10.00000 AS Decimal(15, 5)), CAST(0.85000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'205', N'ST2P5', CAST(10.00000 AS Decimal(15, 5)), CAST(2.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'283', N'ST4P2', CAST(10.00000 AS Decimal(15, 5)), CAST(3.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'285', N'ST1P9', CAST(10.00000 AS Decimal(15, 5)), CAST(3.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'296', N'ST3P5', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'311', N'ST1P3', CAST(10.00000 AS Decimal(15, 5)), CAST(1.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'320', N'ST4P1', CAST(10.00000 AS Decimal(15, 5)), CAST(7.90000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'427', N'ST3P2', CAST(10.00000 AS Decimal(15, 5)), CAST(4.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'428', N'ST1P8', CAST(10.00000 AS Decimal(15, 5)), CAST(2.95000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Offerte] ([LeverancierCode], [ArtikelCode], [ArtikelCodeLeverancier], [LeverTijd], [OffertePrijs]) VALUES (N'035', N'467', N'ST2P1', CAST(10.00000 AS Decimal(15, 5)), CAST(1.30000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'001', N'RODODENDRON', N'HEESTER', N'ROOD', 125, 5, 7, CAST(19.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'012', N'SERING', N'HEESTER', N'PAARS', 500, 5, 6, CAST(19.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'013', N'KRUISDISTEL', N'VAST', N'BLAUW', 75, 6, 7, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'019', N'VUURDOORN', N'HEESTER', N'WIT', 0, 6, 6, CAST(5.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'023', N'KLOKJESBLOEM', N'2-JARIG', N'BLAUW', 70, 6, 8, CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'024', N'KOGELDISTEL', N'VAST', N'BLAUW', 175, 6, 7, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'027', N'PAARDEKASTANJE', N'BOOM', N'WIT', 2500, 5, 5, CAST(17.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'028', N'LINDE', N'BOOM', N'GEEL', 4000, 7, 8, CAST(42.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'031', N'WIJNSTOK', N'KLIM', NULL, 600, 0, 0, CAST(10.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'035', N'VIOLIER', N'2-JARIG', N'GEMENGD', 60, 6, 7, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'036', N'ZONNEBLOEM', N'1-JARIG', N'GEEL', 150, 8, 10, CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'039', N'POPULIER', N'BOOM', N'WIT', 1000, 3, 4, CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'042', N'CYPERGRAS', N'WATER', NULL, 100, 0, 0, CAST(5.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'047', N'ZILVERSPAR', N'BOOM', NULL, 3000, 0, 0, CAST(19.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'050', N'AFRIKAANTJE', N'1-JARIG', N'GEEL', 25, 7, 10, CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'054', N'BOTERBLOEM', N'VAST', N'WIT', 50, 5, 6, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'056', N'HONDSTONG', N'VAST', N'BLAUW', 30, 6, 8, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'061', N'STOKROOS', N'VAST', N'ROOD', 250, 6, 9, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'066', N'DWERGCYPRES', N'BOOM', NULL, 500, 0, 0, CAST(13.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'067', N'GANZERIK', N'VAST', N'ROOD', 25, 6, 9, CAST(2.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'068', N'DAGLELIE', N'VAST', N'ROOD', 80, 6, 8, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'071', N'DOVENETEL', N'VAST', N'GEEL', 25, 4, 5, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'074', N'MUURBLOEM', N'2-JARIG', N'BRUIN', 50, 4, 5, CAST(1.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'078', N'PIOEN', N'VAST', N'ROOD', 50, 6, 7, CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'080', N'KORENBLOEM', N'VAST', N'BLAUW', 80, 7, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'082', N'BEREKLAUW', N'VAST', N'WIT', 100, 7, 9, CAST(3.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'087', N'KLOKJESBLOEM', N'VAST', N'BLAUW', 90, 6, 8, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'089', N'LUPINE', N'VAST', N'GEMENGD', 100, 6, 7, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'095', N'VIOLIER', N'1-JARIG', N'GEMENGD', 60, 6, 8, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'102', N'JUDASPENNING', N'2-JARIG', N'LILA', 70, 5, 7, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'103', N'AZALEA', N'HEESTER', N'ORANJE', 200, 4, 5, CAST(17.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'104', N'ESDOORN', N'BOOM', N'GROEN', 2500, 6, 6, CAST(17.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'105', N'DRAGON', N'KRUID', N'WIT', 100, 8, 9, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'108', N'FORSYTHIA', N'HEESTER', N'GEEL', 250, 3, 4, CAST(5.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'117', N'KORNOELJE', N'HEESTER', N'GEEL', 300, 5, 0, CAST(5.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'120', N'BASILICUM', N'KRUID', N'WIT', 50, 8, 9, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'123', N'BEGONIA', N'1-JARIG', N'ROOD', 15, 6, 9, CAST(0.65000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'126', N'SIERUI', N'BOL', N'BLAUW', 75, 6, 8, CAST(3.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'130', N'VINGERHOEDSKRUID', N'VAST', N'GEMENGD', 0, 6, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'143', N'VLAMBLOEM', N'1-JARIG', N'GEMENGD', 30, 7, 8, CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'147', N'ASTER', N'1-JARIG', N'GEMENGD', 50, 7, 10, CAST(0.75000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'153', N'AKELEI', N'VAST', N'BLAUW', 60, 5, 7, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'157', N'VIOOLTJE', N'2-JARIG', N'GEMENGD', 15, 3, 8, CAST(0.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'162', N'AZIJNBOOM', N'BOOM', N'ROOD', 0, 6, 7, CAST(9.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'164', N'MARGRIET', N'VAST', N'WIT', 70, 6, 8, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'169', N'KROKUS', N'BOL', N'WIT', 15, 2, 3, CAST(0.10000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'175', N'MONNIKSKAP', N'VAST', N'VIOLET', 120, 8, 9, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'178', N'LIJSTERBES', N'BOOM', N'WIT', 500, 5, 5, CAST(7.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'180', N'BOSRANK', N'KLIM', N'PAARS', 300, 7, 9, CAST(6.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'184', N'IRIS', N'BOL', N'BLAUW', 100, 5, 7, CAST(0.14000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'190', N'KIKKERBEET', N'WATER', N'WIT', 0, 7, 8, CAST(1.25000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'195', N'MAGNOLIA', N'HEESTER', N'WIT', 1000, 4, 5, CAST(14.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'200', N'ACACIA', N'BOOM', N'WIT', 2500, 6, 6, CAST(17.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'205', N'DOTTERBLOEM', N'WATER', N'GEEL', 30, 4, 6, CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'207', N'ROZEMARIJN', N'KRUID', N'BLAUW', 150, 5, 5, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'209', N'MEIDOORN', N'BOOM', N'ROZE', 700, 5, 5, CAST(19.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'210', N'LIGUSTER', N'HEESTER', N'WIT', 200, 7, 7, CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'212', N'RIDDERSPOOR', N'VAST', N'LILA', 150, 6, 7, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'224', N'DILLE', N'KRUID', N'GEEL', 90, 7, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'228', N'ENGELS GRAS', N'VAST', N'ROOD', 20, 0, 0, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'234', N'KAMILLE', N'VAST', N'WIT', 70, 6, 7, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'242', N'ZUURBES', N'HEESTER', N'ORANJE', 300, 5, 6, CAST(3.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'253', N'BLAUW DRUIFJE', N'BOL', N'BLAUW', 20, 2, 6, CAST(0.12000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'255', N'WINTERHEIDE', N'HEIDE', N'WIT', 20, 2, 4, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'257', N'BERK', N'BOOM', NULL, 2000, 0, 0, CAST(7.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'262', N'PASSIEBLOEM', N'KLIM', N'BLAUW', 0, 6, 9, CAST(9.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'263', N'TOVERHAZELAAR', N'HEESTER', N'GEEL', 500, 1, 2, CAST(32.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'266', N'KORENBLOEM', N'1-JARIG', N'GEMENGD', 80, 7, 8, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'281', N'BEUK', N'BOOM', N'GROEN', 3000, 4, 5, CAST(12.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'283', N'WATERHYACINT', N'WATER', N'BLAUW', 0, 6, 9, CAST(5.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'285', N'KLAPROOS', N'VAST', N'ROOD', 70, 5, 6, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'286', N'TULPEBOOM', N'BOOM', N'GEEL', 2000, 6, 7, CAST(22.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'296', N'PETERSELIE', N'KRUID', NULL, 25, 0, 0, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'297', N'MAJORAAN', N'KRUID', N'PAARS', 30, 7, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'300', N'PAMPUSGRAS', N'VAST', N'WIT', 300, 9, 10, CAST(9.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'311', N'LEVERKRUID', N'VAST', N'PAARS', 175, 8, 9, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'312', N'LISDODDE', N'WATER', N'GEEL', 200, 8, 9, CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'314', N'CHRYSANT', N'1-JARIG', N'GEEL', 80, 6, 8, CAST(0.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'316', N'NAGELKRUID', N'VAST', N'ORANJE', 50, 7, 8, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'319', N'ZURING', N'KRUID', N'ROOD', 70, 6, 6, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'320', N'WATERLELIE', N'WATER', N'WIT', 0, 0, 0, CAST(12.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'327', N'STRUIKHEIDE', N'HEIDE', N'GEMENGD', 30, 6, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'332', N'BLAASJESKRUID', N'WATER', N'GEEL', 0, 7, 8, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'335', N'BOOMHEIDE', N'HEIDE', N'ROZE', 150, 7, 9, CAST(5.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'351', N'TIJM', N'KRUID', N'PAARS', 10, 6, 6, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'361', N'RIDDERSPOOR', N'1-JARIG', N'GEMENGD', 50, 7, 8, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'362', N'SPAR', N'BOOM', NULL, 3000, 0, 0, CAST(12.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'363', N'GIPSKRUID', N'VAST', N'WIT', 90, 7, 8, CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'364', N'BREM', N'HEESTER', N'GEEL', 150, 4, 7, CAST(5.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'365', N'DOPHEIDE', N'HEIDE', N'ROOD', 35, 6, 9, CAST(1.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'372', N'WOLFSMELK', N'VAST', N'GEEL', 60, 4, 4, CAST(2.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'380', N'KLAPROOS', N'2-JARIG', N'GEMENGD', 40, 6, 6, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'383', N'DAHLIA', N'1-JARIG', N'GEMENGD', 40, 8, 10, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'384', N'VUURWERKPLANT', N'VAST', N'ROZE', 150, 6, 7, CAST(3.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'390', N'ANEMOON', N'VAST', N'ROZE', 50, 8, 10, CAST(3.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'391', N'SALIE', N'KRUID', N'VIOLET', 100, 6, 7, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'393', N'JUDASBOOM', N'BOOM', N'ROZE', 800, 5, 5, CAST(9.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'397', N'PEPERBOOMPJE', N'HEESTER', N'ROZE', 125, 2, 3, CAST(15.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'398', N'HONDSTONG', N'2-JARIG', N'BLAUW', 30, 5, 6, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'408', N'HULST', N'HEESTER', NULL, 700, 0, 0, CAST(22.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'420', N'GOUDEN REGEN', N'BOOM', N'GEEL', 600, 5, 5, CAST(22.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'422', N'WOLGRAS', N'WATER', N'WIT', 30, 5, 6, CAST(3.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'425', N'BIESLOOK', N'KRUID', N'PAARS', 20, 7, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'426', N'ALYSSUM', N'1-JARIG', N'PAARS', 10, 6, 9, CAST(0.60000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'427', N'KLIMOP', N'KLIM', NULL, 0, 0, 0, CAST(7.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'428', N'KALMOES', N'WATER', NULL, 90, 0, 0, CAST(4.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'434', N'PETUNIA', N'1-JARIG', N'ROZE', 25, 7, 10, CAST(0.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'437', N'MUNT', N'KRUID', N'PAARS', 40, 8, 8, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'438', N'ANJER', N'VAST', N'WIT', 40, 6, 8, CAST(3.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'455', N'SLEUTELBLOEM', N'2-JARIG', N'GEMENGD', 25, 4, 5, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'462', N'KERVEL', N'KRUID', N'WIT', 30, 0, 0, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'467', N'ZONNEBLOEM', N'VAST', N'GEEL', 150, 8, 9, CAST(2.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'468', N'LEEUWEBEKJE', N'1-JARIG', N'GEMENGD', 50, 7, 8, CAST(0.80000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'469', N'TULP', N'BOL', N'GEEL', 30, 4, 6, CAST(0.40000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'470', N'GIPSKRUID', N'1-JARIG', N'WIT', 50, 6, 7, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'471', N'OLIJFWILG', N'HEESTER', N'GEEL', 400, 9, 10, CAST(10.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'478', N'KLAPROOS', N'1-JARIG', N'GEMENGD', 35, 6, 9, CAST(1.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'486', N'VUURPIJL', N'VAST', N'ROOD', 120, 6, 9, CAST(3.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[Plant] ([ArtikelCode], [PlantenNaam], [Soort], [Kleur], [Hoogte], [BloeiBegin], [BloeiEind], [Prijs]) VALUES (N'498', N'JENEVERBES', N'BOOM', NULL, 250, 0, 0, CAST(6.50000 AS Decimal(15, 5)))
GO
INSERT [dbo].[PlantCategorie] ([Categorie], [HoogteMinimum], [HoogteMaximum], [Afstand]) VALUES (N'ACHTER-H', CAST(101.00000 AS Decimal(15, 5)), CAST(150.00000 AS Decimal(15, 5)), CAST(60.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[PlantCategorie] ([Categorie], [HoogteMinimum], [HoogteMaximum], [Afstand]) VALUES (N'ACHTER-L', CAST(61.00000 AS Decimal(15, 5)), CAST(100.00000 AS Decimal(15, 5)), CAST(45.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[PlantCategorie] ([Categorie], [HoogteMinimum], [HoogteMaximum], [Afstand]) VALUES (N'BOMEN', CAST(301.00000 AS Decimal(15, 5)), CAST(4000.00000 AS Decimal(15, 5)), CAST(400.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[PlantCategorie] ([Categorie], [HoogteMinimum], [HoogteMaximum], [Afstand]) VALUES (N'LAAG', CAST(5.00000 AS Decimal(15, 5)), CAST(15.00000 AS Decimal(15, 5)), CAST(20.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[PlantCategorie] ([Categorie], [HoogteMinimum], [HoogteMaximum], [Afstand]) VALUES (N'MIDDEN', CAST(16.00000 AS Decimal(15, 5)), CAST(60.00000 AS Decimal(15, 5)), CAST(30.00000 AS Decimal(15, 5)))
GO
INSERT [dbo].[PlantCategorie] ([Categorie], [HoogteMinimum], [HoogteMaximum], [Afstand]) VALUES (N'SCHEIDING', CAST(151.00000 AS Decimal(15, 5)), CAST(300.00000 AS Decimal(15, 5)), CAST(85.00000 AS Decimal(15, 5)))
GO
ALTER TABLE [dbo].[Bestelling]  WITH CHECK ADD  CONSTRAINT [FK_Bestelling_Leverancier] FOREIGN KEY([LeverancierCode])
REFERENCES [dbo].[Leverancier] ([LeverancierCode])
GO
ALTER TABLE [dbo].[Bestelling] CHECK CONSTRAINT [FK_Bestelling_Leverancier]
GO
ALTER TABLE [dbo].[BestelRegel]  WITH CHECK ADD  CONSTRAINT [FK_BestelRegel_Bestelling] FOREIGN KEY([BestelNummer])
REFERENCES [dbo].[Bestelling] ([BestelNummer])
GO
ALTER TABLE [dbo].[BestelRegel] CHECK CONSTRAINT [FK_BestelRegel_Bestelling]
GO
ALTER TABLE [dbo].[Offerte]  WITH CHECK ADD  CONSTRAINT [FK_Offerte_Leverancier] FOREIGN KEY([LeverancierCode])
REFERENCES [dbo].[Leverancier] ([LeverancierCode])
GO
ALTER TABLE [dbo].[Offerte] CHECK CONSTRAINT [FK_Offerte_Leverancier]
GO
ALTER TABLE [dbo].[Offerte]  WITH CHECK ADD  CONSTRAINT [FK_Offerte_Plant] FOREIGN KEY([ArtikelCode])
REFERENCES [dbo].[Plant] ([ArtikelCode])
GO
ALTER TABLE [dbo].[Offerte] CHECK CONSTRAINT [FK_Offerte_Plant]
GO
USE [master]
GO
ALTER DATABASE [Bloemist] SET  READ_WRITE 
GO
