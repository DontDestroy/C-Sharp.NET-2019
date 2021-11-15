USE [master]
GO
CREATE DATABASE [cpADONET]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cpADONET', FILENAME = N'S:\Data\cpADONET.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cpADONET_log', FILENAME = N'S:\Data\cpADONET_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [cpADONET] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cpADONET].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cpADONET] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cpADONET] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cpADONET] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cpADONET] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cpADONET] SET ARITHABORT OFF 
GO
ALTER DATABASE [cpADONET] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cpADONET] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cpADONET] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cpADONET] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cpADONET] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cpADONET] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cpADONET] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cpADONET] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cpADONET] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cpADONET] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cpADONET] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cpADONET] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cpADONET] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cpADONET] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cpADONET] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cpADONET] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cpADONET] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cpADONET] SET RECOVERY FULL 
GO
ALTER DATABASE [cpADONET] SET  MULTI_USER 
GO
ALTER DATABASE [cpADONET] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cpADONET] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cpADONET] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cpADONET] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [cpADONET] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'cpADONET', N'ON'
GO
ALTER DATABASE [cpADONET] SET QUERY_STORE = OFF
GO
USE [cpADONET]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [cpADONET]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPProduct](
	[intIdProduct] [int] IDENTITY(1,1) NOT NULL,
	[strProductName] [varchar](150) NOT NULL,
	[dtmIntroduction] [datetime] NOT NULL,
	[strUrl] [varchar](255) NOT NULL,
	[decPrice] [money] NOT NULL,
	[dtmRetire] [datetime] NULL,
	[intProductCategoryId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 4/21/2020 2:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCPProductCategory](
	[intIdProductCategory] [int] IDENTITY(1,1) NOT NULL,
	[strCategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblCPProductCategory] PRIMARY KEY CLUSTERED 
(
	[intIdProductCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCPProduct] ON 
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (1, N'Extending Bootstrap with CSS, JavaScript and jQuery', CAST(N'2015-06-11T00:00:00.000' AS DateTime), N'http://bit.ly/1SNzc0i', 23.0000, NULL, 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (2, N'Build your own Bootstrap Business Application Template in MVC', CAST(N'2015-01-29T00:00:00.000' AS DateTime), N'http://bit.ly/1I8ZqZg', 21.0000, NULL, 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (3, N'Building Mobile Web Sites Using Web Forms, Bootstrap, and HTML5', CAST(N'2014-08-28T00:00:00.000' AS DateTime), N'http://bit.ly/1J2dcrj', 19.0000, NULL, 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (4, N'How to Start and Run A Consulting Business', CAST(N'2013-09-12T00:00:00.000' AS DateTime), N'http://bit.ly/1L8kOwd', 9.9900, NULL, NULL)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (5, N'The Many Approaches to XML Processing in .NET Applications', CAST(N'2013-07-22T00:00:00.000' AS DateTime), N'http://bit.ly/1DBfUqd', 9.0000, CAST(N'2019-03-20T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (6, N'WPF for the Business Programmer', CAST(N'2009-06-12T00:00:00.000' AS DateTime), N'http://bit.ly/1UF858z', 29.0000, NULL, 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (7, N'WPF for the Visual Basic Programmer - Part 1', CAST(N'2013-12-16T00:00:00.000' AS DateTime), N'http://bit.ly/1uFxS7C', 29.0000, NULL, 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (8, N'WPF for the Visual Basic Programmer - Part 2', CAST(N'2014-02-18T00:00:00.000' AS DateTime), N'http://bit.ly/1MjQ9NG', 29.0000, NULL, 1)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (10, N'Practical Team Management for Software Engineers', CAST(N'2017-05-19T00:00:00.000' AS DateTime), N'http://bit.ly/2qcWO5m', 15.0000, NULL, 2)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (11, N'Leadership and Communication Skills for Software Engineers', CAST(N'2016-05-13T00:00:00.000' AS DateTime), N'http://bit.ly/2aq2i4F', 15.0000, NULL, 2)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (12, N'Best Practices for Project Estimation', CAST(N'2014-12-08T00:00:00.000' AS DateTime), N'http://bit.ly/1ulLVJK', 15.0000, NULL, 2)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (23, N'Using PowerShell', CAST(N'2019-05-28T12:40:03.200' AS DateTime), N'www.fairwaytech.com', 100.0000, CAST(N'2019-08-28T12:40:03.670' AS DateTime), 4)
GO
INSERT [dbo].[tblCPProduct] ([intIdProduct], [strProductName], [dtmIntroduction], [strUrl], [decPrice], [dtmRetire], [intProductCategoryId]) VALUES (24, N'VB.NET Fundamentals', CAST(N'2019-05-21T00:00:00.000' AS DateTime), N'https://bit.ly/30KKHjs', 19.9900, NULL, 1)

SET IDENTITY_INSERT [dbo].[tblCPProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCPProductCategory] ON 
GO
INSERT [dbo].[tblCPProductCategory] ([intIdProductCategory], [strCategoryName]) VALUES (1, N'Development')
GO
INSERT [dbo].[tblCPProductCategory] ([intIdProductCategory], [strCategoryName]) VALUES (2, N'Soft Skills')
GO
INSERT [dbo].[tblCPProductCategory] ([intIdProductCategory], [strCategoryName]) VALUES (4, N'DevOps')
GO
SET IDENTITY_INSERT [dbo].[tblCPProductCategory] OFF
GO
ALTER TABLE [dbo].[tblCPProduct] ADD  CONSTRAINT [PK__tblCPProduct] PRIMARY KEY NONCLUSTERED 
(
	[intIdProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[tblCPProduct_Insert]
	@ProductName nvarchar(150),
	@Introduction datetime,
	@Url nvarchar(255),
	@Price money,
	@ProductKey int OUTPUT
AS
INSERT INTO tblCPProduct(strProductName, dtmIntroduction, strUrl, decPrice)
VALUES(@ProductName, @Introduction, @Url, @Price);

SELECT @ProductKey = SCOPE_IDENTITY();
GO
USE [master]
GO
ALTER DATABASE [cpADONET] SET  READ_WRITE 
GO
