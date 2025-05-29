/* 
===============================================
📌 Part 1: Backup Types Summary
===============================================

------------------------------------------------------------
 Full Backup
------------------------------------------------------------
When Used       : Regular baseline ( weekly)
What It Includes: Entire database (data + transaction log at backup time)
Pros            : Simple, reliable recovery point
Cons            : Slow for large DBs, space-intensive
Real Example    : Hospital full weekly backup

------------------------------------------------------------
Differential Backup
------------------------------------------------------------
When Used       : After full backup ( daily)
What It Includes: Changes since last full backup
Pros            : Smaller, faster than full backup
Cons            : Useless without the latest full backup
Real Example    : Nightly backups for LMS

------------------------------------------------------------
 Transaction Log
------------------------------------------------------------
When Used       : Frequently ( hourly) for point-in-time recovery
What It Includes: All transactions since last log backup
Pros            : Enables PIT recovery, small in size
Cons            : Requires full recovery model, must chain backups
Real Example    : Hourly logs in ticketing system

------------------------------------------------------------
 Copy-Only
------------------------------------------------------------
When Used       : Ad-hoc backups that don’t disrupt backup chain
What It Includes: Snapshot without affecting differential base
Pros            : Safe for testing, auditing
Cons            : Doesn’t replace regular full backups
Real Example    : Dev team testing new hospital module

------------------------------------------------------------
 File/Filegroup
------------------------------------------------------------
When Used       : Large DBs with isolated filegroups (nightly per filegroup)
What It Includes: Specific file/filegroup
Pros            : Efficient for large DBs, faster restores
Cons            : Not all systems use filegroups, more complex
Real Example    : Banking with partitioned transaction DB

*/


-- ================================================
-- PART 2: Practice SQL with TrainingDB
-- ================================================

-- Step 1: Create the training database
CREATE DATABASE TrainingDB;
GO

USE TrainingDB;
GO

-- Step 2: Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    EnrollmentDate DATE
);
GO
INSERT INTO Students VALUES  
(1, 'Sara Ali', '2023-09-01'), 
(2, 'Mohammed Nasser', '2023-10-15'); 

-- Step 3: Insert sample data

-- Step 4: Full backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB.bak'
;
GO

-- Step 5: Add more data
INSERT INTO Students VALUES 
(3, 'Fatma Said', '2024-01-10');
GO

-- Step 6: Differential backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB.bak' 
WITH DIFFERENTIAL;
GO

-- Step 7: Change to FULL recovery model
ALTER DATABASE TrainingDB 
SET RECOVERY FULL;
GO

-- Step 8: Transaction log backup
BACKUP LOG TrainingDB 
TO DISK = 'C:\Backups\TrainingDB_Log.trn';
GO

-- Step 9: Copy-only backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Log.trn'
WITH COPY_ONLY;
GO

-- ================================================
-- PART 3: HospitalDB Real-World Backup Plan
-- ================================================

-- Weekly Full Backup (Sunday 2 AM)
BACKUP DATABASE HospitalDB 
TO DISK = 'C:\HospitalBackups\HospitalDB_Full_20250525.bak';
GO

-- Daily Differential Backup (Monday–Saturday 2 AM)
BACKUP DATABASE HospitalDB 
TO DISK = 'C:\HospitalBackups\HospitalDB_Diff_20250526.bak' 
WITH DIFFERENTIAL;
GO

-- Hourly Transaction Log Backup
BACKUP LOG HospitalDB 
TO DISK = 'C:\HospitalBackups\HospitalDB_Log_20250526_0800.trn';
GO
