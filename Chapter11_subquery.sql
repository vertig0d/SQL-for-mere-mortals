use SalesOrdersExample

--Q1:List vendors and a count of the products they sell to us.
select VendorID, VendName, 
(select count(pv.VendorID) from Product_Vendors as pv where pv.VendorID=Vendors.VendorID) as productsCount from Vendors

use EntertainmentAgencyExample

--Q2:Display all customers and the date of the last booking each made.
select Customers.CustFirstName+','+Customers.CustLastName,
(select max(e.StartDate) from Engagements as e where e.CustomerID=Customers.CustomerID) as lastbooking
from Customers

use SchoolSchedulingExample

--Q3:Display all subjects and the count of classes for each subject on Monday.
select s.SubjectName, (select count(c.ClassID) from Classes as c where c.SubjectID=s.SubjectID and c.MondaySchedule = 1) from Subjects as s

use BowlingLeagueExample

--Q4:Display the bowlers and the highest game each bowled.
select b.BowlerFirstName+','+b.BowlerLastName as fullName, 
(select max(bs.RawScore) from Bowler_Scores as bs where bs.BowlerID=b.BowlerID) as bowlerScore
from Bowlers as b

use RecipesExample

--Q5:List all the meats and the count of recipes each appears in.
select i.IngredientName,
(select count(ri.RecipeID) from Recipe_Ingredients as ri where ri.IngredientID=i.IngredientID) 
from Ingredients as i where i.IngredientClassID = 2

use SalesOrdersExample

--Q6:Display customers who ordered clothing or accessories.
select c.CustomerID,c.CustFirstName,c.CustLastName from Customers as c where exists 
(select * from Products join Categories on Categories.CategoryID=Products.CategoryID 
join Order_Details as od on od.ProductNumber=products.ProductNumber 
join Orders as o on o.OrderNumber=od.OrderNumber where c.CustomerID=o.CustomerID) order by c.CustomerID

use EntertainmentAgencyExample
--NOTE: while using exists we need to specify ent.entertainerID=eng.entertainerID
--Q7:List the entertainers who played engagements for customer Berg.
select ent.EntStageName from Entertainers as ent where exists 
(select * from customers as c join Engagements as eng on eng.CustomerID=c.CustomerID where c.CustLastName = 'Berg' and eng.EntertainerID=ent.EntertainerID)
--alternatively using 'IN'
select ent.EntStageName from Entertainers as ent where ent.EntertainerID in 
(select eng.EntertainerID from Engagements as eng join Customers as c on c.CustomerID=eng.CustomerID where c.CustLastName = 'berg')

use SchoolSchedulingExample
--NOTE: if we give <> 3 in the subquery there might be some student who might have completed or still studying a subject but also withdrew some subject.
--by selecting student who withdrew and then discarding the students finally will give the correct solution..
--Q8:Display students who have never withdrawn from a class.
select s.StudFirstName, s.StudLastName from Students as s where s.StudentID not in 
(select StudentID from Student_Schedules where ClassStatus = 3)

