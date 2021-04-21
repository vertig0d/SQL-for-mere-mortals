use SalesOrdersExample

--Q1:What products have never been ordered?
select distinct(p.ProductNumber), p.ProductName, od.OrderNumber from Products as p 
	left outer join Order_Details as od on od.ProductNumber=p.ProductNumber 
	where od.OrderNumber is null
select * from Order_Details
select * from orders
select * from customers
select * from products where productname like '%bike'
--Q2:Display all customers and any orders for bicycles
select c.CustFirstName+','+c.CustLastName, bikeProduct.ProductName from customers as c
 left outer join
 (select o.OrderNumber,p.ProductName, o.CustomerID from orders as o
 join Order_Details as od on od.OrderNumber=o.OrderNumber 
 join Products as p on p.ProductNumber=od.ProductNumber
 where p.ProductName like '%bike') as bikeProduct on c.CustomerID=bikeProduct.CustomerID

 use EntertainmentAgencyExample
 
 --Q3:List entertainers who have never been booked.
 select e.EntertainerID, e.EntStageName, cust.CustomerID from Entertainers as e 
 left outer join
 (select eng.CustomerID, eng.EntertainerID from Engagements as eng 
 join Customers as c on c.CustomerID=eng.CustomerID) as cust on cust.EntertainerID=e.EntertainerID 
 where cust.CustomerID is null

 --Q4:Show me all musical styles and the customers who prefer those styles
 select ms.StyleID, ms.StyleName, mpc.CustomerID from Musical_Styles ms 
	left outer join 
	(select mp.CustomerID, mp.StyleID from Musical_Preferences as mp 
	join Customers c on c.CustomerID=mp.CustomerID) as mpc on mpc.StyleID=ms.StyleID

use SchoolSchedulingExample

--Q5:List the faculty members not teaching a class.
select staff.StaffID, staff.StfLastname+','+staff.StfFirstName as FullName from Staff 
left outer join Faculty_Classes as fc on fc.StaffID=staff.StaffID where fc.ClassID is null

--Q6:Display students who have never withdrawn from a class
select (s.StudFirstName+','+ s.StudLastName) as fullName from Students s 
left outer join 
(select ss.StudentID, scs.ClassStatusDescription from Student_Schedules ss 
join Student_Class_Status scs on scs.ClassStatus=ss.ClassStatus
where scs.ClassStatusDescription = 'withdrew') as classStat on classStat.StudentID=s.StudentID
where classStat.ClassStatusDescription is null

--Q7:Show me all subject categories and any classes for all subjects
select c.CategoryID, c.CategoryDescription, classSubj.SubjectID, classSubj.SubjectName, classSubj.ClassID from Categories as c
left outer join 
(select s.SubjectID, s.SubjectName, s.CategoryID, Classes.ClassID from Subjects as s 
 left outer join Classes on Classes.SubjectID=s.SubjectID) as classSubj on c.CategoryID=classSubj.CategoryID

 use BowlingLeagueExample

 --Q8:Show me tournaments that haven’t been played yet
 select t.TourneyID, t.TourneyLocation, unplayed.MatchID from Tournaments as t 
 left outer join 
 (select tm.TourneyID, tm.MatchID from Tourney_Matches as tm 
  left outer join Match_Games as mg on mg.MatchID=tm.MatchID) as unplayed on unplayed.TourneyID=t.TourneyID
  where unplayed.MatchID is null
  
--Q9:List all bowlers and any games they bowled over 180.
select b.BowlerID, b.BowlerFirstName,b.BowlerLastName, moreThan180.RawScore from Bowlers b 
left outer join 
(select bs.BowlerID, bs.RawScore from Bowler_Scores bs where bs.RawScore > 180) as moreThan180 on moreThan180.BowlerID=b.BowlerID

use RecipesExample

--Q10:List ingredients not used in any recipe yet.
select i.IngredientID, i.IngredientName from Ingredients as i 
left outer join 
(select ri.IngredientID, ri.RecipeID from Recipe_Ingredients as ri 
join Recipes r on r.RecipeID=ri.RecipeID) as orphanIngre on orphanIngre.IngredientID=i.IngredientID
where orphanIngre.RecipeID is null