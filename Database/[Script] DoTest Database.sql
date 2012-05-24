USE [master]
GO
/****** Object:  Database [DoTest]    Script Date: 05/24/2012 19:36:28 ******/
CREATE DATABASE [DoTest] ON  PRIMARY 
( NAME = N'DoTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\DoTest.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DoTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\DoTest_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DoTest] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DoTest].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [DoTest] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [DoTest] SET ANSI_NULLS OFF
GO
ALTER DATABASE [DoTest] SET ANSI_PADDING OFF
GO
ALTER DATABASE [DoTest] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [DoTest] SET ARITHABORT OFF
GO
ALTER DATABASE [DoTest] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [DoTest] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [DoTest] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [DoTest] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [DoTest] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [DoTest] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [DoTest] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [DoTest] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [DoTest] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [DoTest] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [DoTest] SET  DISABLE_BROKER
GO
ALTER DATABASE [DoTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [DoTest] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [DoTest] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [DoTest] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [DoTest] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [DoTest] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [DoTest] SET  READ_WRITE
GO
ALTER DATABASE [DoTest] SET RECOVERY FULL
GO
ALTER DATABASE [DoTest] SET  MULTI_USER
GO
ALTER DATABASE [DoTest] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [DoTest] SET DB_CHAINING OFF
GO
USE [DoTest]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 05/24/2012 19:36:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [int] NULL,
	[Name] [varchar](50) NULL,
	[Code] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee_Salary]    Script Date: 05/24/2012 19:36:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Salary](
	[ID] [int] NULL,
	[ID_Employee] [int] NULL,
	[Salary] [numeric](18, 4) NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_DataObjects_GetTableDef]    Script Date: 05/24/2012 19:36:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[udf_DataObjects_GetTableDef]
(@TableName VarChar(Max))	
Returns Table
As
Return
	(
	Select
		sCol.Column_id
		, sCol.Name As [ColumnName]
		, sTyp.Name As [DataType]
		, sCol.max_length As [Length]
		, sCol.Precision
		, sCol.Scale
		, sCol.Is_Identity As [IsIdentity]
		, Cast
		(
			(
			Case Count(IsCcu.Column_Name)
				When 0 Then 0
				Else 1
			End
			) 
		As Bit) As IsPk
	From 
		Sys.Columns As sCol
		Left Join Sys.Types As sTyp
			On sCol.system_type_id = sTyp.system_type_id
			And [sCol].User_Type_ID = [sTyp].User_Type_ID
		Inner Join Sys.Tables As sTab
			On sCol.Object_ID = sTab.Object_ID
		Inner Join Sys.Schemas As sSch
			On sSch.Schema_ID = sTab.Schema_ID
		Left Join Sys.Key_Constraints As Skc
			On sTab.Object_Id = Skc.Parent_Object_Id
			And Skc.Type = 'PK'
		Left Join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE As IsCcu
			On Skc.Name = IsCcu.Constraint_Name
			And sTab.Name = IsCcu.Table_Name
			And sCol.Name = IsCcu.Column_Name
	Where
		sSch.Name + '.' + sTab.Name = @TableName
		And sCol.Is_Computed = 0
	Group By
		sCol.Name
		, sTyp.Name
		, sCol.max_length
		, sCol.Precision
		, sCol.Scale
		, sCol.Is_Identity
		, sCol.Column_id
	)
GO
/****** Object:  Table [dbo].[DataObjects_Series]    Script Date: 05/24/2012 19:36:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DataObjects_Series](
	[TableName] [varchar](1000) NULL,
	[LastID] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DataObjects_Parameters]    Script Date: 05/24/2012 19:36:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DataObjects_Parameters](
	[ParameterName] [varchar](50) NULL,
	[ParameterValue] [varchar](8000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_DataObjects_GetTableDef]    Script Date: 05/24/2012 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[usp_DataObjects_GetTableDef]
@TableName VarChar(Max)
, @SchemaName VarChar(Max) = ''
As
Set NOCOUNT On
Begin
	
	If IsNull(@SchemaName, '') = ''
	Begin
		Set @SchemaName = 'dbo'
	End
	
	Select *
	From [udf_DataObjects_GetTableDef](@SchemaName + '.' + @TableName)
	Order By Column_Id
	
End
GO
/****** Object:  StoredProcedure [dbo].[usp_DataObjects_GetNextID]    Script Date: 05/24/2012 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[usp_DataObjects_GetNextID]
@TableName VarChar(Max)
As
Begin
	Declare @LastID BigInt
	Declare @Ct Int

	Select @Ct = Count(*)
	From DataObjects_Series
	Where TableName = @TableName
		
	If @Ct = 0
	Begin
		Insert Into DataObjects_Series (TableName, LastID) Values (@TableName, 0)
	End

	Select @LastID = LastID
	From DataObjects_Series
	Where TableName = @TableName
		
	Set @LastID = @LastID + 1
		
	Update DataObjects_Series
	Set LastID = @LastID 
	Where TableName = @TableName
	
	Select @LastID As [ID]
	
End
GO
/****** Object:  StoredProcedure [dbo].[usp_DataObjects_Parameter_Set]    Script Date: 05/24/2012 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[usp_DataObjects_Parameter_Set]
@ParameterName VarChar(Max)
, @ParameterValue VarChar(Max)
As
Begin
	Declare @Ct As Int	
	Select @Ct = Count(1)
	From DataObjects_Parameters
	Where ParameterName = @ParameterName
	
	If @Ct = 0
	Begin
		Insert Into DataObjects_Parameters 
			(ParameterName, ParameterValue) 
		Values 
			(@ParameterName, @ParameterValue)
	End
	Else
	Begin
		Update DataObjects_Parameters 
		Set ParameterValue = @ParameterValue 
		Where ParameterName = @ParameterName
	End
End
GO
/****** Object:  StoredProcedure [dbo].[usp_DataObjects_Parameter_Require]    Script Date: 05/24/2012 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[usp_DataObjects_Parameter_Require]
@ParameterName VarChar(Max)
, @ParameterValue VarChar(Max)
As
Begin
	Declare @Ct As Int	
	Select @Ct = Count(1)
	From DataObjects_Parameters
	Where ParameterName = @ParameterName
	
	If @Ct = 0
	Begin
		Insert Into DataObjects_Parameters 
			(ParameterName, ParameterValue) 
		Values 
			(@ParameterName, @ParameterValue)
	End
End
GO
/****** Object:  StoredProcedure [dbo].[usp_DataObjects_Parameter_Get]    Script Date: 05/24/2012 19:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[usp_DataObjects_Parameter_Get]
@ParameterName VarChar(Max)
As
Begin
	Declare @ParameterValue As VarChar(Max)		
	Set @ParameterValue = ''
	
	Declare @Ct As Int	
	Select @Ct = Count(1)
	From DataObjects_Parameters
	Where ParameterName = @ParameterName
	
	If @Ct = 0
	Begin
		Exec usp_DataObjects_Parameter_Require @ParameterName
	End
	Else
	Begin
		Select @ParameterValue = ParameterValue
		From DataObjects_Parameters
		Where ParameterName = @ParameterName
	End
	
	Select @ParameterValue As [ParameterValue]
End
GO
