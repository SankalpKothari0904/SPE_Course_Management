drop database if exists elective_management;
create database elective_management;
use elective_management;

create table user(
    user_id INTEGER PRIMARY KEY auto_increment,
    username varchar(100) UNIQUE NOT NULL,
    password char(68) NOT NULL
);
CREATE TABLE role (
    role_id INTEGER NOT NULL auto_increment,
    role_name varchar(100) NOT NULL,
    constraint pk_role PRIMARY KEY (role_id)
);
CREATE TABLE user_roles (
    user_id INTEGER auto_increment,
    role_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE student(
    student_id INTEGER auto_increment,
    user_id INTEGER UNIQUE NOT NULL,
    student_name varchar(100) DEFAULT NULL,
    student_email varchar(100) DEFAULT NULL,
    student_phno varchar(100) DEFAULT NULL,
    constraint pk_student PRIMARY KEY (student_id)
);

CREATE TABLE instructor(
    instructor_code INTEGER auto_increment,
    user_id INTEGER UNIQUE NOT NULL,
    instructor_name varchar(100) DEFAULT NULL,
    instructor_email varchar(100) DEFAULT NULL,
    instructor_phno varchar(100) DEFAULT NULL,
    constraint pk_instructor PRIMARY KEY (instructor_code)
);
CREATE TABLE subjects(
    subject_code INTEGER auto_increment,
    instructor_code INTEGER,
    subject_name varchar(50) DEFAULT NULL,
    subject_desc varchar(500) DEFAULT NULL,
    constraint pk_subject PRIMARY KEY (subject_code)
);
CREATE TABLE request(
    slno INTEGER auto_increment,
    student_id INTEGER,
    subject_code INTEGER,
    start_date timestamp NOT NULL DEFAULT current_timestamp(),
    end_date timestamp DEFAULT NULL,
    constraint pk_request PRIMARY KEY (slno)
);
CREATE TABLE student_subject(
    slno INTEGER auto_increment,
    student_id INTEGER,
    subject_code INTEGER,
    start_date timestamp NOT NULL DEFAULT current_timestamp(),
    end_date timestamp DEFAULT NULL,
    constraint pk_cust_cab PRIMARY KEY (slno)
);
ALTER TABLE user_roles
ADD CONSTRAINT fk_user_userRoles
FOREIGN KEY (user_id) REFERENCES user(user_id) on delete cascade;

ALTER TABLE subjects
ADD CONSTRAINT fk_sub_instructor
FOREIGN KEY (instructor_code) REFERENCES instructor(instructor_code) on delete set null;

ALTER TABLE user_roles
ADD CONSTRAINT fk_role_userRoles
FOREIGN KEY (role_id) REFERENCES role(role_id) on delete cascade;

ALTER TABLE student
ADD CONSTRAINT fk_student_user
FOREIGN KEY (user_id) REFERENCES user(user_id) on delete cascade;

ALTER TABLE instructor
ADD CONSTRAINT fk_instructor_user
FOREIGN KEY (user_id) REFERENCES user(user_id) on delete cascade;

ALTER TABLE request
ADD CONSTRAINT fk_stud_request
FOREIGN KEY (student_id) REFERENCES student(student_id) on delete cascade;

ALTER TABLE request
ADD CONSTRAINT fk_subject_request
FOREIGN KEY (subject_code) REFERENCES subjects(subject_code) on delete cascade;

ALTER TABLE student_subject
ADD CONSTRAINT fk_sub_stud_id
FOREIGN KEY (student_id) REFERENCES student(student_id) on delete cascade;

ALTER TABLE student_subject
ADD CONSTRAINT fk_sub_stud_subcode
FOREIGN KEY (subject_code) REFERENCES subjects(subject_code) on delete cascade;

INSERT INTO role values (1,'ADMIN'),(2,'INSTRUCTOR'),(3,'STUDENT');
INSERT INTO user values (1,"admin","$2a$09$vnS0G1MqX2hQEvk2v6O1L.A7x7zZfMnm55fwL26G4sX/ypjMk7W4O");
-- test123
INSERT INTO user values (2,"instructor","$2a$09$vnS0G1MqX2hQEvk2v6O1L.A7x7zZfMnm55fwL26G4sX/ypjMk7W4O");
INSERT INTO user values (3,"student","$2a$09$vnS0G1MqX2hQEvk2v6O1L.A7x7zZfMnm55fwL26G4sX/ypjMk7W4O");
INSERT INTO student values (1, 3, "student", "student@gmail.com", "7164518742");
INSERT INTO instructor values (1, 2, "instructor", "instructor@gmail.com", "8156154623");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 1 FROM user WHERE user.username = "admin";
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "instructor";
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "student";

INSERT INTO user values (4,"bmahesh","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (2,4,"Mahesh B","mahesh@test.com","7848578485");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "bmahesh";

INSERT INTO user values (5,"sankalpk","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (2,5,"Sankalp Kothari","sankalpkothari04@gmail.com","8888777788");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "sankalpk";

INSERT INTO user values (6,"sidk","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (3,6,"Siddharth Kothari","siddharthvatps@gmail.com","8877777788");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "sidk";

INSERT INTO user values (7,"msrini","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (4,7,"M Srinivasan","sankalpkothari04@gmail.com","8888777788");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "msrini";

INSERT INTO user values (8,"alexdarcy","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (5,8,"Alexandra Darcy","alex.darcy@test.com","1234567890");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "alexdarcy";

INSERT INTO user values (9,"jakeper","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (6,9,"Jake Peralta","jperalta@test.com","9638527410");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "jakeper";

INSERT INTO user values (10,"rosadiaz","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (7,10,"Rosa Diaz","diaz.rosa@test.com","9856321407");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "rosadiaz";

INSERT INTO user values (11,"jeffords","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (3,11,"Terry Jeffords","terry@test.com","9546781203");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "jeffords";

INSERT INTO user values (12,"phildunphy","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (4,12,"Philip Dunphy","dunphy@test.com","5124630789");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "phildunphy";

INSERT INTO user values (13,"eltonjoni","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (8,13,"Joni Elton","joni.elton@test.com","9955113322");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "jonielton";

INSERT INTO user values (14,"pettigrew","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (9,14,"Patty Pettigrew","thesuperiorpettigrew@test.com","8456789456");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "pettigrew";

INSERT INTO user values (15,"hhjort","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (5,15,"Hjalmar Hjort","hhjort@test.com","1100110100");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "hhjort";

INSERT INTO user values (16,"mikeclark","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (10,16,"Micheal Clark","micky@test.com","5464566544");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "mikeclark";

INSERT INTO user values (17,"johndoe","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (6,17,"John Doe","johndoe@test.com","7894561238");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "johndoe";

INSERT INTO user values (18,"chad","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (7,18,"Chad Darby","gigachad@test.com","7979797946");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "chad";

INSERT INTO user values (19,"jtaylor","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (11,19,"Jerome Taylor","@test.com","3322332232");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "jtaylor";

INSERT INTO user values (20,"pickie","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (12,20,"Jordan Pickford","jpicks@test.com","1885522852");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "pickie";

INSERT INTO user values (21,"jp","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (13,21,"Jay Pritchett","jpcnc@test.com","9966334411");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "jp";

INSERT INTO user values (22,"freddie","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (14,22,"Frederick Lemar","flemar@test.com","8546854685");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "freddie";

INSERT INTO user values (23,"sonny","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (15,23,"Son Heung-Min","hmson@test.com","1234567880");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "sonny";

INSERT INTO user values (24,"niclehr","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (16,24,"Nicole Lehr","niclehr@test.com","7744558878");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "niclehr";

INSERT INTO user values (25,"sushill","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (8,25,"Susan Hill","sushill@test.com","2234667890");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "sushill";

INSERT INTO user values (26,"jimmyanderson","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (17,26,"James Anderson","jimmyand@test.com","8021212121");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "jimmyanderson";

INSERT INTO user values (27,"marshmellow","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (18,27,"Marshall Eriksen","eriksenmarshall147@test.com","6523652365");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "marshmellow";

INSERT INTO user values (28,"bstinson","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (19,28,"Barney Stinson","suitup@test.com","9469469469");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "bstinson";

INSERT INTO user values (29,"admin1","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 1 FROM user WHERE user.username = "admin1";

INSERT INTO user values (30,"mmorales","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (20,30,"Miles Morales","moreorless@test.com","5423654654");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "mmorales";

INSERT INTO user values (31,"raphaguerreiro","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (9,31,"Raphael Guerreiro","raphaguerreiro@test.com","8456984567");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "raphaguerreiro";

INSERT INTO user values (32,"davidmoses","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO instructor values (10,32,"David James Moses","djmoses@test.com","2200220022");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 2 FROM user WHERE user.username = "davidmoses";

INSERT INTO user values (33,"wardmcleod","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (21,33,"Ward McLeod","wardmcleod@test.com","8546802131");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "wardmcleod";

INSERT INTO user values (34,"blively","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (22,34,"Blake Lively","blively@test.com","1234533330");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "blively";

INSERT INTO user values (35,"phillipslaura","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (23,35,"Laura Phillips","plaura@test.com","1234567440");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "phillipslaura";

INSERT INTO user values (36,"kbaum","$2a$12$Yi8Rj1sWIikVcck1XHSKG.904xad0EkhglIk6gXCSAAtOEHzTYucu");
INSERT INTO student values (24,36,"Kristoph Baumgartner","kbaum@test.com","1237897890");
INSERT INTO user_roles (user_id, role_id) SELECT user.user_id, 3 FROM user WHERE user.username = "kbaum";

INSERT INTO subjects values (1, NULL, "DSA", "Data Structures and Algorithms");
INSERT INTO subjects values (2, 7, "Web Dev", "Web Development in React and Spring Boot");
INSERT INTO subjects values (3, 6, "DBMS", "Database Management Systems and their applications");
INSERT INTO subjects values (4, NULL, "Let us C", "An introductory course in C programming");
INSERT INTO subjects values (5, 2, "Probability", "Bayes Theorem, Conditional Probability");
INSERT INTO subjects values (6, 3, "App Dev", "App development using React Native");
INSERT INTO subjects values (7, 4, "Economics", "Micro and Macro Economics - an overview");
INSERT INTO subjects values (8, 1, "Machine Learning", "Intro to the idea of Supervised and Unsupervised ML algorithms");
INSERT INTO subjects values (9, 1, "Math for ML", "Mathematics that goes into designing ML algorithms");
INSERT INTO subjects values (10, 10, "Spoken English", "Helps develop fluency in the English language, through various tasks and activities");

INSERT INTO request values (1, 1, 2, "2023-07-26 00:00:00", "2023-08-20 00:00:00");
INSERT INTO request values (2, 1, 8, "2023-08-20 00:00:00", "2023-11-20 00:00:00");
INSERT INTO request values (3, 1, 9, "2023-08-20 00:00:00", "2023-11-20 00:00:00");
INSERT INTO request values (4, 2, 8, "2023-07-26 00:00:00", "2023-10-27 00:00:00");
INSERT INTO request values (5, 2, 9, "2023-07-19 00:00:00", "2023-12-18 00:00:00");
INSERT INTO request values (6, 3, 4, "2023-08-20 00:00:00", "2023-11-20 00:00:00");
INSERT INTO request values (7, 3, 3, "2023-09-19 00:00:00", "2023-12-19 00:00:00");
INSERT INTO request values (8, 4, 9, "2023-08-26 00:00:00", "2024-01-26 00:00:00");
INSERT INTO request values (9, 20, 2, "2023-09-04 00:00:00", "2023-09-25 00:00:00");
INSERT INTO request values (10, 4, 1, "2023-10-07 00:00:00", "2023-02-06 00:00:00");
INSERT INTO request values (11, 16, 10, "2023-09-11 00:00:00", "2023-10-10 00:00:00");

INSERT INTO student_subject values (1, 2, 1, "2022-01-01 06:00:00", "2023-05-01 00:00:00");
INSERT INTO student_subject values (2, 1, 1, "2022-02-09 06:00:00", "2023-06-09 00:00:00");
INSERT INTO student_subject values (3, 2, 10, "2022-03-03 00:00:00", "2023-03-18 00:00:00");
INSERT INTO student_subject values (4, 3, 6, "2022-07-01 01:30:00", "2023-09-01 00:00:00");
INSERT INTO student_subject values (5, 6, 5, "2022-09-28 00:30:00", "2023-01-27 17:00:00");
INSERT INTO student_subject values (6, 4, 4, "2023-01-07 06:00:00", "2023-05-05 00:00:00");
INSERT INTO student_subject values (7, 5, 10, "2023-01-06 18:00:00", "2023-05-06 00:00:00");
INSERT INTO student_subject values (8, 8, 1, "2023-02-01 16:25:00", "2023-07-01 14:00:00");
INSERT INTO student_subject values (9, 19, 8, "2023-02-03 13:00:00", "2023-06-03 00:00:00");
INSERT INTO student_subject values (10, 24, 4, "2023-01-07 16:00:00", "2023-05-05 00:00:00");
INSERT INTO student_subject values (11, 16, 3, "2023-04-09 00:00:00", "2023-08-09 00:00:00");
INSERT INTO student_subject values (12, 8, 7, "2023-03-11 00:18:41", "2023-06-11 20:00:00");
INSERT INTO student_subject values (13, 13, 5, "2023-05-01 16:00:00", "2023-08-31 00:00:00");
