create database win_fun;
 use win_fun;
 
 create table cd(
 student_id int,
 student_batch varchar(60),
 student_name varchar(60),
 student_stream varchar(60),
 student_marks int,
 student_mail_id varchar(50));
 
 alter table cd change column student_markds student_marks int;
 
 select * from cd;
 SET SQL_SAFE_UPDATES = 0;
DELETE FROM cd WHERE student_id = 123;
SET SQL_SAFE_UPDATES = 1;
 delete from cd where student_id = 101;
 
insert into cd values(101,"fsda","saurabh","cs",80,"s.r@gmail.com"),
  (102,"fsds","navin","cs",80,"na.r@gmail.com"),
  (103,"fsda","nikita","ME",80,"sni@gmail.com"),
  (104,"fsda","shudha","ME",89,"shu@gmail.com"),
  (105,"fsds","kamal","ME",82,"kam@gmail.com"),
  (106,"fsds","karna","ME",76,"kar@gmail.com"),
  (107,"fsds","mayank","CI",66,"may@gmail.com"),
  (108,"fsde","nibha","CI",73,"nib@gmail.com"),
  (109,"fsde","shyam","CI",46,"shy@gmail.com"),
  (110,"fsde","sikha","CI",55,"sik@gmail.com"),
  (111,"fsde","sita","CI",81,"sit@gmail.com"),
  (112,"fsds","kanchan","EE",67,"kan@gmail.com"),
  (113,"fsda","kamala","EE",54,"kam@gmail.com"),
  (114,"fsde","naman","EE",77,"nam@gmail.com"),
  (115,"fsds","moni","ECE",71,"mon@gmail.com"),
  (116,"fsde","manish","ECE",68,"man@gmail.com"),
  (117,"fsds","rajan","ECE",91,"ran@gmail.com"),
  (118,"fsds","rama","ECE",96,"sram@gmail.com"),
  (119,"fsda","bharti","cs",96,"bhar@gmail.com"),
(120,"fsds","ramaya","ME",67,"radha@gmail.com"),
(121,"fsdc","mohit","cs",77,"moti@gmail.com"),
(122,"fsdc","rajesh","cs",82,"rej@gmail.com"),
(123,"fsda","radha","cs",82,"kr@gmail.com");


  # Aggregate window functions.
  #problems + solutions.
  # show all data
  select * from cd;
  
  # To select all students from a students table who are in the Computer Science (CS) department,
  select * from cd where student_stream = "cs"; 
  
  # show the total marks of all student batch wise. #
  select student_batch, sum(student_marks) 
  from cd
  group by student_batch;
  
  # show the Min marks of all student batch wise.
  select student_batch, min(student_marks) 
  from cd
  group by student_batch;
  
  # show the Max marks of all student batch wise.
  select student_batch, max(student_marks) 
  from cd
  group by student_batch;
  
  # show the Avrage marks of all student batch wise.
  select student_batch, avg(student_marks) 
  from cd
  group by student_batch;
  
  #count of dataset of the batches.
  select count(student_batch) from cd;
  
  #show the distinct batchs in this table.
  select count(distinct(student_batch)) from cd;
  
  #show the total batch name.
  select distinct(student_batch) from cd;
  
  #show the number of students batch wise.
  select student_batch, count(student_batch) from cd
  group by student_batch;
  
  
  #Analytical Window Functions.
  #problems + solutions.
  #Who has received the higest marks in fsda batch.
  select student_name, student_marks from cd where student_marks in(
  select max(student_marks) from cd where student_batch = "fsda");
  
  #Who has received the 2nd highest marks in fsda batch.
  select * from cd where student_batch = "fsda"
  order by  student_marks desc
  limit 1,1;
  
  #Who has received the 3rd highest marks in fsde batch.
  select * from cd where student_batch = "fsde"
  order by student_marks desc
  limit 3,1;
  
 #Use of row number().
 select student_id, student_batch, student_stream, student_marks,
 row_number() over(order by student_marks) as 'row_number' from cd;
 
 #use od partition by.
  select student_id, student_batch, student_stream, student_marks,
 row_number() over(partition by student_stream order by student_marks) as 'row_number' from cd; 
 
 #Use of rank().
 #Looking for of topper from every batch.
 select* from(select student_id, student_batch, student_stream, student_marks,
 rank() over(partition by student_batch order by student_marks desc) as 'row_rank' 
 from cd) as test where row_rank = 1;
  
#Identify the student who has achieved rank 1 in the entire batch.
select* from(select student_id, student_batch, student_stream, student_marks,
rank() over( order by student_marks desc) as 'row_rank' 
from cd) as test where row_rank = 1;

#Organize the data rank marks wise.
select student_id, student_batch, student_stream, student_marks,
rank() over(order by student_marks desc)as 'row_rank' from cd;  

#show the data rank batch wise.
select student_id, student_batch, student_stream, student_marks,
row_number() over(partition by student_batch order by student_marks desc) as 'row_number',
rank() over(partition by student_batch order by student_marks desc) as 'rank_number' from cd;

#show the topper from every batch.
select * from (select student_id, student_batch, student_stream, student_marks,
row_number() over(partition by student_batch order by student_marks desc) as 'row_num',
rank() over(partition by student_batch order by student_marks desc) as 'row_rank' from cd) as test
where row_rank = 1;
 
#Difference between row_number() & rank() & dense_rank.  
select student_id, student_batch, student_stream, student_marks,
row_number() over(order by student_marks desc) as 'row_number',
rank() over(order by student_marks desc) as 'rank_number',
dense_rank() over(order by student_marks desc) as 'dense_rank'
from cd;

#show the topper from every batch.
select * from (select * ,
rank() over( partition by student_batch order by student_marks desc) as first_topper
from cd ) as test
where first_topper = 1;

#show the 2nd higest marks for every batch.
select * from (select * , dense_rank() over(partition by student_batch order by student_marks desc) as 'dense_rank'
from cd ) as test
where 'dense_rank' = 2;

#All students who are ranked 3rd in their respective batches based on their marks.
select * from (select student_id, student_batch, student_stream, student_marks,
dense_rank() over(partition by student_batch order by student_marks desc) as dense
 from cd) as test
where dense = 3;


