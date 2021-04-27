use SalesOrdersExample

--Q1:List for each customer and order date the customer’s full name and the total cost of items ordered that is greater than $1,000
select c.CustomerID, c.CustFirstName, c.CustLastName, o.OrderDate from Customers as c 
join Orders as o on c.CustomerID=o.CustomerID
join Order_Details as od on od.OrderNumber=o.OrderNumber
group by c.CustomerID,c.CustFirstName,c.CustLastName,o.OrderDate having sum(od.QuotedPrice*od.QuantityOrdered) > 1000

use EntertainmentAgencyExample

--Q2:Which agents booked more than $3,000 worth of business in December 2017
select a.AgentID, a.AgtFirstName, a.AgtLastName, sum(eng.ContractPrice) from Agents as a 
join Engagements as eng on a.AgentID=eng.AgentID
where StartDate between '2017-12-01' and '2017-12-31'
group by a.AgentID, a.AgtFirstName, a.AgtLastName having sum(eng.ContractPrice) > 3000

use SchoolSchedulingExample

--Q3:For completed classes, list by category and student the category name, the student name, 
--and the student’s average grade of all classes taken in that category for those students who have an average higher than 90.
select s.StudFirstName,s.StudLastName, cat.CategoryDescription,avg(ss.Grade) from Students as s 
join Student_Schedules as ss on ss.StudentID=s.StudentID
join classes as c on c.ClassID=ss.ClassID
join Subjects as subj on subj.SubjectID=c.SubjectID
join Categories as cat on cat.CategoryID=subj.CategoryID
join Student_Class_Status as scs on scs.ClassStatus=ss.ClassStatus
where scs.ClassStatusDescription='completed'
group by s.StudentID,s.StudFirstName,s.StudLastName,cat.CategoryDescription having avg(ss.grade)>90

--Q4:List each staff member and the count of classes each is scheduled to teach for those staff members 
--who teach at least one but fewer than three classes
select s.StfFirstName,s.StfLastname, count(*) as classCount from Staff as s join Faculty_Classes as fc on fc.StaffID=s.StaffID 
group by s.StfFirstName, s.StfLastname having count(*) <3

use BowlingLeagueExample

--Q5:List the bowlers whose highest raw scores are more than 20 pins higher than their current averages.
select b.BowlerFirstName,b.BowlerLastName, avg(bs.RawScore),max(bs.RawScore) from Bowlers as b
join Bowler_Scores as bs on b.BowlerID=bs.BowlerID
group by b.BowlerFirstName,b.BowlerLastName having max(bs.RawScore) > (avg(bs.RawScore)+20)

use RecipesExample
--Clever way to solve, can also be done using intersect
--Q6:List the recipes that contain both beef and garlic
select r.RecipeTitle from Recipes as r
join Recipe_Ingredients as ri on ri.RecipeID=r.RecipeID
join Ingredients as i on i.IngredientID=ri.IngredientID
where i.IngredientName='beef' or i.IngredientName='garlic'
group by r.RecipeTitle having count(*) =2