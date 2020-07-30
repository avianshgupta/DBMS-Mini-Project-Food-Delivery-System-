-- delete existing data
delete from Orders;
delete from MenuItems;
delete from Customers;
delete from Restaurants;
delete from Drivers;
delete from Supervisors;
delete from Employees;

drop sequence emp_seq;
drop sequence rest_seq;


-- SEQUENCES
Create sequence emp_seq
start with 1
increment by 1
minvalue 0
maxvalue 500
NOCACHE
NOCYCLE;

Create sequence rest_seq
start with 1
increment by 1
minvalue 0
maxvalue 500
NOCACHE
NOCYCLE;



-- TRIGGERS --
CREATE OR REPLACE TRIGGER CHECK_SUPVSR
    BEFORE INSERT ON Supervisors
    FOR EACH ROW
DECLARE
    supvsrct integer :=0;
    sregion varchar(15);

BEGIN
    /*get the region of the supervisor trying to be inserted  (assumes the new supervisor is already an employee) */
    Select empRegion 
    into sregion
    from Employees
    where empId = :NEW.empId; 

    /* find the count of supervisors who has the same region as the inserted supervisor */
    Select count(empId)
    into supvsrct
    FROM Employees natural join Supervisors
    Where empRegion = sregion;

    if supvsrct > 0 then
        RAISE_APPLICATION_ERROR(-20000, 'Cannot Insert: The given region already has a supervisor.');
    END IF;

END;
/
show errors;


CREATE OR REPLACE TRIGGER fromSameRegion
    BEFORE INSERT ON Orders
    FOR EACH ROW
DECLARE
    l_cRegion Customers.cRegion%type;
    l_empRegion Employees.empRegion%type;
    l_rRegion Restaurants.rRegion%type;
  
BEGIN
    Select cRegion into l_cRegion
    From Customers
    Where cID = :new.cID;

    Select empRegion into l_empRegion
    From Employees
    Where empId = :new.empID;

    Select rRegion into l_rRegion
    From Restaurants
    Where rId = :new.rID; 

    IF (l_cRegion <> l_empRegion) or (l_cRegion <> l_rRegion) or  (l_empRegion <> l_rRegion) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cannot Insert: Customer, driver, and/or restaurant are not from the same region.');
    END IF; 
END;
/
show errors; 


-- insert values
CREATE OR REPLACE PROCEDURE loadEmployeeData
AS
BEGIN
  insert into Employees values('e'||emp_seq.nextval, 'Olivia Liu', 'San Jose', '4082345679', 8);    -- 1 SUPERVISOR
  insert into Employees values('e'||emp_seq.nextval, 'Adam Jones', 'San Jose', '4082225678', 4); -- 2 DRIVER
  insert into Employees values('e'||emp_seq.nextval, 'Maggie Jones', 'San Jose', '4088458323', 4.5); -- 3 DRIVER
  insert into Employees values('e'||emp_seq.nextval, 'Sherene Bennett', 'San Jose', '4086341212', 5);  -- 4 DRIVER
  
  insert into Employees values('e'||emp_seq.nextval, 'Carla Jepsen', 'San Francisco', '4158948003', 8); -- 5 SUPERVISOR
  insert into Employees values('e'||emp_seq.nextval, 'David Kim', 'San Francisco', '4087896478', 6.5); -- 6 DRIVER
  
  insert into Employees values('e'||emp_seq.nextval, 'Luis Garcia', 'Fremont' , '5104328006', 8); -- 7 SUPERVISOR
  insert into Employees values('e'||emp_seq.nextval, 'Jess Applegate', 'Fremont' , '5104328006', 5); -- 8 DRIVER
  
  insert into Employees values('e'||emp_seq.nextval, 'Doug White', 'Santa Clara', '4083345432', 8); -- 9 SUPERVISOR 
  insert into Employees values('e'||emp_seq.nextval, 'Ira Kassen', 'Santa Clara', '4082553399', 4.5); -- 10 DRIVER 
  
  insert into Employees values('e'||emp_seq.nextval, 'Luna Granger', 'Palo Alto', '4085653432', 8); -- 11 SUPERVISOR
  insert into Employees values('e'||emp_seq.nextval, 'Ron Potter', 'Palo Alto', '6152553389', 4.5); -- 12 DRIVER 
  

  insert into Supervisors values ('e1', 85000,'e1admin'); -- SJ
  insert into Supervisors values ('e5', 80000,'e5admin'); -- SF
  insert into Supervisors values ('e7', 80000,'e7admin'); -- Fremont
  insert into Supervisors values ('e9', 80000,'e9admin'); -- Santa Clara
  insert into Supervisors values ('e11', 80000,'e11admin'); -- Palo Alto
  
  insert into Drivers values ('e2', 'F5628921', 13.50, 1,'e1');
  insert into Drivers values ('e3', 'F8214211', 13.50, 1,'e1');
  insert into Drivers values ('e4', 'F7757382', 14.00, 1,'e1');
  insert into Drivers values ('e6', 'F3226881', 13.00, 1,'e5');
  insert into Drivers values ('e8', 'F3456881', 13.00, 1,'e7');
  insert into Drivers values ('e10', 'F3676881', 13.00, 1,'e9');
  insert into Drivers values ('e12', 'F8921811', 13.00, 1,'e11');
END;
/
show errors; 

exec loadEmployeeData;


CREATE OR REPLACE PROCEDURE loadRestaurantData
AS
BEGIN
  insert into Restaurants values ('r'||rest_seq.nextval, 'Via Mia Pizza',1, 'Italian', '4082444100', '1150 Saratoga Ave 95129', 'San Jose'); -- 1
  insert into Restaurants values ('r'||rest_seq.nextval, 'La Victoria', 1,'Mexican', '4082985335', '140 E San Carlos St 95112', 'San Jose'); -- 2
  insert into Restaurants values ('r'||rest_seq.nextval, 'La Victoria', 1,'Mexican', '4089938230', '131 W Santa Clara St 95113', 'San Jose'); -- 3
  insert into Restaurants values ('r'||rest_seq.nextval, 'Athena Grill', 1,'Italian', '4085679144', '1505 Space Park Dr 95054', 'Santa Clara'); -- 4
  insert into Restaurants values ('r'||rest_seq.nextval, 'Pizza My Heart', 1,'American', '4082410000', '700 Bellomy St 95050', 'Santa Clara'); -- 5
  insert into Restaurants values ('r'||rest_seq.nextval, 'Eastern Winds', 1,'Chinese', '5102261588', '6997 Warm Springs Blvd 94539', 'Fremont'); -- 6
  insert into Restaurants values ('r'||rest_seq.nextval, 'Chaat Bhavan', 1,'Indian', '5107951100', '5355 Mowry Ave 94538', 'Fremont'); -- 7
  insert into Restaurants values ('r'||rest_seq.nextval, 'Osaka Sushi', 1,'Japanese', '4152558828', '460 Castro St 95114', 'San Francisco'); -- 8
  insert into Restaurants values ('r'||rest_seq.nextval, 'Farmhouse Kitchen', 1,'Thai', '4158142920', '710 Florida St 94110', 'San Francisco'); -- 9
  insert into Restaurants values ('r'||rest_seq.nextval, 'Oren''s Hummus Shop', 1,'Israeli', '6507526492', '261 University Ave 94301', 'Palo Alto');--10
  insert into Restaurants values ('r'||rest_seq.nextval, 'Tamarine Restaurant', 1,'Vietnamese', '6503258500', '560 University Ave', 'Palo Alto');
END;
/
show errors; 

exec loadRestaurantData;




-- MenuItems (restaurantId, itemName, itemPrice)
CREATE OR REPLACE PROCEDURE loadMenuItems
AS
BEGIN
  insert into MenuItems values ('r1', 'Italiana Pizza', 7.99); 
  insert into MenuItems values ('r1', 'Stromboli Pizza', 8.99);
  insert into MenuItems values ('r1', 'Siciliana Beef Pizza', 8.99);
  insert into MenuItems values ('r1', 'Traditional Calzone', 6.99);
  
  insert into MenuItems values ('r2', 'Regular Burrito', 5.45);
  insert into MenuItems values ('r2', 'Super Burrito', 6.45);
  insert into MenuItems values ('r2', 'Veggie Burrito', 5.45);
  
  insert into MenuItems values ('r3', 'Regular Burrito', 5.45);
  insert into MenuItems values ('r3', 'Super Burrito', 6.45);
  insert into MenuItems values ('r3', 'Veggie Burrito', 5.45);
  
  insert into MenuItems values ('r5', 'Big Sur - 12 in', 17.00);
  insert into MenuItems values ('r5', 'Davenport - 12 in', 17.00);
  insert into MenuItems values ('r5', 'Maui Wowie - 12 in', 15.00);
  
  insert into MenuItems values ('r4', 'Gyro Plate', 14.50);
  insert into MenuItems values ('r4', 'Chicken Souvlaki Plate', 14.50);
  insert into MenuItems values ('r4', 'Beef Souvlaki Plate', 18.95);
  
  insert into MenuItems values ('r6', 'Orange Chicken', 8.95);
  insert into MenuItems values ('r6', 'Chicken Chow Mein', 7.95);
  
  insert into MenuItems values ('r7', 'Samosa', 3.99);
  insert into MenuItems values ('r7', 'Dabeli', 5.49); 
  insert into MenuItems values ('r7', 'Misal Pav', 6.99); 
  
  insert into MenuItems values ('r8', 'Chicken Teriyaki Plate', 14.95); 
  insert into MenuItems values ('r8', 'Salmon Teriyaki Plate', 16.95); 
  insert into MenuItems values ('r8', 'Agedashi Tofu', 5.95); 
  insert into MenuItems values ('r8', 'Assorted Tempura', 6.95); 
  
  insert into MenuItems values ('r9', 'Fish Cake', 9.00);
  insert into MenuItems values ('r9', 'Tom Yum Kai', 6.00);
  insert into MenuItems values ('r9', 'Pad Thai', 14.00); 
  
  insert into MenuItems values ('r10', 'Hummus Classic', 8.95);
  insert into MenuItems values ('r10', 'Falafel Sandwich', 9.95);
  
  insert into MenuItems values ('r11', 'Banh Mi Roti', 10.00);
  insert into MenuItems values ('r11', 'Shrimp Spring Rolls', 12.00);
  insert into MenuItems values ('r11', 'Wok Beef Noodles', 18.00);

END;
/
show errors;

exec loadMenuItems;


CREATE OR REPLACE PROCEDURE updateRatings
(Rest_id IN Restaurants.rId%TYPE,Dr_id IN Drivers.empId%TYPE,nrr IN float,ndr IN float) IS
	oldrr float;
	olddr float;
BEGIN
	select rrating into oldrr from Restaurants where rid=Rest_id;
	select drating into olddr from Drivers where empId=Dr_id;
	update Restaurants set rrating=(oldrr+nrr)/2 where rid=Rest_id;
	update Drivers set drating=(olddr+ndr)/2 where empId=Dr_id;
END;
commit;

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

