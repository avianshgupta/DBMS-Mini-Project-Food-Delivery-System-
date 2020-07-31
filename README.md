# DBMS-Mini-Project-Food-Delivery-System-
A GUI based food delivery system with database management.

Tools Used:
1. Netbeans
2. Java
3. PL SQL (procedures,functions,triggers,sequences etc.)

### FDs and Normalization

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

### Normalization:

All determinants are super keys to their respective tables, therefore all relations
are in BCNF form

### ER Diagram

![ER](https://user-images.githubusercontent.com/45178946/89016877-14920f80-d337-11ea-9aa6-c8c08a72e0da.PNG)

### Relational Schema

![Relational_Schema](https://user-images.githubusercontent.com/45178946/89016924-283d7600-d337-11ea-8e40-d41e0d6d9852.PNG)

### Screenshots

**Home Screen**

![Home](https://user-images.githubusercontent.com/45178946/89018135-02b16c00-d339-11ea-93bc-d4a5c7d17206.PNG)

**Supervisor Login**

![slogin](https://user-images.githubusercontent.com/45178946/89018256-2b396600-d339-11ea-9973-e7d0c720be0e.PNG)

**Supervisor Panel**

![spanel](https://user-images.githubusercontent.com/45178946/89018413-7b182d00-d339-11ea-8a56-04aaa19f78d7.PNG)

**Employee List**

![elist](https://user-images.githubusercontent.com/45178946/89018529-a7cc4480-d339-11ea-92d2-b52a82c536de.PNG)

**Driver List**

![dlist](https://user-images.githubusercontent.com/45178946/89018652-ce8a7b00-d339-11ea-935b-77e7c3250e32.PNG)

**Driver Delete Operation**

![ddop](https://user-images.githubusercontent.com/45178946/89018881-232df600-d33a-11ea-881d-803b17aef336.png)

**Supervisor Delete Operation**

![spdo](https://user-images.githubusercontent.com/45178946/89019039-596b7580-d33a-11ea-9947-3f2b53247187.png)

**Add Employee**

![addemp](https://user-images.githubusercontent.com/45178946/89019088-6ab48200-d33a-11ea-8d3b-791236e43b25.png)

**Add Customer**

![addcust](https://user-images.githubusercontent.com/45178946/89019135-7d2ebb80-d33a-11ea-824a-328493f2c3ff.png)

**Customer Login**

![cl](https://user-images.githubusercontent.com/45178946/89019172-8ddf3180-d33a-11ea-8c46-09c436f5856e.png)

**Customer Service**

![cs](https://user-images.githubusercontent.com/45178946/89019209-9df71100-d33a-11ea-80ae-5edc90e24f02.png)

**Show Restaurants**

![sr1](https://user-images.githubusercontent.com/45178946/89019281-b1a27780-d33a-11ea-9626-119ec08d90a9.png)

![sr2](https://user-images.githubusercontent.com/45178946/89019283-b404d180-d33a-11ea-93d1-1c2484f31f0e.png)

**Show Orders**

![so1](https://user-images.githubusercontent.com/45178946/89019337-c41cb100-d33a-11ea-95c3-de310c49bbb4.png)

![so2](https://user-images.githubusercontent.com/45178946/89019349-c848ce80-d33a-11ea-8afe-ebb5e5d9af62.png)

**Place Orders**

![por](https://user-images.githubusercontent.com/45178946/89019439-eadae780-d33a-11ea-92fb-81b309c81ac2.png)

![ord2](https://user-images.githubusercontent.com/45178946/89019444-eca4ab00-d33a-11ea-9bf6-e8abb01f2b92.png)

**Rating**

![rating](https://user-images.githubusercontent.com/45178946/89019485-fa5a3080-d33a-11ea-9027-4a73eb2ddb3a.png)


