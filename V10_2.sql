--задание а)
/*ALTER TABLE [dbo].[Employee]
ADD [SumSubTotal] [MONEY]

ALTER TABLE [dbo].[Employee]
ADD [LeaveHours] AS [VacationHours] + [SickLeaveHours] */

--задание b)
--drop table #Employee
CREATE TABLE #Employee 
	([BusinessEntityID] [int] NOT NULL,
	[NationalIDNumber] [nvarchar](15) NOT NULL,
	[LoginID] [nvarchar](256) NOT NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[MaritalStatus] [nchar] NOT NULL,
	[Gender] [nchar] NOT NULL,
	[HireDate] [date] NOT NULL,
	[VacationHours] [smallint] NOT NULL,
	[SickLeaveHours] [smallint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SumSubTotal] [MONEY] NULL,
	ID [BIGINT] IDENTITY(0,2) PRIMARY KEY)

--задание c)
INSERT INTO #Employee(
	[BusinessEntityID],
	[NationalIDNumber],
	[LoginID],
	[JobTitle],
	[BirthDate],
	[MaritalStatus],
	[Gender],
	[HireDate],
	[VacationHours],
	[SickLeaveHours],
	[ModifiedDate])
SELECT  [BusinessEntityID],
	[NationalIDNumber],
	[LoginID],
	[JobTitle],
	[BirthDate],
	[MaritalStatus],
	[Gender],
	[HireDate],
	[VacationHours],
	[SickLeaveHours],
	[ModifiedDate]
	FROM [dbo].[Employee]
	
	UPDATE #Employee
	SET SumSubTotal = (SELECT SUM([SubTotal]) FROM Purchasing.PurchaseOrderHeader GROUP BY EmployeeID).[SubTotal]
	FROM Purchasing.PurchaseOrderHeader
	WHERE #Employee.BusinessEntityID = Purchasing.PurchaseOrderHeader.EmployeeID
	select * from dbo.Employee
	--задание d)
	DELETE [dbo].[Employee]
	WHERE [dbo].[Employee].[LeaveHours] > 160
	