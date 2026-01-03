# Beginner SQL Examples Project

## Overview
This project contains beginner-level SQL queries written and executed using
**Beekeeper Studio** as part of my SQL learning journey.

The queries were practiced using the **FreeCodeCamp example database** to
demonstrate foundational SQL concepts commonly required for data analyst roles.

---

## What This Project Shows
This project focuses on understanding and practicing core SQL skills, including:
- Writing basic SELECT queries
- Filtering data with WHERE
- Sorting results using ORDER BY
- Using aggregate functions like COUNT and AVG
- Grouping data with GROUP BY
- Working with DISTINCT values

---

## Tools Used
- SQL Client: Beekeeper Studio
- Database: FreeCodeCamp Example Database
- Language: SQL
- Version Control: GitHub

---

## Project File
- `beginner_SQL_examples.sql`  
  This file contains multiple SQL queries with comments explaining what each query does.

---

## Example Query
```sql
SELECT major, COUNT(*) AS total_students
FROM student
GROUP BY major;
