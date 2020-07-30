-- drop tables
drop table orders; 
drop table menuitems;
drop table restaurants;
drop table customers;
drop table drivers;
drop table supervisors;
drop table employees;



Create table Employees(
empId varchar2(10) constraint EMP_ID_PK primary key,
empName varchar2(20),
empRegion varchar2(15),
empPhone varchar2(13),
empHours_worked number(3,2),
constraint CHK_EMPHRS check (empHours_worked <= 8));

Create table Supervisors(
empId varchar2(10),
salary number(9, 2),
password varchar2(20),
constraint SUP_PK primary key (empId),
constraint SUP_EID_FK foreign key (empId) references Employees (empId));

Create table Drivers(
empId varchar2(10),
licenseNo varchar2(8),
wage number(4, 2),
drating float,
supervisorId varchar2(10),
constraint DRI_PK primary key   (empId),
constraint DRI_EID_FK foreign key   (empId) references Employees (empId),
constraint DRI_SID_FK foreign key   (supervisorId) references Supervisors (empId)); 

Create table Customers(
cId varchar2(5) constraint CID_PK primary key,
cName varchar2(20),
cPhone varchar2(10),
cAddress varchar2(25),
cRegion varchar2(15),
password varchar2(20)); 

Create table Restaurants(
rId varchar2(5) constraint RtID_pk primary key,
rName varchar2(20),
rrating float,
rCuisine varchar2(15),
rPhone varchar2(13),
rAddress varchar2(30),
rRegion varchar2(15));

Create table MenuItems(
rId varchar2(5),
itemName varchar2(25),
itemPrice number(5,2),
constraint MENU_ITMS_PK primary key (rId, itemName),
constraint MENU_ITEMS_RID_FK foreign key (rId) references Restaurants (rId));

Create table Orders(
orderId varchar2(5) constraint ORDID_PK primary key,
cId varchar2(5),
rId varchar2(5),
time_made Date,
total number(5,2),
empId varchar2(10),
time_delivered Date,
fooditem varchar2(100),
constraint ORD_CID_FK foreign key   (cId) references Customers (cId),
constraint ORD_RID_FK foreign key   (rId) references Restaurants (rId),
constraint ORD_EID_FK foreign key   (empId) references Drivers (empId));

