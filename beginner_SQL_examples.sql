-- Query 1: How to create database, select * from 

CREATE TABLE student(
  student_id INT ,
  name VARCHAR(20),
  major VARCHAR(20),
  PRIMARY KEY(student_id)   
);

DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3, 2);
ALTER TABLE student DROP COLUMN gpa;


SELECT * FROM student;

INSERT INTO student VALUES(1,'Jack', 'Biology');
INSERT INTO student VALUES(2,'Kate','Sociology');
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack','Biology');
INSERT INTO student VALUES(5, 'Mike','Computer Science');


SELECT *FROM student;

UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Biology' OR major ='Chemistry'


SELECT *
FROM student
WHERE major IN ('Biology', 'Chemistry') AND student_id > 2;

-- Query 2: Primary key, Foreign Key etc

CREATE TABLE Employee (
  Emp_id INT PRIMARY KEY,
  First_name VARCHAR(40),
  Last_name VARCHAR(40),
  Birth_day DATE,
  Sex VARCHAR(1),
  Salary INT,
  Super_id INT,
  Branch_id int
);



ALTER TABLE employee
ADD FOREIGN KEY(Branch_id)
REFERENCES branch(Branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(Super_id)
REFERENCES employee(Emp_id)
ON DELETE SET NULL;



CREATE TABLE Branch(
  Branch_id INT PRIMARY KEY,
  Branch_name VARCHAR(40),
  Mgr_id INT,
  Mgr_start_date DATE,
    FOREIGN KEY(Mgr_id) REFERENCES employee(Emp_id) ON DELETE SET NULL
);


CREATE TABLE Client(
  Client_id INT PRIMARY KEY,
  Client_name VARCHAR(40),
  Branch_id INT,
  FOREIGN KEY(Branch_id) REFERENCES branch(Branch_id) ON DELETE SET NULL
);



CREATE TABLE Works_with(
  Emp_id INT,
  Client_id INT,
  Total_sales INT,
  PRIMARY KEY(Emp_id, Client_id),
  FOREIGN KEY (Emp_id) REFERENCES employee(Emp_id) ON DELETE CASCADE,
  FOREIGN KEY(Client_id)REFERENCES Client(Client_id)ON DELETE CASCADE
);



CREATE TABLE Branch_supplier(
  Branch_id INT,
  Supplier_name VARCHAR(40),
  Supplier_type VARCHAR(40),
  PRIMARY KEY(Branch_id, Supplier_name),
  FOREIGN KEY(Branch_id) REFERENCES branch(Branch_id) ON DELETE CASCADE
);





-- Query 3: Insert into


-- CORPORATE
INSERT INTO employee VALUES(100,'David','Wallance','1967-11-17','M',250000, NULL,NULL);

INSERT INTO branch VALUES(1, 'Corporate',100, '2006-02-09');

UPDATE employee
SET Branch_id =1
WHERE Emp_id =100;

INSERT INTO employee VALUES(101,'Jan','Levinson','1961-05-11', 'F',110000,100,1);



-- SCRANTON
INSERT INTO employee VALUES(102, 'Micheal','Scott','1964-03-15','M', 75000, 100,NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET Branch_id =2
WHERE Emp_id =102;

INSERT INTO employee VALUES (103,'Angela','Martin','1971-06-25','F', 51000, 102,2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor','1980-02-05', 'F',56000,102,2);
INSERT INTO employee VALUES(105, 'Stanley','Hudson','1958-02-19', 'M', 59000, 102, 2);



-- STANDFORD
INSERT INTO employee VALUES(106,'Josh','Porter','1969-09-05','M',79000,100,NULL);

INSERT INTO branch VALUES(3, 'Standford', 106, '1969-09-05');

UPDATE employee
SET Branch_id =3
WHERE Emp_id =106;

INSERT INTO employee VALUES (107,'Andy','Bernard','1973-07-22','M', 65000, 106,3);
INSERT INTO employee VALUES (108,'Jim','Halpert','1978-10-01','M', 71000, 106,3);



-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball','Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot paper','Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T.Forms & Label','Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball','Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(3, 'Standford Label ','Custom Forms');



-- CLIENT
INSERT INTO client VALUES(400,'Dunmore Highschool',2);
INSERT INTO client VALUES(401,'Lackawana Country',2);
INSERT INTO client VALUES(402,'FedEx',3);
INSERT INTO client VALUES(403,'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404,'Scranton Whitepages',2);
INSERT INTO client VALUES(405,'Times Newspaper',3);
INSERT INTO client VALUES(406,'FedEx',2);



-- WORKS WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);




-- Query 4: Find Function, Order By


-- FIND ALL EMPLOYEES
SELECT * 
FROM employee;


-- FIND ALL CLIENTS
SELECT *
FROM client;


-- FIND EMPLOYEES ORDERED BY SALARY
SELECT *
FROM employee
ORDER BY Salary DESC;


-- FIND ALL EMPLOYEES ORDERED BY SEX THEN NAME 
SELECT *
FROM employee
ORDER BY Sex,First_name,Last_name;


-- FIND THE FIRST 5 EMPLOYEES IN THE TABLE 
SELECT *
FROM employee
LIMIT 5;


-- FIND THE FIRST AND LAST NAMES OF ALL EMPLOYEES
SELECT First_name , Last_name
FROM employee;


-- FIND THE FORENAME AND SURNAME OF ALL EMPLOYEES
SELECT First_name AS Forename , Last_name AS Surname
FROM employee;


-- FIND OUT ALL THE DIFFERENT GENDERS
SELECT DISTINCT Sex
FROM employee;



-- FIND THE NUMBER OF EMPLOYEES
SELECT COUNT(Emp_id)
FROM employee;


-- FIND THE NUBER OF PEOPLE WHO HAVE SUPERVISOR
SELECT COUNT(Super_id)
FROM employee;



-- FIND THE NUMBER OF FEMALE EMPLOYEES BORN AFTER 1970
SELECT COUNT(Emp_id)
FROM employee
WHERE Sex = 'F' AND Birth_day >'1970-01-01';


-- FIND THE AVERAGE OF ALL THE EMPLOYEE'S SALARIES
SELECT AVG(Salary)
FROM employee;


-- FIND THE SUM OF ALL EMPLOYEE'S SALARIES
SELECT SUM(Salary)
FROM employee;


-- FIND OUT HOW MANY MALES AND FEMALES THERE ARE
SELECT COUNT(SEX), Sex
FROM employee
GROUP BY SEX;


-- FIND THE TOTAL SALES OF EACH SALESMEN
SELECT SUM(Total_sales), Emp_id
FROM works_with
GROUP BY Emp_id;


-- FIND THE TOTAL SPENT BY CLIENTS
SELECT SUM(Total_sales), Client_id
FROM works_with
GROUP BY Client_id;


-- Query 5 : Find, Seclect * From, Where, Union etc


-- FIND ANY CLIENT'S WHO ARE IN LLC
SELECT *
FROM client
WHERE Client_name LIKE '%LLC';


-- FIND ANY BRANCH SUPPLIERS WHO ARE IN THE LABEL BUSINESS
SELECT *
FROM branch_supplier
WHERE Supplier_name LIKE '%Label%';


-- FIND ANY EMPLOYEE BORN IN OCTOBER
SELECT *
FROM employee
WHERE Birth_day LIKE '____-10%';


-- FIND ANY CLIENTS WHO ARE SCHOOLS
SELECT *
FROM client
WHERE Client_name LIKE '%School%';



-- FIND A LIST OF EMPLOYEE, BRANCH NAMES AND CLIENT NAMES
SELECT First_name 
FROM employee
UNION
SELECT Branch_name
FROM branch
UNION 
SELECT Client_name
FROM client;


-- FIND A LIST OF ALL CLIENTS & BRANCH SUPPLIERS' NAMES
SELECT Client_name, client.Branch_id
FROM client
UNION 
SELECT Supplier_name, branch_supplier.Branch_id
FROM branch_supplier;


-- FIND A LIST OF ALL MONEY SPENT OR EARNED BY THE COMPANY
SELECT Salary
FROM employee
UNION 
SELECT Total_sales
FROM works_with;



-- Query 6: Limit,>,< ,= etc


INSERT INTO branch VALUES(4,'Buffalo',NULL,NULL);


-- FIND ALL BRANCHES AND THE NAMES OF THEIR MANAGERS(INNER JOIN)
SELECT employee.Emp_id, employee.First_name, branch.Branch_name
FROM employee
JOIN branch
ON employee.Emp_id = branch.Mgr_id;


-- FIND ALL BRANCHES AND THE NAMES OF THEIR MANAGERS (LEFT JOIN)
SELECT employee.Emp_id, employee.First_name, branch.Branch_name
FROM employee
LEFT JOIN branch
ON employee.Emp_id = branch.Mgr_id;


-- FIND ALL BRANCHES AND THE NAMES OF THEIR MANAGERS (RIGHT JOIN)
SELECT employee.Emp_id, employee.First_name, branch.Branch_name
FROM employee
RIGHT JOIN branch
ON employee.Emp_id = branch.Mgr_id;




-- FIND NAMES OF ALL EMPLOYEES WHO HAVE
-- SOLD OVER 30,000 TO A SINGLE CLIENT
SELECT employee.First_name, employee.Last_name
FROM employee
WHERE employee.Emp_id IN (
  SELECT works_with.Emp_id 
FROM works_with
WHERE works_with.Total_sales > 30000
);



-- FIND ALL CLIENTS WHO ARE HANDLED BY THE BRANCH THAT MICHEAL SCOTT MANAGES, ASSUME YOU KNOW MICHEAL'S ID
SELECT client.Client_name
FROM client
WHERE client.Branch_id=(
  SELECT branch.Branch_id
  FROM branch
  WHERE branch.Mgr_id = 102
  LIMIT 1
);



-- Query 7: Trigger Test


CREATE TABLE Trigger_test(
  message VARCHAR(100)
);


-- ALL THIS IS DONE ON MY SQL COMMAND LINE
-- TRIGGER 1
DELIMITER $$
CREATE 
  TRIGGER my_trigger_1 BEFORE INSERT 
  ON employee
  FOR EACH ROW BEGIN 
    INSERT INTO trigger_test VALUES ('Added New Employee');
  END$$
DELIMITER ;


-- TRIGGER 2
DELIMITER $$
CREATE 
  TRIGGER my_trigger_2 BEFORE INSERT 
  ON employee
  FOR EACH ROW BEGIN 
    INSERT INTO trigger_test VALUES (NEW.First_name);
  END$$
DELIMITER ;


-- TRIGGER 3
DELIMITER $$
CREATE 
  TRIGGER my_trigger_3 BEFORE INSERT 
  ON employee
  FOR EACH ROW BEGIN 
    IF NEW.sex = 'M' THEN
        INSERT INTO trigger_test VALUES ('Added Male Employee');
    ELSEIF NEW.sex = 'F' THEN
        INSERT INTO trigger_test VALUES ('Added Female Employee');
    ELSE
      INSERT INTO trigger_test VALUES ('Added Other Employee');
    END IF;
  END$$
DELIMITER ;

-- TO DROP THE TRIGGER
DROP TRIGGER my_trigger;


INSERT INTO employee
VALUES(112,'QUEEN','BASIN','1988-02-19','F', 69000, 106, 3);

SELECT * FROM trigger_test;


















































