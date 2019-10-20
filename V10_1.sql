-- Задание а)
/*ALTER TABLE dbo.Employee
ADD Name NVARCHAR(50) NULL;*/

-- Задание b)
DECLARE @Variable TABLE ([BusinessEntityID] [int] NOT NULL,
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
	[ID][BIGINT] IDENTITY(0,2) PRIMARY KEY,
	[Name] [NVARCHAR](50) NULL)

INSERT INTO @Variable
SELECT TOP 160 [dbo].[Employee].[BusinessEntityID],
	[dbo].[Employee].[NationalIDNumber],
	[LoginID],
	[JobTitle],
	[BirthDate],
	[MaritalStatus],
	[Gender],
	[HireDate],
	[VacationHours],
	[SickLeaveHours],
	[dbo].[Employee].[ModifiedDate],
	ISNULL([Title], 'M.') + [FirstName]
	FROM [dbo].[Employee], [Person].[Person]
	WHERE [dbo].[Employee].[BusinessEntityID] = [Person].[Person].[BusinessEntityID]

-- Задание c)
UPDATE [dbo].[Employee]
SET [Name] = [@Variable].[Name]
FROM @Variable
WHERE [dbo].[Employee].[BusinessEntityID] = [@Variable].[BusinessEntityID]



-- Задание d)
DELETE [dbo].[Employee]
WHERE [dbo].[Employee].[BusinessEntityID] = (
	SELECT BusinessEntityID 
	FROM HumanResources.EmployeeDepartmentHistory
	WHERE EndDate != NULL)

-- Задание e)
ALTER TABLE [dbo].[Employee] DROP COLUMN Name
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT birth_date_limit
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT PK__Employee__3214EC27A47836C6

-- код для поиска ограничений по умолчанию
/*SELECT OBJECT_NAME(parent_object_id) AS TableName, name AS ConstraintName
FROM sys.default_constraints ORDER BY TableName, ConstraintName*/

ALTER TABLE [dbo].[Employee] DROP CONSTRAINT default_type
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT DF_Employee_CurrentFlag
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT DF_Employee_ModifiedDate
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT DF_Employee_rowguid
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT DF_Employee_SalariedFlag
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT DF_Employee_SickLeaveHours
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT DF_Employee_VacationHours

-- Задание f)
DROP TABLE [dbo].[Employee] 
