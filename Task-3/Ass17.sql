 -- Task 17: Create SQL Server User with DB Owner Permission

-- Step 1: Create Login
CREATE LOGIN intern_user WITH PASSWORD = 'StrongPassword123!';

-- Step 2: Create User in current database
CREATE USER intern_user FOR LOGIN intern_user;


