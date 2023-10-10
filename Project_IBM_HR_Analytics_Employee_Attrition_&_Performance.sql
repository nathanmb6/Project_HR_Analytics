-- Create the HR_Analytics_Employee database.
CREATE DATABASE HR_Analytics_Employee;

-- Use the hr_analytics_employee database.
USE hr_analytics_employee;

-- View the overall data.
SELECT * FROM employee_performance;

/* 
    -- Drop columns: 
    These columns do not have a meaningful definition crucial for the analyst.

    1. Over18: All values are 'Y' (Above 18 Years Old).
    2. EmployeeCount: All values in this column are 1.
    3. EmployeeNumber: All values indicate an ID and don't affect the analyst's result.
    4. StandardHours: All values in this column are 80.0.

    -- Classification Definition:

    Education
    1 'Below College'
    2 'College'
    3 'Bachelor'
    4 'Master'
    5 'Doctor'

    EnvironmentSatisfaction
    1 'Low'
    2 'Medium'
    3 'High'
    4 'Very High'

    JobInvolvement
    1 'Low'
    2 'Medium'
    3 'High'
    4 'Very High'

    JobSatisfaction
    1 'Low'
    2 'Medium'
    3 'High'
    4 'Very High'

    PerformanceRating
    1 'Low'
    2 'Good'
    3 'Excellent'
    4 'Outstanding'

    RelationshipSatisfaction
    1 'Low'
    2 'Medium'
    3 'High'
    4 'Very High'

    WorkLifeBalance
    1 'Bad'
    2 'Good'
    3 'Better'
    4 'Best'
*/

-- Remove less meaningful columns.
ALTER TABLE employee_performance
    DROP COLUMN over18,
    DROP COLUMN EmployeeCount,
    DROP COLUMN EmployeeNumber,
    DROP COLUMN StandardHours;

-- Ensure there are no empty values in the data.
SELECT * FROM employee_performance WHERE `Department` IS NULL;

-- Modify the data types of columns for ease of analysis.
ALTER TABLE employee_performance
    MODIFY `Attrition` ENUM('Yes','No') NOT NULL,
    MODIFY `BusinessTravel` TEXT NOT NULL,
    MODIFY `Education` VARCHAR(15) NOT NULL,
    MODIFY `EnvironmentSatisfaction` VARCHAR(15) NOT NULL,
    MODIFY `JobInvolvement` VARCHAR(15) NOT NULL,
    MODIFY `JobSatisfaction` VARCHAR(15) NOT NULL,
    MODIFY `PerformanceRating` VARCHAR(15) NOT NULL,
    MODIFY `RelationshipSatisfaction` VARCHAR(15) NOT NULL,
    MODIFY `WorkLifeBalance` VARCHAR(15) NOT NULL;

-- View the structural description of the table.
DESCRIBE employee_performance;

-- View the table creation structure.
SHOW CREATE TABLE employee_performance;

-- Interpret the classified data.
UPDATE employee_performance
SET Education = 
    CASE 
        WHEN `Education` = 1 THEN  'Below College'
        WHEN `Education` = 2 THEN  'College'
        WHEN `Education` = 3 THEN  'Bachelor'
        WHEN `Education` = 4 THEN  'Master'
        ELSE  'Doctor'
    END
WHERE Education BETWEEN 1 AND 5;

-- Update the EnvironmentSatisfaction column.
UPDATE employee_performance 
SET `EnvironmentSatisfaction` =
    CASE 
        WHEN `EnvironmentSatisfaction` = 1 THEN 'Low'
        WHEN `EnvironmentSatisfaction` = 2 THEN 'Medium'
        WHEN `EnvironmentSatisfaction` = 3 THEN 'High'
        ELSE  'Very High'
    END
WHERE `EnvironmentSatisfaction` BETWEEN 1 AND 4;

-- Update the JobInvolvement column.
UPDATE employee_performance
SET `JobInvolvement`=
    CASE 
        WHEN `JobInvolvement` = 1 THEN 'Low'
        WHEN `JobInvolvement` = 2 THEN 'Medium'
        WHEN `JobInvolvement` = 3 THEN 'High'
        ELSE  'Very High'
    END
WHERE `JobInvolvement` BETWEEN 1 AND 4;

-- Update the JobSatisfaction column.
UPDATE employee_performance
SET `JobSatisfaction` =
    CASE 
        WHEN `JobSatisfaction` = 1 THEN 'Low'
        WHEN `JobSatisfaction` = 2 THEN 'Medium'
        WHEN `JobSatisfaction` = 3 THEN 'High'
        ELSE  'Very High'
    END
WHERE `JobSatisfaction` BETWEEN 1 AND 4;

-- Update the PerformanceRating column.
UPDATE employee_performance
SET `PerformanceRating` =
    CASE 
        WHEN `PerformanceRating` = 1 THEN 'Low'
        WHEN `PerformanceRating` = 2 THEN 'Good'
        WHEN `PerformanceRating` = 3 THEN 'Excellent'
        ELSE  'Outstanding'
    END
WHERE `PerformanceRating` BETWEEN 1 AND 4;

-- Update the RelationshipSatisfaction column.
UPDATE employee_performance
SET `RelationshipSatisfaction` =
    CASE 
        WHEN `RelationshipSatisfaction` = 1 THEN 'Low'
        WHEN `RelationshipSatisfaction` = 2 THEN 'Medium'
        WHEN `RelationshipSatisfaction` = 3 THEN 'High'
        ELSE  'Very High'
    END
WHERE `RelationshipSatisfaction` BETWEEN 1 AND 4;

-- Update the WorkLifeBalance column.
UPDATE employee_performance
SET `WorkLifeBalance` =
    CASE 
        WHEN `WorkLifeBalance` = 1 THEN 'Bad'
        WHEN `WorkLifeBalance` = 2 THEN 'Good'
        WHEN `WorkLifeBalance` = 3 THEN 'Better'
        ELSE  'Best'
    END
WHERE `WorkLifeBalance` BETWEEN 1 AND 4;

    /* Exploratory Data Analyst(EDA) */ 

-- 1. How many Employee Attrition by looking at how frequently doing Business Travel?
SELECT 
    BusinessTravel, 
    Attrition, 
    COUNT(`Attrition`) AS Total_Attrition
FROM employee_performance
GROUP BY `BusinessTravel`, `Attrition`
ORDER BY `BusinessTravel` DESC;

-- 2. How many employees experience attrition in each department?
SELECT 
    Department, 
    Attrition, 
    COUNT(`Department`) AS Total_Attrition
FROM employee_performance
GROUP BY `Department`, `Attrition`
ORDER BY `Department` DESC;

-- 3. Does the Employee Education Effect on Attrition?
SELECT 
    EducationField, 
    Attrition, 
    COUNT(`Attrition`) AS Total_Attrition
FROM employee_performance
GROUP BY `EducationField`, `Attrition`
ORDER BY `EducationField` DESC;

-- 4. How is the risk of Attrition according the Environment?
SELECT 
    EnvironmentSatisfaction, 
    Attrition, 
    COUNT(`Attrition`) AS Total_Attrition
FROM employee_performance
GROUP BY `EnvironmentSatisfaction`, `Attrition`
ORDER BY `EnvironmentSatisfaction` DESC;

-- 5. How is the WorkLIfeBalance effect on Attrition?
SELECT 
    WorkLifeBalance,
    Attrition,
    COUNT(`Attrition`) AS Total_Attrition
FROM employee_performance
GROUP BY `WorkLifeBalance`, `Attrition`
ORDER BY `WorkLifeBalance` DESC;

-- 6. Check every department about Employee Environment
SELECT 
    Department, 
    EnvironmentSatisfaction, 
    COUNT(`EnvironmentSatisfaction`) As Total_Satisfaction
FROM employee_performance
GROUP BY `Department`, `EnvironmentSatisfaction`
ORDER BY `Department` DESC;

-- 7. How's the Employee Job Role Condition?
SELECT 
    JobRole, 
    JobSatisfaction, 
    COUNT(`JobSatisfaction`) AS Total_Satisfaction
FROM employee_performance
GROUP BY `JobRole`, `JobSatisfaction`
ORDER BY `JobRole` DESC;

-- 8. Does every employee get along with all of their coworkers?
SELECT 
    Department, 
    RelationshipSatisfaction, 
    COUNT(`RelationshipSatisfaction`) AS Total_Satisfaction
FROM employee_performance
GROUP BY `Department`, `RelationshipSatisfaction`
ORDER BY `Department` DESC;

-- 9. Check the employee Marital Status to look out the WorkLIfeBalance effect
SELECT 
    MaritalStatus,
    WorkLifeBalance,
    COUNT(`WorkLifeBalance`) AS Total_Satisfaction
FROM employee_performance
GROUP BY `MaritalStatus`, `WorkLifeBalance`
ORDER BY `MaritalStatus` DESC;

-- 10. Take a look Employee Marital Status about their Performance
SELECT
    MaritalStatus,
    PerformanceRating,
    COUNT(`MaritalStatus`) AS Performance_Rate
FROM employee_performance
GROUP BY `MaritalStatus`, `PerformanceRating`
ORDER BY `MaritalStatus` DESC;

-- 11. Find out Employee Performance according how frequently doing Business Travel?
SELECT
    BusinessTravel,
    PerformanceRating,
    COUNT(`BusinessTravel`) AS Performace_Rate
FROM employee_performance
GROUP BY `BusinessTravel`, `PerformanceRating`
ORDER BY `BusinessTravel` DESC;

-- 12. How's the Relationship between Coworkers effecting on the Performance?
SELECT 
    RelationshipSatisfaction,
    PerformanceRating,
    COUNT(`RelationshipSatisfaction`) AS Performance_Rate
FROM employee_performance
GROUP BY `RelationshipSatisfaction`, `PerformanceRating`
ORDER BY `RelationshipSatisfaction` DESC;

-- 13. How's the employee financial situation within their job positions?
SELECT 
    `JobRole`,
    MIN(`MonthlyIncome`) AS Min_Income,
    MAX(`MonthlyIncome`) AS Max_Income,
    AVG(`PercentSalaryHike`) AS Average_Salary_Increase
FROM employee_performance
GROUP BY `JobRole`
ORDER BY `JobRole` DESC;