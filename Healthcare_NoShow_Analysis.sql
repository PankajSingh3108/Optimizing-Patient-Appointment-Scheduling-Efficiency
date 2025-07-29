ALTER TABLE HealthCare_Appointments
ALTER COLUMN No_Show VARCHAR(3);

 --1. Total Appointments & No-Shows
SELECT 
    No_Show,
    COUNT(*) AS Total_Appointments,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM Healthcare_Appointments), 2) AS Percentage
FROM Healthcare_Appointments
GROUP BY No_Show;



select * from Healthcare_Appointments

 --2. No-Show Rate by Gender
WITH GenderStats AS (
    SELECT 
        Gender,
        COUNT(*) AS Total_Appointments,
        SUM(CAST(No_Show AS INT)) AS No_Show_Count
    FROM Healthcare_Appointments
    GROUP BY Gender
)

SELECT 
    Gender,
    Total_Appointments,
    No_Show_Count,
    ROUND(
        100.0 * No_Show_Count / Total_Appointments,
        2
    ) AS No_Show_Percentage
FROM GenderStats
ORDER BY No_Show_Percentage DESC;

--No-Show Rate by Day of the Week
SELECT 
    DATENAME(WEEKDAY, Appointment_Date) AS Weekday,
    DATEPART(WEEKDAY, Appointment_Date) AS Weekday_Number,
    COUNT(*) AS Total_Appointments,
    SUM(CAST(No_Show AS INT)) AS No_Show_Count,
    ROUND(
        100.0 * SUM(CAST(No_Show AS INT)) / COUNT(*),
        2
    ) AS No_Show_Percentage
FROM Healthcare_Appointments
GROUP BY DATENAME(WEEKDAY, Appointment_Date), DATEPART(WEEKDAY, Appointment_Date)
ORDER BY Weekday_Number;

--No-Show Rate Based on SMS Reminder

SELECT 
    SMS_Received,
    COUNT(*) AS Total_Appointments,
    SUM(CAST(No_Show AS INT)) AS No_Show_Count,
    ROUND(
        100.0 * SUM(CAST(No_Show AS INT)) / COUNT(*),
        2
    ) AS No_Show_Percentage
FROM Healthcare_Appointments
GROUP BY SMS_Received
ORDER BY SMS_Received DESC;
