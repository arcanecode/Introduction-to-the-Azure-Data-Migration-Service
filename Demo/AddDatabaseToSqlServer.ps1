param(
    [string]
    $userName,
	
  	[string]
	  $password
)

if ((Get-Command Install-PackageProvider -ErrorAction Ignore) -eq $null)
{
	# Load the latest SQL PowerShell Provider
	(Get-Module -ListAvailable SQLPS `
		| Sort-Object -Descending -Property Version)[0] `
		| Import-Module;
}
else
{
	# Conflicts with SqlServer module
	Remove-Module -Name SQLPS -ErrorAction Ignore;

	if ((Get-Module -ListAvailable SqlServer) -eq $null)
	{
		Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null;
		Install-Module -Name SqlServer -Force -AllowClobber | Out-Null;
	}

	# Load the latest SQL PowerShell Provider
	Import-Module -Name SqlServer;
}

$query = @'
CREATE DATABASE Pluralsight;
GO

USE Pluralsight;
GO

CREATE TABLE dbo.ArcaneCourses (
  CourseKey  INT IDENTITY PRIMARY KEY
, Title      NVARCHAR(256)
, Link       NVARCHAR(256)
)
GO

INSERT dbo.ArcaneCourses
  (Title, Link)
VALUES
  ('Getting Started with PowerShell Core for Linux and macOS', 'https://www.pluralsight.com/courses/getting-started-powershell-core-linux-macos')
, ('Building Your First SSRS Report (with SQL Server 2017)''https://www.pluralsight.com/courses/ssrs-building-your-first-report')
, ('Kusto Query Language (KQL) from Scratch This is a free course, you do not have to have a paid subscription to watch!', 'https://app.pluralsight.com/library/courses/kusto-query-language-kql-from-scratch/table-of-contents')
, ('Azure PowerShell Playbook: Azure SQL', 'https://www.pluralsight.com/courses/azure-powershell-sql-playbook')
, ('Introduction to Data Warehousing / Business Intelligence', 'https://app.pluralsight.com/library/courses/intro-dwbi-course-2017/table-of-contents')
, ('SQL Server Reporting Services Playbook', 'https://www.pluralsight.com/courses/sql-server-reporting-playbook')
, ('Whats New in SQL Server 2016 Reporting Services' , 'https://www.pluralsight.com/courses/sql-server-2016-reporting-services')
, ('Testing PowerShell with Pester', 'https://www.pluralsight.com/courses/powershell-testing-pester')
, ('Beginning PowerShell Scripting for Developers', 'https://www.pluralsight.com/courses/beginning-powershell-scripting-developers')
, ('SSIS Design Patterns for Data Warehousing', 'https://www.pluralsight.com/courses/ssis-design-patterns-data-warehousing')
, ('Whats New in PowerShell Version 3', 'https://www.pluralsight.com/courses/whats-new-in-psv3')
, ('PowerShell and SQL Server', 'https://www.pluralsight.com/courses/powershell-and-sql-server')
, ('Introduction to PowerShell', 'https://www.pluralsight.com/courses/powershell-intro')
, ('Managing PowerPivot in SharePoint 2010', 'https://www.pluralsight.com/courses/powerpivot-sp-management')
, ('PowerPivot for SharePoint 2010 System Setup', 'https://www.pluralsight.com/courses/powerpivot-for-sp-setup')
, ('Visual Studio 2010 Database Projects', 'https://www.pluralsight.com/courses/vs-db')
, ('Introduction to Data Warehousing and Business Intelligence (2010 Version)', 'https://www.pluralsight.com/courses/intro-dwbi-course')
, ('PowerPivot for Microsoft Excel 2010', 'https://www.pluralsight.com/courses/powerpivot-for-excel')
GO
'@


Invoke-Sqlcmd `
  -QueryTimeout 0 `
  -ServerInstance . `
  -UserName $username `
  -Password $password `
	-Query $query
	