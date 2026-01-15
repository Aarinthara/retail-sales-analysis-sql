/* retail analytics sql case study
   author : aarinthara babu
   database : db_case_study1
   objective : data cleaning and exploratory data analysis
*/



/* section 0 : database setup and data check */

create schema db_case_study1;

use db_case_study1;

select * from customer_profiles;
select * from product_inventory;
select * from sales_transaction;



/* section 1 : removing duplicate transactions
   question 1 : identify duplicate transaction ids
*/

select
    transactionid,
    count(transactionid) as duplicate
from sales_transaction
group by transactionid
having duplicate > 1;



-- removing duplicates

create table sales_transaction2
as
select distinct *
from sales_transaction;

drop table sales_transaction;

alter table sales_transaction2 rename sales_transaction;

select * from sales_transaction;



/* section 2 : fixing incorrect prices
   question 2 : price mismatch between tables
*/

select *
from product_inventory p
inner join sales_transaction s
on p.productid = s.productid
where p.price <> s.price;



update sales_transaction s
inner join product_inventory p
on s.productid = p.productid
set p.price = s.price;



/* section 3 : handling null or missing locations
   question 3 : update missing customer locations
*/

select *
from customer_profiles
where location is null or location = '';



update customer_profiles
set location = 'unknown'
where location is null or location = '';



/* section 4 : date format correction
   question 4 : convert string dates into date format
*/

update customer_profiles
set joindate = str_to_date(joindate,'%d/%m/%y');

alter table customer_profiles
modify column joindate date;



update sales_transaction
set transactiondate = str_to_date(transactiondate,'%d/%m/%y');

alter table sales_transaction
modify column transactiondate date;



/* section 5 : product performance analysis
   question 5 : total units sold and total sales by product
*/

select
    productid,
    sum(quantitypurchased) as totalunitssold,
    round(sum(price * quantitypurchased),2) as totalsales
from sales_transaction
group by productid
order by totalsales desc;



/* section 6 : customer purchase frequency
   question 6 : number of transactions per customer
*/

select
    customerid,
    count(transactionid) as numberoftransactions
from sales_transaction
group by customerid
order by numberoftransactions desc;



/* section 7 : category level analysis
   question 7 : category wise performance
*/

select
    p.category,
    sum(s.quantitypurchased) as totalunitssold,
    round(sum(s.price),2) as totalsales
from sales_transaction s
inner join product_inventory p
on s.productid = p.productid
group by p.category;



/* section 8 : low revenue products
   question 8 : products generating lowest revenue
*/

select
    productid,
    round(sum(price * quantitypurchased),2) as totalrevenue
from sales_transaction
group by productid
order by totalrevenue
limit 10;



/* section 9 : high volume products
   question 9 : products with highest quantity sold
*/

select
    productid,
    sum(quantitypurchased) as totalunitsold
from sales_transaction
group by productid
having totalunitsold >= 1
order by totalunitsold desc
limit 10;



/* section 10 : daily sales trend
   question 10 : sales summary by date
*/

select
    transactiondate,
    count(*) as transactioncount,
    sum(quantitypurchased) as totalunitsold,
    round(sum(quantitypurchased * price),2) as totalsales
from sales_transaction
group by transactiondate
order by transactiondate desc;



/* section 11 : month over month growth
   question 11 : mom sales growth using window function
*/

select
    months,
    totalsales,
    previous_month_sales,
    round(
        (totalsales - previous_month_sales) /
        previous_month_sales * 100,2
    ) as mom_growth_percentage
from
(
    select
        month(transactiondate) as months,
        round(sum(quantitypurchased * price),2) as totalsales,
        lag(round(sum(quantitypurchased * price),2))
        over(order by month(transactiondate)) as previous_month_sales
    from sales_transaction
    group by month(transactiondate)
) t;



/* section 12 : high value customers
   question 12 : customers with high spend and frequency
*/

select
    customerid,
    count(*) as number_of_transactions,
    round(sum(quantitypurchased * price),2) as totalspent
from sales_transaction
group by customerid
having number_of_transactions > 10
   and totalspent > 1000
order by totalspent desc;



/* section 13 : repeat purchase analysis
   question 13 : repeat product purchases by customers
*/

select
    customerid,
    productid,
    count(*) as timespurchased
from sales_transaction
group by customerid, productid
having count(*) > 1
order by timespurchased desc;



/* section 14 : customer purchase cycle
   question 14 : time gap between first and last purchase
*/

select
    customerid,
    min(transactiondate) as firstpurchase,
    max(transactiondate) as lastpurchase,
    datediff(max(transactiondate), min(transactiondate)) as daysbetweenpurchases
from sales_transaction
group by customerid
order by daysbetweenpurchases desc;



/* section 15 : customer segmentation
   question 15 : segment customers based on quantity purchased
*/

select
    customersegment,
    count(*) as numberofcustomers
from
(
    select
        c.customerid,
        case
            when sum(s.quantitypurchased) between 1 and 10 then 'low'
            when sum(s.quantitypurchased) between 11 and 30 then 'mid'
            else 'high'
        end as customersegment
    from customer_profiles c
    inner join sales_transaction s
    on c.customerid = s.customerid
    group by c.customerid
) t
group by customersegment
order by numberofcustomers desc;



/* end of retail analytics sql case study */
