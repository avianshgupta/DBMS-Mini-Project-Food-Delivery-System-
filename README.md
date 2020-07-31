# DBMS-Mini-Project-Food-Delivery-System-
A GUI based food delivery system with database management.

Tools Used:
1. Netbeans
2. Java
3. PL SQL (procedures,functions,triggers,sequences etc.)

**FDs and Normalization**

1. Employees, Supervisors, Drivers Tables:
empId -> empName, empRegion, empPhone, empHours_worked, salary, licenseNo,
   wage, supervisorId, dRating

2. Customers Table
cId -> cName, cRegion, cPhone, cAddress

3. Orders Table
orderId -> total, cId, time_made, rId, empId, time_delivered

4. Restaurants Table
rId -> rName, rCuisine, rRegion, rPhone, rAddress, rRating

5. MenuItems table
rId, itemName -> itemPrice

**Normalization:**
All determinants are super keys to their respective tables, therefore all relations
are in BCNF form

**ER Diagram**
