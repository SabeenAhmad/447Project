--6
--Books and DM
SELECT copy.copy_id, Item.title FROM copy
NATURAL JOIN Item 
WHERE status = 'Available'

--Books
SELECT copy.copy_id, Item.title FROM copy
NATURAL JOIN Item 
NATURAL JOIN book
WHERE status = 'Available'

--DM
SELECT copy.copy_id, Item.title FROM copy
NATURAL JOIN Item 
NATURAL JOIN DigitalMedia
WHERE status = 'Available'