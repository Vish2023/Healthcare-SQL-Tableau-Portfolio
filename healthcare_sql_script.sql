create database HealthcareSingleDB;
use HealthcareSingleDB;

SELECT 
    COUNT(*)
FROM
    healthcare;


ALTER TABLE healthcare
    CHANGE COLUMN `Name` `Patient_Name` VARCHAR(100),
    CHANGE COLUMN `Age` `Age` INT,
    CHANGE COLUMN `Gender` `Gender` VARCHAR(50),
    CHANGE COLUMN `Blood Type` `Blood_Type` VARCHAR(10),
    CHANGE COLUMN `Medical Condition` `Medical_Condition` VARCHAR(100),
    CHANGE COLUMN `Date of Admission` `Date_of_Admission` DATE,
    CHANGE COLUMN `Doctor` `Doctor` VARCHAR(100),
    CHANGE COLUMN `Hospital` `Hospital` VARCHAR(100),
    CHANGE COLUMN `Insurance Provider` `Insurance_Provider` VARCHAR(100),
    CHANGE COLUMN `Billing Amount` `Billing_Amount` DECIMAL(12,2),
    CHANGE COLUMN `Room Number` `Room_Number` INT,
    CHANGE COLUMN `Admission Type` `Admission_Type` VARCHAR(50),
    CHANGE COLUMN `Discharge Date` `Discharge_Date` DATE,
    CHANGE COLUMN `Medication` `Medication` VARCHAR(100),
    CHANGE COLUMN `Test Results` `Test_Results` VARCHAR(50);
    
    describe healthcare;
    
SELECT 
    *
FROM
    healthcare
LIMIT 5;

set sql_safe_updates = 0;
DELETE FROM healthcare 
WHERE
    Billing_Amount < 0;

set sql_safe_updates = 1;

SELECT 
    COUNT(*)
FROM
    healthcare;

SELECT 
    COUNT(DISTINCT Patient_Name) AS Unique_Patients,
    ROUND(AVG(Age), 2) AS Avg_Age
FROM
    healthcare;

SELECT 
    Medical_Condition,
    Gender,
    Admission_Type,
    COUNT(*) AS Total_Encounters,
    ROUND(AVG(Billing_Amount), 2) AS Avg_Billing
FROM
    healthcare
GROUP BY Medical_Condition , Gender , Admission_Type
ORDER BY Total_Encounters DESC;


SELECT 
    YEAR(Date_of_Admission) AS Year,
    MONTH(Date_of_Admission) AS Month,
    Gender,
    Admission_Type,
    COUNT(*) AS Total_Encounters
FROM
    healthcare
GROUP BY Year , Month , Gender , Admission_Type
ORDER BY Year, Month;

SELECT 
    Gender,
    Admission_Type,
    Medical_Condition,
    COUNT(*) AS Total_Encounters
FROM
    healthcare
WHERE
    Billing_Amount > (SELECT 
            AVG(Billing_Amount)
        FROM
            healthcare)
GROUP BY Gender , Admission_Type , Medical_condition
ORDER BY Gender;

SELECT 
    Hospital,
    Gender,
    Medical_condition,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing
FROM
    healthcare
WHERE
    Age > (SELECT 
            AVG(Age)
        FROM
            healthcare)
GROUP BY Hospital , Gender , Medical_Condition
ORDER BY Total_Billing DESC
LIMIT 5;

    
SELECT 
    h1.Patient_Name,
    h1.Medical_Condition,
    h1.Gender,
    h1.Admission_Type,
    COUNT(*) AS Repeat_Encounters
FROM
    healthcare h1
        INNER JOIN
    healthcare h2 ON h1.Patient_Name = h2.Patient_Name
        AND h1.Medical_Condition = h2.Medical_Condition
        AND h1.Date_of_Admission < h2.Date_of_Admission
GROUP BY h1.Patient_Name , h1.Medical_Condition , h1.Gender , h1.Admission_Type
ORDER BY Repeat_Encounters DESC;