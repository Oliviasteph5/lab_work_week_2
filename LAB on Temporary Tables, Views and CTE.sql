 USE sakila;


#Step1 Create a View
#First, create a view that summarizes rental information for each customer. 
#The view should include the customer's ID, name, email address, and total number of rentals (rental_count).

CREATE VIEW cust_rental_info AS
SELECT customer.customer_id, first_name, last_name, email, COUNT(rental_id) AS rental_count
FROM customer  
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer_id, first_name, last_name, email;

SELECT * FROM cust_rental_info;

#Step 2: Create a Temporary Table
#Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
#The Temporary Table should use the rental summary view 
#created in Step 1 to join with the payment table and calculate the total amount paid by each customer.

CREATE TEMPORARY TABLE temp_cust_pmt_summary AS
SELECT cust_rental_info.customer_id, SUM(payment.amount) AS total_paid
FROM cust_rental_info
INNER JOIN payment ON cust_rental_info.customer_id = payment.customer_id
GROUP BY cust_rental_info.customer_id;

SELECT * FROM temp_cust_pmt_summary;

#Step 3: Create a CTE and the Customer Summary Report
#Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2.
#The CTE should include the customer's name, email address, rental count, and total amount paid.
#Next, using the CTE, create the query to generate the final customer summary report, 
#which should include: customer name, email, rental_count, total_paid and average_payment_per_rental, 
#this last column is a derived column from total_paid and rental_count.

WITH CustomerSummaryReportCTE AS (
    SELECT cust_rental_info.customer_id, cust_rental_info.first_name, cust_rental_info.last_name, cust_rental_info.email, cust_rental_info.rental_count, temp_cust_pmt_summary.total_paid
    FROM cust_rental_info
    INNER JOIN temp_cust_pmt_summary ON cust_rental_info.customer_id = temp_cust_pmt_summary.customer_id
)

 #In order to generate the final customer summary, join the rental info view with the payment summary temporary table.
 #The final query selects the necessary columns for the final customer summary report 
 #and the derived column for the avergae payment per rental.

SELECT customer_id, CONCAT(first_name, ' ', last_name) AS customer_name, email, rental_count, total_paid, ROUND(total_paid / rental_count, 1) AS avg_pmt_per_rental
FROM CustomerSummaryReportCTE;

