-- https://gist.github.com/jgn/4543298
-- 
drop table if exists student;
create table student (
  sno integer,
	sname varchar(10),
	age integer
);

drop table if exists courses;
create table courses (
	cno varchar(5),
	title varchar(10),
	credits integer
);

drop table if exists professor;
create table professor (
	lname varchar(10),
	debt varchar(10),
	salary integer,
	age integer
);

drop table if exists take;
create table take (
	sno integer,
	cno varchar(5)
);

drop table if exists teach;
create table teach (
	lname varchar(10),
	cno varchar(5)
);

insert into student values (1, 'AARON', 20);
insert into student values (2, 'CHUCK', 21);
insert into student values (3, 'DOUG', 20);
insert into student values (4, 'MAGGIE', 19);
insert into student values (5, 'STEVE', 22);
insert into student values (6, 'JING', 18);
insert into student values (7, 'BRIAN', 21);
insert into student values (8, 'KAY', 20);
insert into student values (9, 'GILLIAN', 20);
insert into student values (10, 'CHAD', 21);

insert into courses values ('CS112', 'PHYSICS', 4);
insert into courses values ('CS113', 'CALCULUS', 4);
insert into courses values ('CS114', 'HISTORY', 4);

insert into professor values ('CHOI', 'SCIENCE', 400, 45);
insert into professor values ('GUNN', 'HISTORY', 300, 60);
insert into professor values ('MAYER', 'MATH', 400, 55);
insert into professor values ('POMEL', 'SCIENCE', 500, 65);
insert into professor values ('FEUER', 'MATH', 400, 40);

insert into take values (1, 'CS112');
insert into take values (1, 'CS113');
insert into take values (1, 'CS114');
insert into take values (2, 'CS112');
insert into take values (3, 'CS112');
insert into take values (3, 'CS114');
insert into take values (4, 'CS112');
insert into take values (4, 'CS113');
insert into take values (5, 'CS113');
insert into take values (6, 'CS113');
insert into take values (6, 'CS114');

insert into teach values ('CHOI', 'CS112');
insert into teach values ('CHOI', 'CS112');
insert into teach values ('CHOI', 'CS112');
insert into teach values ('POMEL', 'CS113');
insert into teach values ('MAYER', 'CS112');
insert into teach values ('MAYER', 'CS114');

-- pp. 557-559: Negation: "Students who do not take CS112"
select *
  from student
 where sno not in (select sno
                    from take
                  where cno = 'CS112');

-- pp. 566-567: "At most": "Find the students who take at most two courses; students who do not take any courses should be excluded."
select distinct s.*
  from student s, take t
 where s.sno = t.sno
   and s.sno not in ( select t1.sno
                       from take t1, take t2, take t3
                      where t1.sno = t2.sno
                        and t2.sno = t3.sno
                        and t1.cno < t2.cno and
                        t2.cno < t3.cno );