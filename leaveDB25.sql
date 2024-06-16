USE [master]

use leaves12
GO
/****** Object:  Database [Leave]    Script Date: 6/12/2024 3:02:05 PM ******/
CREATE DATABASE [Leave12]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Leave', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Leave.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Leave_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Leave_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Leave] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Leave12].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
USE [Leave]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateEmployeeSerialNo]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateEmployeeSerialNo] (@empid INT)
RETURNS NVARCHAR(30)
AS
BEGIN
    DECLARE @employeeno NVARCHAR(30);
    SET @employeeno = 'BMS' + CAST(@empid AS NVARCHAR(10));
    RETURN @employeeno;
END
GO
/****** Object:  Table [dbo].[EmpDetails]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpDetails](
	[empid] [int] IDENTITY(1,1) NOT NULL,
	[empname] [varchar](80) NULL,
	[empemail] [varchar](80) NULL,
	[empContact] [varchar](20) NULL,
	[empdoj] [date] NULL,
	[Salary] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[empid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeDetails]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeDetails](
	[empid] [int] IDENTITY(1,1) NOT NULL,
	[empname] [varchar](80) NULL,
	[empemail] [varchar](80) NULL,
	[empContact] [varchar](20) NULL,
	[empbankname] [varchar](50) NULL,
	[empifsc] [varchar](50) NULL,
	[empbankacno] [varchar](50) NULL,
	[emppan] [varchar](20) NULL,
	[empadhar] [varchar](20) NULL,
	[empdesignation] [varchar](30) NULL,
	[employeeno] [nvarchar](20) NULL,
	[daysmoth] [int] NULL,
	[balanceleave] [int] NULL,
	[dayspaid] [int] NULL,
	[empdoj] [date] NULL,
	[empsalary] [decimal](18, 2) NULL,
	[pass] [nvarchar](50) NULL,
	[CarryOverLeaves] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[empid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employeel]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employeel](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [nvarchar](100) NULL,
	[ContactNumber] [nvarchar](15) NULL,
	[DateOfJoining] [date] NULL,
	[MonthlyLeaves] [int] NULL,
	[PreviousLeaves] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeePdfs]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeePdfs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[empid] [int] NULL,
	[empname] [varchar](50) NULL,
	[PdfData] [varbinary](max) NULL,
	[FileName] [nvarchar](255) NULL,
	[UploadDate] [datetime] NULL,
 CONSTRAINT [PK__Employee__3214EC07E2D7374F] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpOfferletter]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpOfferletter](
	[ofid] [int] IDENTITY(1,1) NOT NULL,
	[empid] [int] NULL,
	[empname] [varchar](50) NULL,
	[emailID] [nvarchar](50) NULL,
	[pdfdata] [varbinary](max) NULL,
	[filename] [nvarchar](255) NULL,
 CONSTRAINT [PK__EmpOffer__9381BE3D02809657] PRIMARY KEY CLUSTERED 
(
	[ofid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveBalance]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveBalance](
	[EmployeeID] [int] NOT NULL,
	[BalanceDays] [int] NULL,
	[JoiningDate] [date] NULL,
	[CarryOverLeaves] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Leaves]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leaves](
	[LeaveID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[EmployeeName] [varchar](80) NULL,
	[LeaveFrom] [date] NULL,
	[LeaveTo] [date] NULL,
	[Reason] [varchar](255) NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK__Leaves__796DB9795852B37D] PRIMARY KEY CLUSTERED 
(
	[LeaveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RaiseTicket]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RaiseTicket](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[empname] [varchar](255) NOT NULL,
	[Role] [varchar](255) NOT NULL,
	[RaiseTo] [varchar](255) NOT NULL,
	[Problem] [text] NOT NULL,
	[Attachment] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[CalculateAndInsertEmployeeDetails]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CalculateAndInsertEmployeeDetails]
   
    @empname NVARCHAR(80),
    @empemail NVARCHAR(80),
    @empContact NVARCHAR(20),
    @empbankname NVARCHAR(50),
    @empifsc NVARCHAR(50),
    @empbankacno NVARCHAR(50),
    @emppan NVARCHAR(20),
    @empadhar NVARCHAR(20),
    @empdesignation NVARCHAR(30),
    @empdoj DATE,
    @empsalary DECIMAL(18, 2),
	@emppass nvarchar(20)
	
AS
BEGIN
    SET NOCOUNT ON;
	
    DECLARE @daysmonth INT;
    DECLARE @balanceleave INT;
    DECLARE @dayspaid INT;
    DECLARE @EndOfMonth DATE;
    DECLARE @MonthsSinceJoining INT;

    -- Calculate the end of the joining month date
        SET @EndOfMonth = EOMONTH(@empdoj);

		-- Calculate the number of days from the joining date to the end of the month
    SET @daysmonth = DATEDIFF(DAY, @empdoj, @EndOfMonth) + 1;  

    -- Calculate the number of months from the joining date to the end of the year
    SET @MonthsSinceJoining = DATEDIFF(MONTH, @empdoj, DATEFROMPARTS(YEAR(@empdoj), 12, 31));

    -- Each employee has 2 leaves per month
    SET @balanceleave = @MonthsSinceJoining * 2;

    -- Assuming days paid is total days in the month minus leave days (simplified)
    SET @dayspaid = @daysmonth 

    -- Insert the employee details into EmployeDetails table
    INSERT INTO EmployeDetails (empname, empemail, empContact, empbankname, empifsc, empbankacno, emppan, empadhar, empdesignation, employeeno, daysmoth, balanceleave, dayspaid, empdoj, empsalary,pass)
    VALUES (@empname, @empemail, @empContact, @empbankname, @empifsc, @empbankacno, @emppan, @empadhar, @empdesignation ,'BMS',@daysmonth, @balanceleave, @dayspaid, @empdoj, @empsalary,@emppass);




END
GO
/****** Object:  StoredProcedure [dbo].[CalculateAndInsertLeaveBalance]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CalculateAndInsertLeaveBalance]
    @EmployeeID INT,
    @JoiningDate DATE
AS
BEGIN
    DECLARE @EndOfYear DATE;
    DECLARE @MonthsSinceJoining INT;
    DECLARE @BalanceDays INT;
    DECLARE @CarryOverLeaves INT = 0;

    -- Calculate the end of the year date
    SET @EndOfYear = DATEFROMPARTS(YEAR(@JoiningDate), 12, 31);

    -- Calculate the number of months from the joining date to the end of the year
    SET @MonthsSinceJoining = DATEDIFF(MONTH, @JoiningDate, @EndOfYear);

    -- Each employee has 2 leaves per month
    SET @BalanceDays = @MonthsSinceJoining * 2;

    -- Insert the calculated leave balance into the LeaveBalance table
    INSERT INTO LeaveBalance (EmployeeID, BalanceDays, JoiningDate, CarryOverLeaves)
    VALUES (@EmployeeID, @BalanceDays, @JoiningDate, @CarryOverLeaves);
END
GO
/****** Object:  StoredProcedure [dbo].[CalculateLeaveAndDeduction]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CalculateLeaveAndDeduction]
    @EmployeeID INT,
    @DateFrom DATE,
    @DateTo DATE,
    @Reason NVARCHAR(255)
AS
BEGIN
    DECLARE @TotalDays INT;
    DECLARE @MonthlyLeaveLimit INT = 2;
    DECLARE @DailyIncome DECIMAL(10, 2);
    DECLARE @TotalLeavesTaken INT;
    DECLARE @LeaveExceedAmount DECIMAL(10, 2) = 0;

    -- Calculate the total days of leave
    SET @TotalDays = DATEDIFF(DAY, @DateFrom, @DateTo) + 1;

    -- Insert the leave request
    INSERT INTO LeaveRequests (EmployeeID, DateFrom, DateTo, Reason)
    VALUES (@EmployeeID, @DateFrom, @DateTo, @Reason);

    -- Calculate the total leaves taken in the current month
    SELECT @TotalLeavesTaken = COUNT(*)
    FROM LeaveRequests
    WHERE EmployeeID = @EmployeeID
      AND MONTH(DateFrom) = MONTH(@DateFrom)
      AND YEAR(DateFrom) = YEAR(@DateFrom);

    -- Calculate daily income
    SELECT @DailyIncome = MonthlyIncome / 30
    FROM Registration
    WHERE ID = @EmployeeID;

    -- Calculate the amount to be deducted if leaves exceed the monthly limit
    IF @TotalLeavesTaken > @MonthlyLeaveLimit
    BEGIN
        SET @LeaveExceedAmount = (@TotalLeavesTaken - @MonthlyLeaveLimit) * @DailyIncome;
    END

    -- Print the amount to be deducted
    PRINT 'Amount to be deducted: ' + CAST(@LeaveExceedAmount AS NVARCHAR(10));
END
GO
/****** Object:  StoredProcedure [dbo].[EmpLogin]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EmpLogin]
@username varchar(100),
@password varchar(100)
As
begin
	select * from EmployeDetails where (empemail=@username OR empname=@username) AND pass=@password;
end
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeDetailsByID]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetEmployeeDetailsByID]
    @empid INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        empname, 
        empemail,
        empdoj,
		balanceleave,
		dayspaid,
		empsalary
    FROM EmployeDetails
    WHERE empid = @empid;
END


                SELECT balanceleave, dayspaid, empdoj, empsalary FROM EmployeDetails WHERE empid = 2



				select * from EmployeDetails
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeDetailspdf]    Script Date: 6/12/2024 3:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[GetEmployeeDetailspdf]
    @empid INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
    
        empname, 
        empdesignation, 
        empbankname ,
        employeeno ,
        empifsc ,
        empdoj ,
        empbankacno, 
        dayspaid ,
        emppan ,
        daysmoth ,
        empadhar ,
        balanceleave ,
		empsalary 

		from
       [EmployeDetails]
    WHERE 
        [empid] = @empid;
END
GO
USE [master]
GO
ALTER DATABASE [Leave] SET  READ_WRITE 
GO

INSERT INTO [dbo].[EmployeDetails] (
    empname, empemail, empContact, empbankname, empifsc, empbankacno, 
    emppan, empadhar, empdesignation, employeeno, daysmoth, balanceleave, 
    dayspaid, empdoj, empsalary, pass, CarryOverLeaves
) VALUES (
    'Aadi', 'Aadi@gmail.com', '1234567890', 'Bank of Example', 
    'IFSC123456', '1234567890123456', 'ABCDE1234F', '123456789012', 
    'Software Engineer', 'BMS001', 30, 5, 25, '2024-01-01', 75000.00, 
    'Aadi@123','5'
);


CREATE TABLE [dbo].[RaiseTicket](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[empname] [varchar](100) NULL,
	[Rolenames] [varchar](100) NULL,
	[Rolemembers] [varchar](100) NULL,
	[Problem] [text] NULL,
	[Attachment] [nvarchar](500) NULL,
	[status] [varchar](50) NOT NULL,
	[solution] [text] NULL,
	[date] [datetime] NOT NULL,
	[LastUpdated] [datetime] NULL,
 CONSTRAINT [PK_RaiseTic_712CC627082DF642] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[RaiseTicket] ADD  DEFAULT ('pending') FOR [status]
GO

ALTER TABLE [dbo].[RaiseTicket] ADD  DEFAULT (getdate()) FOR [date]
GO

CREATE PROCEDURE [dbo].[UpdateRaiseTicket]
    @TicketID INT,
    @Solution TEXT
AS
BEGIN
    UPDATE RaiseTicket
    SET solution = @Solution,
        status = 'done',
        LastUpdated = GETDATE()
    WHERE TicketID = @TicketID;
END;
GO