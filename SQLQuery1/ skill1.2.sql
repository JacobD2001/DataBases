--12.01
SELECT m.module_id, module_name 
FROM modules m LEFT JOIN students_modules sm ON m.module_id = sm.module_id
WHERE student_id IS NULL
ORDER BY module_name DESC
--12.02
SELECT * --m.module_id, module_name, surname
FROM modules m LEFT JOIN students_modules sm ON m.module_id = sm.module_id
LEFT JOIN employees e on m.lecturer_id = e.employee_id
WHERE student_id IS NULL
ORDER BY module_name DESC
--12.03 1.jakie tabele potrzebujemy? 2.How to fetch data what construct to use, go through relations
SELECT *
FROM employees e INNER JOIN lecturers l ON e.employee_id = lecturer_id
LEFT JOIN modules m ON l.lecturer_id = m.lecturer_id
ORDER BY surname ASC
--12.04
SELECT employee_id, surname, first_name
FROM employees e INNER JOIN lecturers l ON e.employee_id = l.lecturer_id
--12.05
SELECT employee_id, surname, first_name
FROM employees e LEFT JOIN lecturers l ON e.employee_id = l.lecturer_id
WHERE lecturer_id IS NULL
--12.06
SELECT s.student_id, first_name, surname, group_no
FROM students s LEFT JOIN students_modules sm ON s.student_id = sm.student_id
WHERE module_id is null
ORDER BY surname, first_name ASC 
--12.07
SELECT DISTINCT s.student_id, first_name, surname, group_no, exam_date
FROM students s INNER JOIN student_grades sg ON s.student_id = sg.student_id
ORDER BY exam_date ASC
