use SalesOrdersExample

--Q1:Find all the customers who ordered a bicycle and also ordered a helmet.
select distinct(c.CustomerID), c.CustFirstName, c.CustLastName from customers as c join 
(select c1.CustomerID from customers as c1 join 
  orders as o1 on o1.CustomerID=c1.CustomerID join 
  Order_Details as od1 on od1.OrderNumber=o1.OrderNumber join 
  Products as p1 on p1.ProductNumber=od1.ProductNumber where p1.ProductName like '%bike'
) as bikeCust on bikeCust.CustomerID=c.CustomerID join 
(select c1.CustomerID from customers as c1 join 
  orders as o1 on o1.CustomerID=c1.CustomerID join 
  Order_Details as od1 on od1.OrderNumber=o1.OrderNumber join 
  Products as p1 on p1.ProductNumber=od1.ProductNumber where p1.ProductName like '%helmet'
) as helmCust on helmCust.CustomerID=c.CustomerID

--Solving the above using exist
select c.CustomerID,c.CustFirstName, c.CustLastName from customers as c where exists
(select * from Orders o1 join 
 Order_Details as od1 on od1.OrderNumber=o1.OrderNumber join 
 Products as p1 on p1.ProductNumber=od1.ProductNumber
 where o1.CustomerID=c.CustomerID and ProductName like '%bike'
) and exists
(select * from Orders o1 join 
 Order_Details as od1 on od1.OrderNumber=o1.OrderNumber join 
 Products as p1 on p1.ProductNumber=od1.ProductNumber
 where o1.CustomerID=c.CustomerID and ProductName like '%helmet'
)


--Q2:Find all the customers who have not ordered either bikes or tires.
select c.CustomerID,c.CustFirstName,c.CustLastName from Customers as c where c.CustomerID not in 
(select o1.CustomerID from Orders as o1 join 
 Order_Details as od1 on od1.OrderNumber=o1.OrderNumber join 
 Products as p1 on p1.ProductNumber=od1.ProductNumber
 where p1.ProductName like '%bike')
 and  c.CustomerID not in
 (select o1.CustomerID from Orders as o1 join 
 Order_Details as od1 on od1.OrderNumber=o1.OrderNumber join 
 Products as p1 on p1.ProductNumber=od1.ProductNumber
 where p1.ProductName like '%tires')
 
use EntertainmentAgencyExample

 --Q3:List the entertainers who played engagements for customers Berg and Hallmark.
 select ent.EntertainerID, ent.EntStageName from Entertainers as ent where ent.EntertainerID in 
 (select eng1.EntertainerID from Engagements as eng1 join 
 Customers as c1 on c1.CustomerID=eng1.CustomerID
 where c1.CustLastName = 'Berg' and ent.EntertainerID=eng1.EntertainerID
 ) and ent.EntertainerID in 
 (select eng1.EntertainerID from Engagements as eng1 join 
 Customers as c1 on c1.CustomerID=eng1.CustomerID
 where c1.CustLastName = 'Hallmark' and ent.EntertainerID=eng1.EntertainerID
 )

--Solving above using EXISTS
select ent.EntertainerID, ent.EntStageName from Entertainers as ent where exists 
 (select * from Engagements as eng1 join 
 Customers as c1 on c1.CustomerID=eng1.CustomerID
 where c1.CustLastName='Berg' and ent.EntertainerID = eng1.EntertainerID
 ) and exists 
 (select * from Engagements as eng2 join 
 Customers as c2 on c2.CustomerID=eng2.CustomerID
 where c2.CustLastName='Hallmark' and eng2.EntertainerID=ent.EntertainerID
 )

 --Q4:Display agents who have never booked a Country or Country Rock group.
 select agnt.AgentID, agnt.AgtFirstName, agnt.AgtLastName from agents as agnt where agnt.AgentID not in 
 (select eng.AgentID from Engagements as eng join
  Entertainer_Styles as entstyl on entstyl.EntertainerID=eng.EntertainerID join 
  Musical_Styles as musicstyl on musicstyl.StyleID=entstyl.StyleID
  where musicstyl.StyleName in ('Country','Country Rock')
 )

use schoolschedulingexample
select * from Student_Schedules
select * from Classes
select * from subjects
select * from Categories
--Q5:List students who have a grade of 85 or better in both art and computer science
select stud.StudentID, stud.StudFirstName, stud.StudLastName from Students as stud where stud.StudentID in 
(select studsched1.StudentID from Student_Schedules as studsched1 join
 Classes as cls1 on cls1.ClassID=studsched1.ClassID join 
 Subjects as subj1 on subj1.SubjectID=cls1.SubjectID join 
 Categories as cat1 on cat1.CategoryID=subj1.CategoryID where cat1.CategoryDescription = 'Art' and studsched1.Grade >= 85
) and stud.StudentID in
(select studsched1.StudentID from Student_Schedules as studsched1 join
 Classes as cls1 on cls1.ClassID=studsched1.ClassID join 
 Subjects as subj1 on subj1.SubjectID=cls1.SubjectID join 
 Categories as cat1 on cat1.CategoryID=subj1.CategoryID where cat1.CategoryDescription like '%Computer%' and studsched1.Grade >= 85
)

