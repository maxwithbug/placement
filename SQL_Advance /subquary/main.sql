
-- maksing the tables for students, exam_scores, and projects.
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    branch VARCHAR(50) NOT NULL
);

CREATE TABLE exam_scores(
    score_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    subject VARCHAR(50) NOT NULL,
    score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    exam_month VARCHAR(20) NOT NULL
);

CREATE TABLE projects(
    project_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    title VARCHAR(100) NOT NULL,
    marks INT NOT NULL CHECK (marks BETWEEN 0 AND 100)
);


-- now inserting some data to tables 
INSERT INTO students (name, branch) VALUES
('Alice', 'cs'),
('Bob', 'EE'),
('Charlie', 'ME'),
('David', 'CE'),
('Eve', 'IT');

INSERT INTO exam_scores (student_id, subject, score, exam_month) VALUES
-- Alice
(1, 'Mathematics', 85, 'January'),
(1, 'Physics', 78, 'January'),
(1, 'Chemistry', 92, 'January'),
-- Bob
(2, 'Mathematics', 70, 'January'),
(2, 'Physics', 90, 'January'),
(2, 'Chemistry', 65, 'January'),
-- Charlie
(3, 'Mathematics', 60, 'January'),
(3, 'Physics', 75, 'January'),
(3, 'Chemistry', 78, 'January'),
-- David
(4, 'Mathematics', 88, 'January'),
(4, 'Physics', 82, 'January'),
(4, 'Chemistry', 91, 'January'),
-- Eve
(5, 'Mathematics', 95, 'January'),
(5, 'Physics', 89, 'January'),
(5, 'Chemistry', 93, 'January');

INSERT INTO projects (student_id, title, marks) VALUES
-- Alice
(1, 'Database Design', 85),
(1, 'Web Development', 90),
(1, 'Machine Learning Basics', 88),
-- Bob
(2, 'Circuit Analysis', 90),
(2, 'Power Systems', 75),
(2, 'Embedded Systems', 82),
-- Charlie
(3, 'Thermodynamics', 78),
(3, 'Fluid Mechanics', 84),
(3, 'Heat Transfer', 91),
-- David
(4, 'Structural Analysis', 88),
(4, 'Concrete Design', 79),
(4, 'Surveying', 95),
-- Eve
(5, 'Software Engineering', 95),
(5, 'Cloud Computing', 89),
(5, 'Cybersecurity Basics', 93);





-- now the main part subquary is used to get the average score of each student in the exam_scores table and the average marks of each student in the projects table. The final result will show the student's name, branch, average exam score, and average project marks.
-- 1.which student has the highest average score in the exam_scores table?
-- find avove avg

SELECT AVG(score) as class_avarage FROM exam_scores; --82....Avg score

--joining the tables to get the student name, branch, and exam score for students who scored above the average score in the exam_scores table.
SELECT 
    s.name as student_name,
    s.branch as student_branch,
    e.score --we must need an int so we don't need 'as score' here

FROM exam_scores as e
INNER JOIN students as s ON e.student_id = s.student_id


WHERE e.score > (
    SELECT AVG(score) as class_avarage  --we can't write more than one quary here .......  column in the subquery because it will return more than one value and we can't compare a single value with multiple values. So we need to use only one column in the subquery.
    FROM exam_scores
    ); --comparing the score with the average score of all students in the exam_scores table.    



--criteria for placement
--1. at least 1 exam attempt have > 90 score
--AND 2, any of there projects should have marks > 85

SELECT * FROM exam_scores where score > 90; --1,2,5
SELECT * FROM projects where marks > 85; --1,2,3,4,
--so the final result will be 1,2,5

-- no semicolon after the subquery in the WHERE clause, because it is not the end of the statement. The semicolon is used to terminate a SQL statement, and in this case, the subquery is part of the main query, so it should not be terminated with a semicolon.
SELECT 
    s.student_id,
    s.name as student_name,
    s.branch as student_branch
FROM students as s
-- WHERE s.student_id IN(1,2,3)
WHERE  s.student_id IN (SELECT student_id FROM exam_scores WHERE score >= 90)
AND s.student_id IN (SELECT student_id FROM projects WHERE marks >= 85);


-- requirments for placement:
-- 1. we need to have total score student has erned and no of exams students has attempted and the average score of the student in the exam_scores table.

-- TOTAL SCORE
SELECT student_id , SUM(score) as total_score FROM exam_scores ;

--this is normal
SELECT 
    s.student_id,
    s.name as student_name,
    s.branch as student_branch,
    SUM(e.score) as total_score,
    COUNT(e.score) as total_exams_attempted,
    AVG(e.score) as average_score
FROM students as s
INNER JOIN exam_scores as e ON s.student_id = e.student_id
GROUP BY s.student_id, s.name, s.branch
ORDER BY average_score DESC; --sorting the result in descending order based on the average score of

--it's simple version 
SELECT
    student_id,
    SUM(score) as total_score,
    COUNT(*) as total_exams_attempted
FROM exam_scores
GROUP BY student_id


--with subquery
SELECT *
    s.name as student_name,
    s.branch as student_branch,
    total_states.total_score,
    total_states.total_exams_attempted
FROM( --we can use this as a temp table with out creating a new table parmanently this is subquary super power 
    SELECT
    student_id,
    SUM(score) as total_score,
    COUNT(*) as total_exams_attempted
    FROM exam_scores
    GROUP BY student_id
) as total_states
INNER JOIN students as s ON total_states.student_id = s.student_id
ORDER BY total_score DESC;



-- --requirements for placement:
-- 1. for each peoject get student's name , branch ,projects marks ,
-- 2. and treir avarage exam score on the same row 


--first find the avg
SELECT student_id,
    AVG(score) as average_score
 FROM exam_scores GROUP BY student_id; --1,2,3,4,5 

 --now the details of projects with inner subquery to get the average score of each student in the exam_scores table and join it with the projects table to get the project details along with the student's name and branch.
SELECT 
    s.name as student_name,
    s.branch as student_branch,
    p.title as project_title,
    p.marks as project_marks,
    avg_scores.average_score

FROM projects as p
INNER JOIN students as s ON p.student_id = s.student_id
INNER JOIN (
    SELECT student_id, AVG(score) as average_score
    FROM exam_scores
    GROUP BY student_id
) as avg_scores ON s.student_id = avg_scores.student_id



-- now use subquary to add data to another table with the help of subquary
-- requiments:
-- 1.there is a need of report where we have list of exam attempts
-- 2.which are above the average score of the class (score >avg class score )
-- 3. also include name of the student in the report 

CREATE TABLE high_scores_report(
    report_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    student_name VARCHAR(50) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    achive_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO high_scores_report (student_id, student_name, subject, score)
SELECT
    s.student_id,
    s.name as student_name,
    e.subject,
    e.score
FROM exam_scores as e
INNER JOIN students as s ON e.student_id = s.student_id
WHERE e.score > (
    SELECT AVG(score) as class_avarage
    FROM exam_scores
);

SELECT * FROM high_scores_report; --to check the data in the report table



