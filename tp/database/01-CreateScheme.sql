-- drop des tables si jamais un volume est présent
DROP TABLE IF EXISTS public.departments;
DROP TABLE IF EXISTS public.students;
-- création des tables (qui seront dans le schema public)
CREATE TABLE public.departments
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);
CREATE TABLE public.students
(
    id SERIAL PRIMARY KEY,
    department_id INT NOT NULL REFERENCES departments (id),
    first_name VARCHAR(20)  NOT NULL,
    last_name VARCHAR(20) NOT NULL
);
