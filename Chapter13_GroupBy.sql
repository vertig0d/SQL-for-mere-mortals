use SalesOrdersExample

--Q1:List for each customer and order date the customer full name and the total cost of items ordered on each date.
select c.CustFirstName+','+c.CustLastName as fullName, o.OrderDate, sum(od.QuotedPrice*od.QuantityOrdered) as totCost 
from Customers as c join Orders as o on o.CustomerID=c.CustomerID 
join Order_Details as od on od.OrderNumber=o.OrderNumber group by c.CustFirstName,c.CustLastName,o.OrderDate order by fullName,o.OrderDate 

use EntertainmentAgencyExample

--Q2:Display each entertainment group ID, entertainment group member, 
--and the amount of pay for each member based on the total contract price divided by the number of members in the group.
select e.EntertainerID, m.MbrFirstName, m.MbrLastName, 
sum(eng.ContractPrice)/(select count(*) from Entertainer_Members as em2 where em2.EntertainerID=e.EntertainerID) 
from Entertainers as e 
join Entertainer_Members as em on em.EntertainerID=e.EntertainerID 
join Members as m on m.MemberID=em.MemberID
join Engagements as eng on eng.EntertainerID=e.EntertainerID
group by e.EntertainerID,m.MbrFirstName,m.MbrLastName

use SchoolSchedulingExample

--Q3:For completed classes, list by category and student the category name, the student name, 
--and the student’s average grade of all classes taken in that category.”
select cat.CategoryDescription,s.StudFirstName,s.StudLastName,
avg(ss.Grade) from Students as s 
join Student_Schedules as ss on ss.StudentID=s.StudentID
join Student_Class_Status as scs on scs.ClassStatus=ss.ClassStatus
join Classes as c on c.ClassID=ss.ClassID
join Subjects as subj on subj.SubjectID=c.SubjectID
join Categories as cat on cat.CategoryID=subj.CategoryID
where scs.ClassStatusDescription ='completed'
group by cat.CategoryDescription,s.StudFirstName,s.StudLastName

use BowlingLeagueExample

--Q4:Show me for each tournament and match the tournament ID, the tournament location, 
--the match number, the name of each team, and the total of the handicap score for each team.
select t.TourneyID, t.TourneyLocation, tm.MatchID, teams.TeamName, sum(bs.HandiCapScore) from Tournaments as t
join Tourney_Matches as tm on tm.TourneyID=t.TourneyID
join Bowler_Scores as bs on bs.MatchID=tm.MatchID
join bowlers as b on b.BowlerID=bs.BowlerID
join teams on teams.TeamID=b.TeamID
group by t.TourneyID,t.TourneyLocation, tm.MatchID, teams.TeamName

--Q5:Display the highest raw score for each bowler.
select b.BowlerFirstName,b.BowlerLastName,max(bs.RawScore) from Bowlers as b 
join Bowler_Scores as bs on bs.BowlerID=b.BowlerID
group by b.BowlerFirstName,b.BowlerLastName

use RecipesExample
select * from Ingredient_Classes
select * from Ingredients
--Q6:Show me how many recipes exist for each class of ingredient.
select ig.IngredientClassDescription, count(distinct(ri.RecipeID)) from Ingredient_Classes as ig 
join Ingredients as i on i.IngredientClassID=ig.IngredientClassID
join Recipe_Ingredients as ri on ri.IngredientID=i.IngredientID
group by ig.IngredientClassDescription