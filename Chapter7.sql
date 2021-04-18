use SalesOrdersExample
select * from Order_Details
--Example1:Show me the orders that contain both a bike and a helmet.
select distinct(OrderNumber) from Order_Details where ProductNumber in (1,2,6,11)
intersect 
select distinct(OrderNumber) from Order_Details where ProductNumber in (10,25,26)

--Eg2:Show me the orders that contain a bike but not a helmet.
select distinct(OrderNumber) from Order_Details where ProductNumber in (1,2,6,11)
EXCEPT
select distinct(orderNumber) from Order_Details where ProductNumber in (10,25,26)

--Eg3:Show me the orders that contain either a bike or a helmet.
select distinct(OrderNumber) from Order_Details where ProductNumber in (1,2,6,11,10,25,26)
--same as below
select distinct(OrderNumber) from Order_Details where ProductNumber in (1,2,6,11)
union
select distinct(OrderNumber) from Order_Details where ProductNumber in (10,25,26)
