use SalesOrdersExample

--Q1:Show me all the customer and employee names and addresses, including any duplicates, sorted by ZIP Code.
select CustomerID, CustFirstName, CustLastName, CustStreetAddress, CustZipCode from Customers 
union all
select EmployeeID, EmpFirstName, EmpLastName, EmpStreetAddress, EmpZipCode from Employees
order by 5

--Q2:List all the customers who ordered a bicycle combined with all the customers who ordered a helmet.
select c.CustomerID, c.CustFirstName, c.CustLastName,'bike' as ProdType from Customers as c 
join Orders as o on o.CustomerID=c.CustomerID 
join Order_Details as od on od.OrderNumber=o.OrderNumber 
join Products as p on p.ProductNumber=od.ProductNumber 
where p.ProductName like '%bike%'
union
select c1.CustomerID, c1.CustFirstName, c1.CustLastName, 'helmet' as ProdType  from Customers as c1 
join Orders as o1 on o1.CustomerID=c1.CustomerID 
join Order_Details as od1 on od1.OrderNumber=o1.OrderNumber 
join Products as p1 on p1.ProductNumber=od1.ProductNumber 
where p1.ProductName like '%helmet%'

use EntertainmentAgencyExample

--Q3:Create a list that combines agents and entertainers.
select AgentID as ID, AgtFirstName+','+AgtLastName as FullName,AgtStreetAddress,AgtZipCode from Agents
union
select EntertainerID,EntStageName,EntStreetAddress,EntZipCode from Entertainers

use SchoolSchedulingExample

--Q4:Show me the students who have a grade of 85 or better in Art together with the faculty members 
--who teach Art and have a proficiency rating of 9 or better
select s.StudFirstName as FName, s.StudLastName as LName, ss.Grade, 'student' as Stud_Teach from Students as s 
join Student_Schedules as ss on ss.StudentID=s.StudentID 
join Classes on Classes.ClassID=ss.ClassID 
join Subjects on Subjects.SubjectID=Classes.SubjectID 
where subjects.CategoryID = 'ART' and ss.Grade >= 85 and ss.ClassStatus =2
union
select Staff.StfFirstName, Staff.StfLastname, fs.ProficiencyRating, 'Faculty' from Staff 
join Faculty_Subjects as fs on fs.StaffID=Staff.StaffID 
join Faculty_Categories as fc on fc.StaffID=Staff.StaffID
join Subjects on Subjects.SubjectID=fs.SubjectID
where Subjects.CategoryID='ART' and fs.ProficiencyRating >8

use BowlingLeagueExample

--Q5:List the tourney matches, team names, and team captains for the teams starting on the odd lane 
--together with the tourney matches, team names, and team captains for the teams starting on the even lane, 
--and sort by tournament date and match number.
select t.TourneyLocation,teams.TeamName,Bowlers.BowlerFirstName+','+Bowlers.BowlerLastName as Captain,'oddlane',
t.TourneyDate,tm.MatchID from Tourney_Matches as tm
join Tournaments as t on t.TourneyID=tm.TourneyID
join teams on teams.TeamID=tm.OddLaneTeamID
join Bowlers on Bowlers.BowlerID=teams.CaptainID
union
select t.TourneyLocation,teams.TeamName,Bowlers.BowlerFirstName+','+Bowlers.BowlerLastName as Captain,'oddlane',
t.TourneyDate,tm.MatchID from Tourney_Matches as tm
join Tournaments as t on t.TourneyID=tm.TourneyID
join teams on teams.TeamID=tm.EvenLaneTeamID
join Bowlers on Bowlers.BowlerID=teams.CaptainID
order by t.TourneyDate, tm.MatchID

use RecipesExample

--Q6:Create an index list of all the recipe classes, recipe titles, and ingredients
select RecipeClassDescription,'Recipe Class' from Recipe_Classes
union
select RecipeTitle, 'Recipes' from Recipes
union
select IngredientName, 'ingredient' from Ingredients