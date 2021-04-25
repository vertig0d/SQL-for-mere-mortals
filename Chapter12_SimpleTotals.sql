use SalesOrdersExample

--Q1:How many customers do we have in the state of California?
select count(*) as custFrmCA from Customers where CustState = 'CA'

--Q2:List the product names and numbers that have a quoted price greater than or equal to the overall average retail price in the products table.
select distinct(p.ProductName),p.ProductNumber from products as p join order_details as od on p.ProductNumber=od.ProductNumber where od.QuotedPrice >=
(select avg(RetailPrice) from Products)

use EntertainmentAgencyExample

--Q3:List the engagement number and contract price of contracts that occur on the earliest date
select EngagementNumber, ContractPrice from Engagements 
where StartDate=(select min(startDate) from Engagements)

--Q4:What was the total value of all engagements booked in October 2017?
select sum(contractPrice) from Engagements where StartDate between '2017-10-01' and '2017-10-31'

use SchoolSchedulingExample

--Q5:What is the largest salary we pay to any staff member?
select max(salary) as maxSalary from staff 

--Q6:What is the total salary amount paid to our staff in California?
select sum(Salary) as sumSalary from staff where StfState = 'CA'

use BowlingLeagueExample

--Q7:How many tournaments have been played at Red Rooster Lanes?
select count(tourneyID) from Tournaments where TourneyLocation = 'Red Rooster Lanes'

--Q8:List the last name and first name, in alphabetical order, 
--of every bowler whose personal average score is greater than or equal to the overall average score.
select b.BowlerFirstName, b.BowlerLastName from bowlers as b 
where (select avg(bs.RawScore) from Bowler_Scores as bs where bs.BowlerID=b.BowlerID) 
>= (select avg(RawScore) from Bowler_Scores) order by b.BowlerFirstName, b.BowlerLastName

use RecipesExample 

--Q9:How many recipes contain a beef ingredient?
select count(RecipeID) from Recipe_Ingredients where IngredientID in (select IngredientID from Ingredients where IngredientName like '%beef%')

--Q10:How many ingredients are measured by the cup?
select count(ingredientID) from Ingredients 
where MeasureAmountID = (select MeasureAmountID from Measurements where MeasurementDescription = 'cup')