use SalesOrdersExample

--Q1: What is the inventory value of each product?
select ProductName, RetailPrice * QuantityOnHand as InventoryVal from Products

--Q2: How many days elapsed between order date and ship date for each order?
select ordernumber, cast(datediff(day,Orderdate,ShipDate) as varchar) + 'days' as Elapsed from orders

use EntertainmentAgencyExample

--Q3: How long is each engagement due to run?
select engagementnumber, cast(datediff(day ,startdate, enddate) as varchar) + 'days' as runtime from Engagements

--Q4: What is the net amount for each of our contracts?
select engagementnumber, contractprice, contractprice * 0.12 as ourPrice, 
	contractprice - (contractprice * 0.12) as NetAmount from engagements

use SchoolSchedulingExample

--Q5: List how many complete years each staff member has been with the school as of October 1, 2017, 
--and sort the result by last name and first name.
select StfFirstName, StfLastname, DATEDIFF(day, datehired, cast('2017-10-01' as date))/365 as YearsOfService
from Staff order by StfLastname, StfFirstName

--Q6: Show me a list of staff members, their salaries, and a proposed 7 percent bonus for each staff member
select StfFirstName +' '+ StfLastname as StaffName, Salary, convert(decimal(10,2), (Salary * 0.07)) as ProposedBonus 
from staff order by StfLastname

use BowlingLeagueExample
select * from Bowler_Scores
--Q7: Display a list of all bowlers and addresses formatted suitably for a mailing list, sorted by ZIP Code
select BowlerLastName +','+ BowlerFirstName as BowlerName, BowlerAddress +', '+ BowlerCity +', '+ BowlerState +', '+ BowlerZip as Address 
from Bowlers order by BowlerZip

--Q8: What was the point spread between a bowler’s handicap and raw score for each match and game played?
select BowlerID, MatchID, GameNumber, HandicapScore, RawScore, HandicapScore - RawScore as PointDiff 
from Bowler_Scores order by BowlerID, MatchID, GameNumber