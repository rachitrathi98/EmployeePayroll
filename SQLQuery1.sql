
create database payroll_service;
use payroll_service;

/* UC2 */
create table employee_payroll(
id int not null identity(1,1) primary key,
name varchar(50) not null,
salary decimal(10,2) not null,
start_date DateTime not null
);

/* UC3 */
insert into employee_payroll values
('Rachit', 50000, '2020-09-18'),
('Mohit', 2000, '2021-02-03'),
('Parth', 1500, '2019-05-26');

/* UC4 */
SELECT * FROM employee_payroll

insert into employee_payroll values
('Maya', 80000, '2020-07-18','F'),
('Alexa', 35000, '2021-05-03','F');

/* UC4 */
select * from employee_payroll;

/* UC5 */
select salary from employee_payroll where name='Mohit';
select * from employee_payroll where start_date between cast('01-01-2019' as date) and GETDATE();

/* UC6 */
alter table employee_payroll
add gender char;

update employee_payroll
set gender='M'
 where name = 'Rachit' or name='Mohit' or name='Parth';

 /* UC7 */
 select sum(salary) as sum from employee_payroll where gender='F';
 select gender, ROUND(AVG(salary),2) as average from employee_payroll group by gender;
 select gender, COUNT(name) as total_emp from employee_payroll group by gender;
 select name from employee_payroll where salary in (select max(salary) from employee_payroll);


 /* UC8 & UC9 */
 /* Create New Table */
create table emp_payroll(
EmpId int identity(1,1) primary key,
EmpName varchar(50),
EmpPhoneNumber varchar(50),
EmpAddress varchar(50),
Department varchar(50) not null,
Gender char(1),
BasicPay float,
Deductions float,
TaxablePay float,
Tax float,
NetPay float,
StartDate Date,
City varchar(50),
);

/* alter table */
alter table emp_payroll
add Country varchar(50) default(' ');

select * from emp_payroll;

/* UC10 */
/* Insert values */
insert into emp_payroll(EmpName,Department, Gender, BasicPay, StartDate) values
('Terisa','Analyst','F',80000,'2019-11-13'),
('Charlie','Finance','M', 50000, '2020-09-18'),
('Bill','Testing','M', 25000, '2021-02-03'),
('Mark','Support','M', 23000, '2019-05-26');

/* insert another record of same name*/
insert into emp_payroll values
('Terisa','123456789','Mumbai','HR','F',30000,5000, 2000, 1000, 20000,'2018-06-26','Mumbai','IN');

select * from emp_payroll where EmpName ='Terisa';

/* Describe tables */
exec sp_columns emp_payroll;
Select * From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'emp_payroll'

/* show databases */
exec sp_databases;

/* UC11  */
/*  Implement ER Diagram */
/* Create Company table */
create table Company(
C_ID int not null,
C_Name varchar(50) not null
);

/* insert data */
insert into Company values
(100,'Capgemini');

/* Add a primary key to an existing table */
alter table Company
add constraint company_id primary key(C_ID);

select * from Company;

/* Create Employee table */
Create table Employee(
E_ID int not null primary key,
C_ID int not null,
E_Name varchar(50) not null,
E_PhoneNumber varchar(50) not null,
E_Address varchar(50) not null,
E_Gender char(1) not null,
E_StartDate date not null,
foreign key(C_ID) references Company(C_ID) 
);


/* insert data */
insert into Employee values
(1020,100,'Terisa','123456789','Mumbai','F','2018-06-26'),
(1021,100,'Mark','987654312','Indore','M','2019-08-26');

select * from Employee;


/* Create Department table */
create table Department(
D_ID int not null primary key,
D_Name varchar(50) not null,
);


/* insert data */
insert into Department values
(10,'HR'),
(20,'Marketing'),
(30,'Development');

select * from Department;


/*Create Emp_Dept table */
Create table Emp_Dept(
Emp_ID int not null,
Dept_ID int not null,
foreign key(Emp_ID) references Employee(E_ID),
foreign key(Dept_ID) references Department(D_ID)
);

/* insert data */
insert into Emp_Dept values
(1020, 10),
(1020,20),
(1021,30);

select * from Emp_Dept;

/*Create Payroll table */
Create table Payroll(
E_ID int not null,
BasicPay float not null,
Deductions float not null,
TaxablePay float not null,
Tax float not null,
NetPay float not null,
foreign key(E_ID) references Employee(E_ID)
);


/* insert data */
insert into Payroll values
(1020,30000,5000, 2000, 1000, 20000),
(1021,40000,6000, 2000, 1200, 31500);

select * from Payroll;


/* UC12  */
/* Retriving Data from Newly created ER tables  */

/* Sample try */
select * from Company inner join Employee on Company.C_ID=Employee.C_ID;

/* Salary of particular Emp */
select E.E_Name as Name, P.NetPay as Salary from Employee E, Payroll P where E.E_ID=P.E_ID and E.E_Name='Terisa';

/* Salary of Emp joined on a particular date */
select E.E_Name as Name, P.NetPay as Salary from Employee E, Payroll P where E.E_ID=P.E_ID and (E.E_StartDate between cast('2018-10-16' as date) and GETDATE());

/* Calulating Total Emp in a company */
select count(E.E_ID) as TotalEmployees from Company C join Employee E on C.C_ID=E.C_ID; 

/* Sample try */
select * from Employee, Department, Emp_Dept where Employee.E_ID=Emp_Dept.Emp_ID and Department.D_ID=Emp_Dept.Dept_ID;