-- Step 1: Simulate crash by dropping the database
DROP DATABASE TrainingDB;
GO

-- Step 2.1: Restore Full Backup (leave DB non-operational)
RESTORE DATABASE TrainingDB
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Full.bak'
WITH NORECOVERY;
GO

-- Step 2.2: Restore Differential Backup (if available)
RESTORE DATABASE TrainingDB
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Diff.bak'
WITH NORECOVERY;
GO

-- Step 2.3: Restore Transaction Log Backup (final step)
RESTORE LOG TrainingDB
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Log.trn'
WITH RECOVERY;
GO

-- Step 3: Verify restored data
USE TrainingDB;
SELECT * FROM Students;
