Create or Replace Procedure delete_driver(eid in drivers.empid%TYPE)
AS
BEGIN
delete from drivers 
where empid = eid; 
delete from employees
where empid = eid;
END;
/

Create or Replace Procedure delete_supervisor(eid in drivers.empid%TYPE)
AS
BEGIN
update drivers set supervisorId = null where supervisorId = eid;
delete from supervisors 
where empid = eid; 
delete from employees
where empid = eid;
END;
/

-- insert values
CREATE OR REPLACE PROCEDURE add_supervisor(eid in employees.empid%TYPE,name in employees.empName%TYPE, region in employees.empRegion%TYPE, phone_no in employees.empPhone%TYPE, hours_worked in employees.empHours_worked%TYPE, sup_salary in supervisors.salary%TYPE,pwd in supervisors.password%TYPE)
AS
e_id employees.empid%TYPE;
CURSOR c1 IS SELECT empid from employees where empid = eid;
BEGIN
	open c1;
	FETCH c1 INTO e_id;
	if c1%found then
		insert into Supervisors values (eid, sup_salary,pwd);
	else
		insert into Employees values(eid, name, region, phone_no, hours_worked);
 		insert into Supervisors values (eid, sup_salary,pwd);
  	end if;
	update drivers set supervisorId = eid where supervisorId = null;
  
END;
/

-- insert values
CREATE OR REPLACE PROCEDURE add_driver(eid in employees.empid%TYPE,name in employees.empName%TYPE, region in employees.empRegion%TYPE, phone_no in employees.empPhone%TYPE, hours_worked in employees.empHours_worked%TYPE, license_no in drivers.licenseNo%TYPE, driver_wage in drivers.wage%TYPE, driver_rating in drivers.drating%TYPE, supervisor_id in drivers.supervisorId%TYPE)
AS
e_id employees.empid%TYPE;
CURSOR c1 IS SELECT empid from employees where empid = eid;
BEGIN
	open c1;
	FETCH c1 INTO e_id;
	if c1%found then
		insert into Drivers values (eid, license_no,driver_wage,driver_rating,supervisor_id);
	else	 
		insert into Employees values(eid, name, region, phone_no, hours_worked); 
		insert into Drivers values (eid, license_no,driver_wage,driver_rating,supervisor_id);
 	end if;


END;
/