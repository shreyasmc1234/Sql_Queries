select class from courses 
group by class having count(class)>=5;


select class from courses
group by class
having count(student)>=5;
