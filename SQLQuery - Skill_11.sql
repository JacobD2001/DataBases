--11.01
--a)
SELECT 34+NULL -- NULL + COS = NULL
--b)
SELECT * FROM employees WHERE PESEL IS NULL OR employment_date IS NULL;
--c)
SELECT * FROM students_modules;
--d)
SELECT DATEDIFF(DAY, planned_exam_date, GETDATE()) AS NumberOfDayes, student_id
FROM students_modules
ORDER BY planned_exam_date DESC
--e)
SELECT COUNT(planned_exam_date)
FROM students_modules --funkcja COUNT pomija nulle
--f)
SELECT COUNT(*)
FROM students_modules -- COUNT(*) nie pomiija nulli, "preserves duplicate rows."
--11.02
--a)
SELECT DISTINCT student_id, exam_date
FROM student_grades
ORDER BY exam_date DESC --DISTINCT - returns only distinct(different) values
--b)
SELECT DISTINCT student_id
FROM student_grades
WHERE exam_date LIKE '2018-03-%'
ORDER BY student_id DESC
--11.03
SELECT student_id, surname AS family_name
FROM students
WHERE surname ='Fisher' -- kolejnosc zapytania from -> where, alias nie istnieje
--11.04
--SARG 
SELECT module_name, lecturer_id
FROM modules
WHERE lecturer_id = 8 OR lecturer_id IS NULL
--COALESCE
SELECT module_name, lecturer_id
FROM modules
WHERE lecturer_id = 8 OR COALESCE(lecturer_id, 0) = 0

--11.05
SELECT CAST('ABC' AS INT) -- varchar -> int not possible
SELECT TRY_CAST('ABC' AS INT) -- https://stackoverflow.com/questions/37478423/cast-convert-empty-string-to-int-in-sql-server
--11.06
SELECT CONVERT(char(10),GETDATE(),101)
SELECT CONVERT(char(10),GETDATE(),102)
SELECT CONVERT(char(10),GETDATE(),103) -- 101,102,103,(...) are styles of displayed data
--11.07
--a)
SELECT * FROM groups
WHERE group_no LIKE 'DM%'
--b)
SELECT * FROM groups
WHERE group_no NOT LIKE '%10%'
--c)
SELECT * FROM groups
WHERE group_no LIKE '_M%'
--d)
SELECT * FROM groups
WHERE group_no LIKE '%0_'
--e)
SELECT * FROM groups
WHERE group_no LIKE '%1' OR group_no LIKE '%2'
--f)
SELECT * FROM groups
WHERE group_no NOT LIKE 'D%'
--g)
SELECT * FROM groups
WHERE group_no LIKE '_[A-P]%'
--11.08
SELECT * FROM modules
--a)
SELECT module_name
FROM modules
WHERE module_name LIKE '%O%'
--b)
SELECT module_name
FROM modules
WHERE module_name COLLATE polish_CS_as LIKE '%O%'
--c)
SELECT group_no
FROM groups
WHERE group_no LIKE '__i%'
--d)
SELECT *
FROM groups
WHERE group_no COLLATE polish_CS_as LIKE '__i%'
--11.09
CREATE TABLE #tmp
(
id INT PRIMARY KEY,
nazwisko VARCHAR(30) COLLATE POLISH_CS_AS
);

INSERT INTO #tmp VALUES(1,'Kowalski');
INSERT INTO #tmp VALUES(2,'kowalski');
INSERT INTO #tmp VALUES(3,'KoWaLsKi');
INSERT INTO #tmp VALUES(4,'KOWALSKI');
--a)
SELECT nazwisko
FROM #tmp
WHERE nazwisko LIKE 'K%'

SELECT nazwisko
FROM #tmp
WHERE nazwisko LIKE 'Kowalski'

SELECT nazwisko
FROM #tmp
WHERE nazwisko LIKE '%K_'
--b)
-- b)
SELECT * FROM #tmp
WHERE nazwisko ='kowalski'

SELECT * FROM #tmp
WHERE nazwisko LIKE '_o%'

-- u¿ycie COLLATE nie by³o konieczne w ¿adnym przypadku, poniewa¿ zastosowaliœmy je przy tworzeniu tabeli co wp³yne³o na ostateczny wynik wyszukiwania w przyk³adzie b)
--11.10
SELECT surname
FROM students
ORDER BY group_no -- it is becouse of the order of the query  https://stackoverflow.com/questions/5391564/how-to-use-distinct-and-order-by-in-same-select-statement
--11.11
--a)
SELECT TOP 5 exam_date
FROM student_grades
ORDER BY exam_date ASC
--b)
SELECT TOP 5 WITH TIES exam_date 
FROM student_grades
ORDER BY exam_date ASC
--with ties czyli z remisami czyli te same wyniki tak samo stare pojawi¹ siê
--11.12
--a)
SELECT * FROM student_grades
--b)
SELECT TOP 20 PERCENT student_id,module_id,exam_date,grade
FROM student_grades
ORDER BY exam_date --zaokr¹gla rekordy, nie zwróci 0,6 rekordu
--c)
SELECT student_id,module_id, exam_date, grade
FROM student_grades
ORDER BY exam_date
OFFSET 6 ROWS FETCH NEXT 10 ROWS ONLY
--d)
SELECT *
FROM student_grades
ORDER BY exam_date
OFFSET 20 ROWS
--11.13
--a)
SELECT surname FROM students
UNION
SELECT surname FROM employees -- pomija duplikaty 
--b)
SELECT surname FROM students
UNION ALL
SELECT surname FROM employees --nie pomija duplikatów
--c)
SELECT surname FROM students
EXCEPT
SELECT surname FROM employees
--d)
SELECT surname FROM students
INTERSECT
SELECT surname FROM employees
--e)
SELECT department FROM departments
EXCEPT 
SELECT department FROM lecturers
--f)
SELECT module_id FROM modules
EXCEPT 
SELECT preceding_module FROM modules
--g)
SELECT student_id, module_id FROM students_modules
EXCEPT
SELECT student_id, module_id FROM student_grades
--h)
SELECT student_id FROM students_modules
WHERE module_id = 3
INTERSECT
SELECT student_id FROM students_modules
WHERE module_id = 12
--i)
SELECT surname, first_name, group_no AS group_departmet
FROM students
WHERE group_no LIKE 'DMIe%' 
UNION
SELECT employees.first_name, employees.surname, lecturers.department
FROM employees, lecturers
WHERE lecturers.lecturer_id = employees.employee_id
ORDER BY students.group_no






