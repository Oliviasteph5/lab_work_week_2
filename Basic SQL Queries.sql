USE bank;

SELECT * FROM card;

SELECT load_id, account_id
FROM loan ;

SELECT DISTINCT account_id
FROM `order` ;

SELECT AVG(amount)
FROM `order` ;

SELECT MAX(amount), MIN(amount)
FROM loan;

SELECT account_id, amount, status
FROM loan
ORDER BY status ASC;

SELECT account_id, amount, status
FROM loan
ORDER BY status DESC, amount DESC;

SELECT account_id, AVG(amount)
FROM loan
GROUP BY account_id
ORDER BY AVG(amount) DESC;

SELECT account_id, AVG(amount), max(DURATION)
FROM loan
GROUP BY account_id
ORDER BY AVG(amount) DESC;

SELECT account_id, AVG(amount) AS average_amount, max(DURATION) AS duration
FROM loan
GROUP BY account_id
ORDER BY average_amount DESC;

SELECT account_id, amount
FROM loan
WHERE amount > 50000;

SELECT account_id, amount
FROM loan
WHERE amount > 50000
ORDER BY amount ASC;

SELECT account_id, amount
FROM loan
WHERE amount > 50000
ORDER BY amount ASC
LIMIT 5;

SELECT client_id, district_id
FROM client
WHERE district_id = 1;

# Retrieve the top 5 account_ids with the highest average amount ordered, but only including
# orders with amount bigger than 3k

SELECT account_id, AVG(amount) AS average_amount
FROM `order`
WHERE amount > 3000
GROUP BY account_id
ORDER BY average_amount DESC
LIMIT 5;