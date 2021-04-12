use SalesOrdersExample

--Q1:Show me all the orders for customer number 1001.
select orderNumber from orders where customerID = 1001

--Q2:Show me an alphabetized list of products with names that begin with ‘Dog’.
select ProductName from products where ProductName like 'Dog%'

use EntertainmentAgencyExample

--Q3:Show me an alphabetical list of entertainers based in Bellevue, Redmond, or Woodinville.
select EntStageName from Entertainers where EntCity in ('Bellevue', 'Redmond', 'Woodinville')

--Q4:Show me all the engagements that run for four days.
select EngagementNumber from engagements where datediff(day,startDate,EndDate) =3

use SchoolSchedulingExample

--Q5:Show me an alphabetical list of all the staff members and their salaries if they make between $40,000 and $50,000 a year.
select StfLastName +','+ StfFirstName as StaffName, Salary from staff where Salary between 40000 and 50000 order by StaffName

--Q6:Show me a list of students whose last name is ‘Kennedy’ or who live in Seattle.
select StudentID, StudFirstName, StudLastName, StudCity from Students where StudLastName = 'Kennedy' or StudCity = 'Seattle'

use BowlingLeagueExample

--Q7:List the ID numbers of the teams that won one or more of the first ten matches in Game 3.
select WinningTeamID from Match_Games where GameNumber = 3 and MatchID between 1 and 10

--Q8:List the bowlers in teams 3, 4, and 5 whose last names begin with the letter ‘H’.
select BowlerFirstName, BowlerLastName, TeamID from Bowlers where TeamID in (3,4,5) and BowlerLastName like 'H%'

use RecipesExample

--Q9:List the recipes that have no notes.
select RecipeID, RecipeTitle from Recipes where Notes is null

--Q10:Show the ingredients that are meats (ingredient class is 2) but that aren’t chicken.
select IngredientID, IngredientName from ingredients where IngredientClassID = 2 and IngredientName not like '%Chicken%'