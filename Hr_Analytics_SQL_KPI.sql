
use project;

desc hr_1;
select * from hr_1;

desc hr_2;
select * from hr_2;

alter table hr_1 add  column Attrition_count int;
update hr_1 set Attrition_Count=1 where Attrition = "Yes";
update hr_1 set Attrition_Count=0 where Attrition = "No";

###########################################################################################################################################################################
/*
           Q.1. Average Attrition rate for all Departments
*/
select Department,round(avg(Attrition_Count),2)*100 as Avg_Attrition_Rate from hr_1 group by Department;

###########################################################################################################################################################################
/*
		Q.2. Average Hourly rate of Male Research Scientist
*/
select Department, round(avg( `Hourly  Rate`),2) as 'Avg Hourly Rate' from hr_1 where `Job  Role`="Research Scientist" and Gender = "Male"  group by Department ;

###########################################################################################################################################################################
/*
       Q.3. Attrition rate Vs Monthly income stats
*/
   select count(a.Attrition_count)as EMP_Left,  sum(b.`Monthly  Income`)as Monthly_Income,
   case
              when `Monthly  Income`>0 and `Monthly  Income`<=10000 then "0k - 10K"
              when `Monthly  Income`>10000 and `Monthly  Income`<=20000 then "10K - 20K"
		      when `Monthly  Income`>20000 and `Monthly  Income`<=30000 then "20k - 30K"
              when `Monthly  Income`>30000 and `Monthly  Income`<=40000 then "30K - 40K"
              when `Monthly  Income`>40000 and `Monthly  Income`<=50000 then "40k - 50K"
              when `Monthly  Income`>50000 and `Monthly  Income`<=60000 then "50K - 60K"
   end as Income_Group from hr_1 as a join hr_2 as b on ( a.`Employee  Number` = b.Emp_Id ) ;
   
    
###########################################################################################################################################################################
/*
      Q.4. Average working years for each Department
*/
select a.Department, round(avg(b.`Total Working Years`),2) as Avg_Working_Years 
          from hr_1 as a join hr_2 as b on ( a.`Employee  Number` = b.Emp_Id ) 
          group by Department;
###########################################################################################################################################################################
/*
     Q.5. Job Role Vs Work life balance
*/
select a.`Job  Role`,count(case when b.`Work Life Balance`='1' then a.Attrition_count end) as Poor,
			   count(case when b.`Work Life Balance`='2' then a.Attrition_count end) as Average,
			   count(case when b.`Work Life Balance`='3' then a.Attrition_count end) as Good,
			   count(case when b.`Work Life Balance`='4' then a.Attrition_count end) as Excellent,
			   count(a.Attrition_count)as Emp_Left from hr_1 as a join hr_2 as b on ( a.`Employee  Number` = b.Emp_Id ) 
          group by `Job  Role`;
###########################################################################################################################################################################
/*
    Q.6. Attrition rate Vs Year since last promotion relation
*/
select b.`Years Since Last Promotion`,count(a.Attrition_Count) as No_Of_Emp_Left from hr_1 as a join hr_2 as b on ( a.`Employee  Number` = b.Emp_Id ) 
               group by `Years Since Last Promotion` order by `Years Since Last Promotion` asc;
###########################################################################################################################################################################


