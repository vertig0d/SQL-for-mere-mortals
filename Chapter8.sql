use SalesOrdersExample

--Q1:Display all products and their categories.
select Categories.CategoryDescription, p.ProductName from products as p join categories on p.CategoryID = Categories.CategoryID

use EntertainmentAgencyExample

--Q2:Show me entertainers, the start and end dates of their contracts, and the contract price.
select a.EntStageName, b.StartDate, b.EndDate, b.ContractPrice from Entertainers as a join Engagements as b 
on a.EntertainerID = b.EntertainerID order by a.EntStageName

use SchoolSchedulingExample

--Q3:List the subjects taught on Wednesday.
select distinct(s.SubjectName) from Subjects as s join Classes on Classes.SubjectID = s.SubjectID
where Classes.WednesdaySchedule = 1

use BowlingLeagueExample

--Q4:Display bowling teams and the name of each team captain.
select t.TeamName, b.BowlerLastName +','+ b.BowlerFirstName as BowlerName from Teams as t join Bowlers as b 
on t.CaptainID = b.BowlerID

use RecipesExample

--Q5:Show me the recipes that have beef or garlic.
select distinct(r.RecipeTitle) from Recipes as r join Recipe_Ingredients as ri on r.RecipeID=ri.RecipeID 
where ri.IngredientID in (1,9)

--using the knowledge from previous chapter, we can also use union. shown below.
--select RecipeID from Recipe_Ingredients where IngredientID = 1 union select RecipeID from Recipe_Ingredients where IngredientID = 9

use SalesOrdersExample

--Q6:Find all the customers who have ever ordered a bicycle helmet.
select distinct(c.CustLastName +','+ c.CustFirstName) from Customers as c
	 join Orders as o on c.CustomerID=o.CustomerID 
	 join Order_Details as od on o.OrderNumber=od.OrderNumber 
	 join Products as p on od.ProductNumber=p.ProductNumber
	  where p.ProductNumber in (10,25,26)

use EntertainmentAgencyExample

--Q7:Find the entertainers who played engagements for customers Berg or Hallmark.
select distinct(ent.EntStageName) from Entertainers as ent 
	join Engagements as eng on ent.EntertainerID=eng.EntertainerID 
	join Customers as c on eng.CustomerID=c.CustomerID 
	where c.CustLastName in ('berg','hallmark')

use BowlingLeagueExample

--Q8:List all the tournaments, the tournament matches, and the game results.
select t.TourneyID as Tourney, t.TourneyLocation, tm.MatchID, tm.Lanes, 
	oddLane.TeamName, evenLane.TeamName, mg.GameNumber, winners.TeamName as Winner from Tournaments as t
	join Tourney_Matches as tm on t.TourneyID=tm.TourneyID
	join Match_Games as mg on tm.MatchID=mg.MatchID
	join Teams as oddLane on tm.OddLaneTeamID=oddLane.TeamID
	join Teams as evenLane on tm.EvenLaneTeamID=evenLane.TeamID
	join Teams as winners on mg.WinningTeamID=winners.TeamID

use RecipesExample

--Q9:Show me the main course recipes and list all the ingredients.
select r.RecipeTitle, i.IngredientName, m.MeasurementDescription, ri.Amount from Recipes as r 
	join Recipe_Ingredients as ri on r.RecipeID=ri.RecipeID
	join Ingredients as i on ri.IngredientID=i.IngredientID
	join Measurements as m on ri.MeasureAmountID=m.MeasureAmountID
	where r.RecipeClassID = 1

use SalesOrdersExample
select * from Customers
select * from orders
select * from Order_Details
select * from Products
--Q10:Find all the customers who ordered a bicycle and also ordered a helmet.
select custHelmet.CustFirstName, custHelmet.CustLastName from
((select distinct(c.CustomerID), c.CustFirstName, c.CustLastName from Customers as c 
	join Orders as o on c.CustomerID=o.CustomerID 
	join Order_Details as od on o.OrderNumber=od.OrderNumber 
	join Products as p on od.ProductNumber=p.ProductNumber 
	where p.ProductName like '%helmet') as custHelmet 
	join 
	(select distinct(c2.CustomerID) from Customers as c2 
	join Orders as o2 on c2.CustomerID=o2.CustomerID 
	join Order_Details as od2 on o2.OrderNumber=od2.OrderNumber 
	join Products as p2 on od2.ProductNumber=p2.ProductNumber 
	where p2.ProductName like '%bike') as custBike on custBike.customerID= custHelmet.customerid
	)

use EntertainmentAgencyExample

--Q11:List the entertainers who played engagements for both customers Berg and Hallmark.
select custBerg.EntStageName from 
((select distinct(e1.EntertainerID), e1.EntStageName from Entertainers as e1
	join Engagements as eng1 on eng1.EntertainerID=e1.EntertainerID 
	join Customers as c1 on eng1.CustomerID=c1.CustomerID 
	where c1.CustLastName ='Berg') as custBerg
	join
	(select distinct(e2.EntertainerID) from Entertainers as e2 
	join Engagements as eng2 on eng2.EntertainerID=e2.EntertainerID 
	join Customers as c2 on c2.CustomerID=eng2.CustomerID 
	where c2.CustLastName ='Hallmark') as custHallmark
	on custHallmark.EntertainerID=custBerg.EntertainerID)

use SchoolSchedulingExample

--Q12:Show me the students and teachers who have the same first name.
select Students.StudFirstName+' '+Students.StudLastName as StudentFullName, Staff.StfFirstName+' '+Staff.StfLastname as StaffFullName
	from Students join Staff on Students.StudFirstName=Staff.StfFirstName

--below also works but the answer is not complete..
--select StfFirstName from Staff 
--intersect 
--select StudFirstName from Students

use BowlingLeagueExample

--Q13:Find the bowlers who had a raw score of 170 or better at both Thunderbird Lanes and Bolero Lanes.
select thunder.BowlerFirstName, thunder.BowlerLastName from 
((select distinct(b1.BowlerID), b1.BowlerFirstName, b1.BowlerLastName from Bowlers as b1 
join Bowler_Scores as bs1 on bs1.BowlerID=b1.BowlerID 
join Tourney_Matches as tm1 on tm1.MatchID=bs1.MatchID 
join Tournaments as t1 on t1.TourneyID=tm1.TourneyID 
where t1.TourneyLocation = 'Thunderbird Lanes' and bs1.RawScore >= 170) as thunder
join 
(select distinct(b2.BowlerID) from Bowlers as b2 
join Bowler_Scores as bs2 on bs2.BowlerID=b2.BowlerID 
join Tourney_Matches as tm2 on tm2.MatchID=bs2.MatchID 
join Tournaments as t2 on t2.TourneyID=tm2.TourneyID 
where t2.TourneyLocation = 'Bolero Lanes' and bs2.RawScore >= 170) as bolero 
on thunder.BowlerID=bolero.BowlerID)

use RecipesExample

--Q14:Display all the ingredients for recipes that contain carrots.
select finalRecipe.RecipeTitle, finalRecipe.IngredientName from 
((select r1.RecipeID, r1.RecipeTitle, i1.IngredientName from Recipes as r1
	join Recipe_Ingredients as ri1 on ri1.RecipeID=r1.RecipeID 
	join Ingredients as i1 on i1.IngredientID=ri1.IngredientID) as finalRecipe
	join
(select r.RecipeID from Recipes as r 
	join Recipe_Ingredients as ri on ri.RecipeID=r.RecipeID 
	join Ingredients as i on i.IngredientID=ri.IngredientID
	where ri.IngredientID = 6) as carrotRecipe on finalRecipe.RecipeID=carrotRecipe.RecipeID)