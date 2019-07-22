-- SQL Lab 

-- 1.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
    -- 1.1 SELECT
    -- Task – Select all records from the Employee table.
        SELECT * FROM employee; 
    -- Task – Select all records from the Employee table where last name is King.
        SELECT * FROM employee WHERE lastName = 'king'; 
    -- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
        SELECT * FROM employee WHERE firstName = 'andrew' AND reportsto = NULL; 
    -- 1.2 ORDER BY
    -- Task – Select all albums in Album table and sort result set in descending order by title.
        SELECT * FROM album ORDER BY title DESC; 
    -- Task – Select first name from Customer and sort result set in ascending order by city
        SELECT firstName FROM customer ORDER BY city ASC;
    -- 1.3 INSERT INTO
    -- Task – Insert two new records into Genre table
        INSERT INTO genre(genreid, name)
        VALUES (26, 'thriller'),
        (27, 'legend')
        
    -- Task – Insert two new records into Employee table
       INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode, phone, fax, email)
       VALUES (9, 'Kruppa', 'Blake', 'IT Staff', 6, '1994-03-15 00:00:00', '2016-06-10 00:00:00', '666 HellFire Ave', 'Tampa', 'FL', 'USA', '33612', '+1 (720) 342-5539', '+1 (720) 342-5539', 'blake.kruppa@revature.com'), 
       (10, 'Struppa', 'Flake', 'Impersonator', 1, '1994-11-21 00:00:00', '2016-08-04 00:00:00', '69 Troll Boulevards', 'Orlando', 'FL', 'USA', '33612', '+1 (800) 555-5555', '+1 (800) 555-5555', 'flake.struppa@revature.com')
        
    -- Task – Insert two new records into Customer table
        INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode, phone, fax, email, supportrepid)
        VALUES (60, 'Steak', 'Droopa', NULL, '123 Whatever Ave', 'Providence', 'RI', 'USA', 02920, '+1 (401) 123 - 4567', '+1 (401) 123 - 4567', 'steak.droopa@revature.com', 3),
        (61, 'Rake', 'Stoopa', NULL, '321 Something Street', 'Sacramento', 'CA', 'USA', 66666, '+1 (666) 666 - 66666', '+1 (666) 666 - 66666', 'rake.stoopa@revature.com', 4)
        

    -- 1.4 UPDATE
    -- Task – Update Aaron Mitchell in Customer table to Robert Walter
        UPDATE customer
        SET firstname = 'Robert', lastname = 'Walter'
        WHERE customerid = 32;
        
    -- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
        UPDATE artist
        SET name = 'CCR'
        WHERE artistid = 76;
       
    -- 1.5 LIKE
    -- Task – Select all invoices with a billing address like “T%”
        SELECT * FROM invoice
        WHERE billingaddress LIKE 'T%';
        
    -- 1.6 BETWEEN
    -- Task – Select all invoices that have a total between 15 and 50
        SELECT * FROM invoice
        WHERE total BETWEEN 15 AND 50;
        
    -- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
        SELECT * FROM employee
        WHERE hiredate BETWEEN '2003-06-01' AND '2004-03-01';
     -- 1.7 DELETE
    -- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
	DELETE FROM invoiceline
	WHERE invoiceid IN (50,61,116,245,268,290,342);
    	DELETE FROM invoice
		WHERE customerid = 32;

	DELETE FROM customer
		WHERE firstname = 'Robert' AND lastname = 'Walter';
        
-- 2.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
    -- 2.1 System Defined Functions
    -- Task – Use a function that returns the current time.
        SELECT CURRENT_TIMESTAMP;
        
    -- Task – Use a function that returns the length of the name of a mediatype from the mediatype table
        SELECT
	        LENGTH(name)
        FROM
	        mediatype;
        
    -- 2.2 System Defined Aggregate Functions
    -- Task – Use a function that returns the average total of all invoices
        SELECT AVG(total)
	        FROM invoice 
        
    -- Task – Use a function that returns the most expensive track
        SELECT MAX(unitprice) AS MostExpensiveTrack
        FROM track;
        
-- 3.0 JOINS
-- In this section you will be working with [combing] various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
    -- 3.1 INNER
    -- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
        SELECT invoice.invoiceid, customer.firstname
        FROM invoice
        INNER JOIN customer ON invoice.customerid = customer.customerid;
    
    -- 3.2 OUTER
    -- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
        SELECT customer.customerid, customer.firstname, customer.lastname, invoice.invoiceid, invoice.total 
        FROM customer
        FULL OUTER JOIN invoice ON customer.customerid = invoice.customerid;
        
    -- 3.3 RIGHT
    -- Task – Create a right join that joins album and artist specifying artist name and title.
        SELECT album.title, artist.name
        FROM album
        RIGHT JOIN artist ON album.artistid = artist.artistid;
        
    -- 3.4 CROSS
    -- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
        SELECT artist.name, album.title
        FROM album, artist
        ORDER BY artist.name ASC;
        
    -- 3.5 SELF
    -- Task – Perform a self-join on the employee table, joining on the reportsto column.
        SELECT A.lastname AS lastname1, B.lastname AS lastname2, A.reportsto
        FROM employee A, employee B
        WHERE A.employeeid <> B.employeeid
        AND A.reportsto = B.reportsto;
        
        --This returns last names, grouped by their reportsto column.