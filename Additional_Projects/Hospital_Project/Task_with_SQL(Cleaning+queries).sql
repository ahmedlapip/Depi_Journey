SET SQL_SAFE_UPDATES = 0;

create database hospital; 
use hospital;
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY, 
    Name VARCHAR(50), 
    Age VARCHAR(20), 
    Gender VARCHAR(10), 
    Diagnosis VARCHAR(50), 
    Medication VARCHAR(50),  
    AdmissionDate DATE, 
    DischargeDate DATE,
    Doctor VARCHAR(50), 
    Department VARCHAR(45),
    Status VARCHAR(45)
);
ALTER TABLE Patients
MODIFY  Name VARCHAR(50) NULL;
INSERT INTO Patients (PatientID, Name, Age, Gender, Diagnosis, Medication, AdmissionDate, DischargeDate, Doctor, Department, Status) 
VALUES
(2001, 'John Doe', '45', 'Male', 'Hypertension', 'Med A', '2025-10-01', '2025-10-15', 'Dr. Smith', 'Cardiology', 'Admitted'),
(2002, 'Jane Smith', 'forty-five', 'Female', 'Diabetes', 'Med B', '2025-01-10', '2025-01-15', 'Dr. Lee', 'Endocrinology', 'admitted'),
(2003, 'Bob Brown', '55', 'Male', 'Asthma', 'Med C', '2025-01-10', '2025-01-15', 'Dr. Carter', 'Pulmonology', 'Under Observation'),
(2004, NULL, '30', 'Female', 'Flu', 'Med D', '2025-05-02', '2025-05-10', NULL, 'General Medicine', 'DISCHARGED'),
(2005, 'Tom Wilson', '62', 'Male', 'Heart Disease', 'Med E', '2025-01-03', '2025-01-10', 'Dr. Johnson', 'Cardiology', 'Discharged'),
(2006, 'Susan Clark', '49', 'Female', 'Kidney Disease', 'Med F', '2025-12-04', '2025-12-17', 'Dr. Patel', 'Nephrology', 'Admitted'),
(2007, 'David Jones', '37', 'Male', 'Pneumonia', 'Med G', '2025-05-20', '2025-05-25', 'Dr. Martinez', 'Pulmonology', 'admitted'),
(2008, 'Nancy Miller', '28', 'Female', 'Flu', 'Med D', '2025-06-15', '2025-06-20', 'Dr. Smith', 'General Medicine', 'Under Observation'),
(2009, 'Michael Scott', '40', 'Male', 'Hypertension', 'Med A', '2025-07-01', '2025-07-07', 'Dr. Smith', 'Cardiology', 'Admitted'),
(2010, 'Pam Beesly', '34', 'Female', 'Diabetes', 'Med B', '2025-08-10', '2025-08-15', 'Dr. Lee', 'Endocrinology', 'Discharged');

SELECT * FROM Patients;

##Remove duplicate records##
SELECT DISTINCT * FROM Patients;

##Standardize the AdmissionDate column to a consistent format##
UPDATE Patients
SET AdmissionDate = STR_TO_DATE(AdmissionDate, '%Y-%m-%d');   


#Normalize the Status column to lowercase##
UPDATE Patients
SET Status = LOWER(Status); 

##Replace missing values in columns with default values##
UPDATE Patients
SET Age = COALESCE(Age, '0');

UPDATE Patients
SET Diagnosis = COALESCE(Diagnosis, 'Unknown');

UPDATE Patients
SET Name = IFNULL(Name, 'unknown'),
    Doctor = IFNULL(Doctor, 'unknown');
    
select*from Patients;


##########################################################################################Queries##########################################################################


##What is the average age of patients for each diagnosis##
SELECT diagnosis, AVG(Age) AS average_age
FROM cleaned_for_queries
GROUP BY diagnosis;

##Which department has the highest number of admitted patients##
SELECT department, COUNT(*) AS number_of_patients
FROM cleaned_for_queries
GROUP BY department
ORDER BY number_of_patients DESC;

##How many patients have been discharged per month?##
SELECT YEAR(DischargeDate) AS year, MONTH(DischargeDate) AS month, COUNT(*) AS discharged_patients
FROM cleaned_for_queries
WHERE DischargeDate IS NOT NULL
GROUP BY YEAR(DischargeDate), MONTH(DischargeDate)
ORDER BY year, month;

##What is the most common diagnosis among patients##
SELECT Diagnosis, COUNT(*) AS number_of_patients
FROM cleaned_for_queries
GROUP BY Diagnosis
ORDER BY number_of_patients DESC;

## Which doctor has treated the most patients?##
SELECT Doctor, COUNT(*) AS number_of_patients
FROM cleaned_for_queries
GROUP BY Doctor
ORDER BY number_of_patients DESC;