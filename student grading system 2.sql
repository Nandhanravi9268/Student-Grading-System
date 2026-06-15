-- ============================================================
--  STUDENT GRADING SYSTEM
-- ============================================================

CREATE DATABASE student_grading;
USE student_grading;

CREATE TABLE teachers (
    teacher_id  INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(120) NOT NULL,
    email       VARCHAR(180) UNIQUE NOT NULL,
    department  VARCHAR(100)
);

CREATE TABLE students (
    student_id      INT AUTO_INCREMENT PRIMARY KEY,
    student_number  VARCHAR(12)  UNIQUE NOT NULL,
    first_name      VARCHAR(80)  NOT NULL,
    last_name       VARCHAR(80)  NOT NULL,
    email           VARCHAR(180) UNIQUE NOT NULL,
    date_of_birth   DATE,
    enrollment_year YEAR         NOT NULL,
    status          ENUM('active','graduated','suspended') NOT NULL DEFAULT 'active'
);

CREATE TABLE courses (
    course_id    INT AUTO_INCREMENT PRIMARY KEY,
    course_code  VARCHAR(15)  UNIQUE NOT NULL,
    course_name  VARCHAR(200) NOT NULL,
    teacher_id   INT          NOT NULL,
    credits      TINYINT      NOT NULL DEFAULT 3,
    semester     VARCHAR(20)  NOT NULL,
    max_students SMALLINT     NOT NULL DEFAULT 30,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT  NOT NULL,
    course_id     INT  NOT NULL,
    enrolled_date DATE NOT NULL,
    status        ENUM('enrolled','dropped','completed') NOT NULL DEFAULT 'enrolled',
    UNIQUE KEY uq_student_course (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

CREATE TABLE grades (
    grade_id        INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id   INT          NOT NULL,
    assessment_type ENUM('quiz','midterm','final','project') NOT NULL,
    score           DECIMAL(5,2) NOT NULL,
    max_score       DECIMAL(5,2) NOT NULL DEFAULT 100.00,
    letter_grade    CHAR(2),
    graded_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- ============================================================
--  SAMPLE DATA
-- ============================================================

INSERT INTO teachers (full_name, email, department)
VALUES
('Mr. Rajesh Kumar',  'rajesh@school.com',  'Mathematics'),
('Mrs. Priya Nair',   'priya@school.com',   'Science'),
('Mr. Arun Selvam',   'arun@school.com',    'Computer Science');

INSERT INTO students (student_number, first_name, last_name, email, date_of_birth, enrollment_year, status)
VALUES
('STU001', 'Arjun',   'Kumar',  'arjun@student.com',  '2002-05-15', 2021, 'active'),
('STU002', 'Priya',   'Sharma', 'priya@student.com',  '2003-08-20', 2022, 'active'),
('STU003', 'Rahul',   'Verma',  'rahul@student.com',  '2001-12-10', 2020, 'graduated'),
('STU004', 'Sneha',   'Patel',  'sneha@student.com',  '2002-03-25', 2021, 'active'),
('STU005', 'Karthik', 'Raja',   'karthik@student.com','2003-07-14', 2022, 'active');

INSERT INTO courses (course_code, course_name, teacher_id, credits, semester, max_students)
VALUES
('MATH101', 'Mathematics I',       1, 4, 'Semester 1', 40),
('SCI101',  'Physics Basics',      2, 3, 'Semester 1', 35),
('CS101',   'Intro to Programming',3, 4, 'Semester 1', 30),
('MATH201', 'Mathematics II',      1, 4, 'Semester 2', 40),
('CS201',   'Data Structures',     3, 4, 'Semester 2', 30);

INSERT INTO enrollments (student_id, course_id, enrolled_date, status)
VALUES
(1, 1, '2024-01-10', 'enrolled'),
(1, 3, '2024-01-10', 'enrolled'),
(2, 1, '2024-01-10', 'enrolled'),
(2, 2, '2024-01-10', 'enrolled'),
(3, 3, '2024-01-10', 'completed'),
(4, 1, '2024-01-10', 'enrolled'),
(4, 3, '2024-01-10', 'enrolled'),
(5, 2, '2024-01-10', 'enrolled'),
(5, 3, '2024-01-10', 'enrolled');

INSERT INTO grades (enrollment_id, assessment_type, score, max_score, letter_grade)
VALUES
(1, 'quiz',    85.00, 100.00, 'A'),
(1, 'midterm', 78.00, 100.00, 'B'),
(1, 'final',   90.00, 100.00, 'A'),
(2, 'quiz',    92.00, 100.00, 'A'),
(2, 'midterm', 88.00, 100.00, 'A'),
(3, 'quiz',    70.00, 100.00, 'B'),
(3, 'midterm', 65.00, 100.00, 'C'),
(4, 'quiz',    95.00, 100.00, 'A'),
(4, 'final',   89.00, 100.00, 'A'),
(5, 'midterm', 72.00, 100.00, 'B'),
(5, 'final',   68.00, 100.00, 'C');

-- ============================================================
--  SELECT OUTPUT
-- ============================================================

SELECT * FROM teachers;
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;
SELECT * FROM grades;