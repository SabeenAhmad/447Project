-- List All Books and Digital Media with Key Details and Availability
SELECT
    i.Item_ID,
    i.Title,
    i.ISBN,
    i.Publication_Year,
    a.first_name AS Author_First_Name,
    a.last_name AS Author_Last_Name,
    p.Name AS Publisher,
    g.Name AS Genre,
    b.Quantity_Available AS Book_Available,
    d.Quantity_Available AS DigitalMedia_Available,
    d.Medium
FROM Item i
LEFT JOIN Author a ON i.Author_ID = a.Author_ID
LEFT JOIN Publisher p ON i.Publisher_ID = p.Publisher_ID
LEFT JOIN Genre g ON i.Genre_ID = g.Genre_ID
LEFT JOIN Book b ON i.Item_ID = b.Item_ID
LEFT JOIN DigitalMedia d ON i.Item_ID = d.Item_ID;


--Track Desktop Computer Logins:
SELECT 
    ca.Computer_ID,
    ca.User_ID,
    au.First_Name,
    au.Last_Name,
    ca.Login_Time,
    ca.Logout_Time
FROM Computer_Activity ca
JOIN AppUser au ON ca.User_ID = au.User_ID
ORDER BY ca.Login_Time DESC;


--Search both books and items:
SELECT copy.copy_id, Item.title FROM copy
NATURAL JOIN Item 
WHERE status = 'Available'
Search books:
SELECT copy.copy_id, Item.title FROM copy
NATURAL JOIN Item 
NATURAL JOIN book
WHERE status = 'Available'
Search digital media
SELECT copy.copy_id, Item.title FROM copy
NATURAL JOIN Item 
NATURAL JOIN DigitalMedia
WHERE status = 'Available'


--Lists LibraryStaff contact info
SELECT ls.Staff_ID, au.First_Name, au.Last_Name, au.Email, au.Phone_Number, ls.Position_Name, ls.Position_Type, ls.Salary
FROM LibraryStaff ls
JOIN AppUser au ON ls.Staff_ID = au.User_ID;


--Lists books that have NO available copies 
SELECT i.Title, COUNT(c.Copy_ID) AS Total_Copies
FROM Item i
JOIN Copy c ON i.Item_ID = c.Item_ID
GROUP BY i.Title
HAVING SUM(CASE WHEN c.Status = 'Available' THEN 1 ELSE 0 END) = 0;

--This query returns a count of books borrowed by genre in order of decreasing frequency from 4/1/2025 - 4/30/2025. 

SELECT 
    g.Name AS Genre,
    COUNT(*) AS Borrow_Count
FROM 
    Transactions t
JOIN 
    Copy c ON t.Copy_ID = c.Copy_ID
JOIN 
    Item i ON c.Item_ID = i.Item_ID
JOIN 
    Genre g ON i.Genre_ID = g.Genre_ID
WHERE 
    t.Date_CheckOut BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY 
    g.Name
ORDER BY 
    Borrow_Count DESC;


--How many total available items there are in our library
SELECT count(*) AS available_copies FROM copy
WHERE status = 'Available'

--who has an item on hold and what item
SELECT appuser.user_id, first_name,last_name, copy.copy_id, Item.title FROM appuser
JOIN hold on appuser.user_id = hold.user_id
JOIN Copy on copy.copy_id = hold.copy_id
JOIN Item on Item.item_id = copy.item_id
WHERE hold.status = 'Active'


--How many items each user has checked out
SELECT AppUser.user_id, AppUser.first_name, Appuser.last_name, COUNT(*) AS total_checkout FROM transactions
LEFT JOIN AppUser on AppUser.user_id = transactions.user_id
GROUP BY AppUser.user_id, AppUser.first_name, AppUser.last_name
ORDER BY COUNT(*) DESC

--TA QUERIES

--1.Fine calculation by member
SELECT 
    user_id,
    SUM(amount) AS total_fine
FROM 
    Amount
GROUP BY 
    user_id
ORDER BY 
    total_fine DESC;

--2.Book availability–list all available books within a specific genre
SELECT 
    i.Title,
    a.Name AS Author,
    g.Name AS Genre,
    b.Quantity_Available
FROM 
    Book b
JOIN 
    Item i ON b.Item_ID = i.Item_ID
JOIN 
    Genre g ON i.Genre_ID = g.Genre_ID
JOIN 
    Author a ON i.Author_ID = a.Author_ID
WHERE 
    b.Quantity_Available > 0
GROUP BY G.name


--3.Frequent borrowers of a specific genre–identify members who borrowed the most books in a certain genre in the last year
SELECT 
    lm.LibraryMember_ID,
    au.First_Name,
    au.Last_Name,
    COUNT(*) AS Num_Borrowed
FROM 
    Transactions t
JOIN 
    Copy c ON t.Copy_ID = c.Copy_ID
JOIN 
    Item i ON c.Item_ID = i.Item_ID
JOIN 
    Genre g ON i.Genre_ID = g.Genre_ID
JOIN 
    AppUser au ON t.User_ID = au.User_ID
JOIN 
    LibraryMember lm ON au.User_ID = lm.LibraryMember_ID
WHERE 
    g.Name = 'YourGenreHere'
    AND t.Date_CheckOut >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    lm.LibraryMember_ID, au.First_Name, au.Last_Name
ORDER BY 
    Num_Borrowed DESC;

--4.Books due soon: Generate a report of all books due within the next week, sorted by due date.
SELECT 
    i.Title,
    au.First_Name,
    au.Last_Name,
    t.Due_Date,
    t.Date_CheckOut,
    t.Return_Date
FROM 
    Transactions t
JOIN 
    Copy c ON t.Copy_ID = c.Copy_ID
JOIN 
    Item i ON c.Item_ID = i.Item_ID
JOIN 
    AppUser au ON t.User_ID = au.User_ID
WHERE 
    t.Due_Date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
	AND return_date IS NULL
ORDER BY 
    t.Due_Date ASC;


--5.Members with overdue books–list all members who currently have at least one overdue book plus the book titles
select Appuser.user_id, Appuser.first_name, Appuser.last_name, due_date, return_date, title FROM AppUser
NATURAL JOIN transactions
NATURAL JOIN COPY
NATURAL JOIN Item
WHERE return_date is NULL and due_date < '2025-05-02'


--6.Average borrowing time–calculate number of days members borrow for a specific genre
SELECT 
    g.name AS genre_name,
    ROUND(AVG(t.return_date - t.date_checkout), 0) AS avg_borrow_days
FROM 
    Transactions t
JOIN 
    Copy c ON t.copy_id = c.copy_id
JOIN 
    Item i ON c.item_id = i.item_id
JOIN 
    Genre g ON i.genre_id = g.genre_id
WHERE 
    t.return_date IS NOT NULL
GROUP BY 
    g.name
ORDER BY 
    avg_borrow_days DESC;

--7.Most popular author in the last month–find the author whose books have been most borrowed in the last month

SELECT 
    a.first_name,
    a.last_name,
    COUNT(*) AS borrow_count
FROM 
    Transactions t
JOIN 
    Copy c ON t.copy_id = c.copy_id
JOIN 
    Item i ON c.item_id = i.item_id
JOIN 
    Author a ON i.author_id = a.author_id
WHERE 
    t.date_checkout >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY 
    a.first_name, a.last_name
ORDER BY 
    borrow_count DESC
LIMIT 1;

