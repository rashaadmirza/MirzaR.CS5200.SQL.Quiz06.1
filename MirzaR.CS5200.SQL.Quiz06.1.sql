/* Rashaad Mirza -- CS5200-01, Summer Full 2024 */

/* Q1 */
SELECT COUNT(DISTINCT WORKER_ID) AS distinct_hr_workers
FROM Worker
WHERE DEPARTMENT = 'HR'
  AND SALARY > 250000;

/* Q2 */
WITH AvgSalary AS (
    SELECT AVG(SALARY) AS avg_salary
    FROM Worker
)
SELECT w.LAST_NAME, t.WORKER_TITLE, w.DEPARTMENT
FROM Worker w
JOIN Title t ON w.WORKER_ID = t.WORKER_REF_ID
WHERE w.SALARY < (SELECT avg_salary FROM AvgSalary);

/* Q3 */
SELECT 
    DEPARTMENT,
    AVG(SALARY) AS AvgSal,
    COUNT(WORKER_ID) AS Num
FROM 
    Worker
GROUP BY 
    DEPARTMENT;

/* Q4 */
SELECT 
    w.FIRST_NAME || ' ' || w.LAST_NAME AS WorkerName,
    t.WORKER_TITLE AS Title,
    ROUND((w.SALARY + IFNULL(SUM(b.BONUS_AMOUNT), 0)) / 12) AS MonthlyComp
FROM 
    Worker w
LEFT JOIN 
    Bonus b ON w.WORKER_ID = b.WORKER_REF_ID
JOIN 
    Title t ON w.WORKER_ID = t.WORKER_REF_ID
GROUP BY 
    w.WORKER_ID, WorkerName, Title, w.SALARY
ORDER BY 
    WorkerName;

/* Q5 */
SELECT 
    UPPER(w.FIRST_NAME || ' ' || w.LAST_NAME) AS FullName
FROM 
    Worker w
LEFT JOIN 
    Bonus b ON w.WORKER_ID = b.WORKER_REF_ID
WHERE 
    b.BONUS_AMOUNT IS NULL;

/* Q6 */
SELECT 
    w.FIRST_NAME || ' ' || w.LAST_NAME AS FullName
FROM 
    Worker w
JOIN 
    Title t ON w.WORKER_ID = t.WORKER_REF_ID
WHERE 
    t.WORKER_TITLE LIKE '%Manager%';
