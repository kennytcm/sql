CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker(
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);

INSERT INTO Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Anson', 'Tang', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Amy', 'Chan', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Bob', 'Li', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'David', 'Lam', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Pika', 'Chu', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Bell', 'Chan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Hugo', 'Lam', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'John', 'Cheung', 90000, '14-04-11 09.00.00', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');


SELECT Title.WORKER_TITLE, Worker.FIRST_NAME, Worker.SALARY
FROM Worker
JOIN Title ON WORKER.WORKER_ID = Title.WORKER_REF_ID
ORDER BY Worker.SALARY desc, Worker.FIRST_NAME asc;

SELECT Worker.FIRST_NAME, ( SELECT SUM(Bonus.BONUS_AMOUNT) FROM Bonus Group By Bonus.WORKER_REF_ID)
FROM Bonus
INNER JOIN Worker ON Worker.WORKER_ID = Bonus.WORKER_REF_ID
WHERE Worker.DEPARTMENT = 'HR';


SELECT Bonus.WORKER_REF_ID,SUM(Bonus.BONUS_AMOUNT)
FROM Bonus
Group By Bonus.WORKER_REF_ID;
