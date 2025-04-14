-- Sabeen

-- Anna

CREATE TABLE User (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    AddressNumber VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(255) NOT NULL,
);


CREATE TABLE LibraryStaff (
    StaffID INT PRIMARY KEY,
    Salary INT NOT NULL,
    PositionName VARCHAR(255) NOT NULL,
    PositionType VARCHAR(255) NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES User(UserID)
)
    INHERITS(User);


CREATE TABLE SystemAdministrator (
    StaffID INT PRIMARY KEY,
    Managees VARCHAR(255),
    FOREIGN KEY (StaffID) REFERENCES User(UserID)
)
    INHERITS(User);



-- Hart

-- Kaden
CREATE TABLE Item (
    ItemID INT PRIMARY
    ISBN CHAR(13) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    PublicationYear INT NOT NULL,
    PublisherID INT NOT NULL,
    GenreID INT NOT NULL,
    Quantity INT DEFAULT 0,
    AuthorID INT NOT NULL,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

CREATE TABLE Book (
	ItemID INT PRIMARY KEY,
    QuantityAvailable INT NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID) 
)
    INHERITS(Item);

CREATE TABLE DigitalMedia (
	ItemID INT PRIMARY KEY, 
	Medium VARCHAR(225) NOT NULL, 
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
)
    INHERITS(Item);

-- Sriya

--Library Member
CREATE TABLE LibraryMember (
    LibraryMemberID INT PRIMARY KEY,
    ItemsCheckoutOut INT NOT NULL,
    DateJoined DATE NOT NULL,
    OutstandingBalance DECIMAL(5,2) DEFAULT 0.00 NOT NULL CHECK(OutstandingBalance >= 0),
    Sex CHAR(1) NOT NULL CHECK (Sex IN ('M','F','O')),
    DOB DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY(LibraryMemberID) REFERENCES User(UserID) 
)
    INHERITS(User);
--Report
CREATE TABLE Report (
    ReportID INT PRIMARY KEY,
    StaffID INT NOT NULL,
    BorrowingTrends VARCHAR(255) NOT NULL,
    NumberOfCheckouts INT NOT NULL,
    Date DATE NOT NULL,
    TimePeriod VARCHAR(50) NOT NULL,
    FOREIGN KEY (StaffID) REFERENCES LibraryStaff(StaffID)
);

--Amount
CREATE TABLE Amount (
    FineID SERIAL INT PRIMARY KEY,
    UserID INT NOT NULL,
    ItemID INT NOT NULL,
    Amount DECIMAL(5,2) NOT NULL CHECK (Amount >= 0),
    TransactionID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID),
    FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID)
);

-- Audrey

--Copy
CREATE TABLE Copy(
    CopyID INT PRIMARY KEY,
    ItemID INT NOT NULL,
    Status VARCHAR(255) NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
)
--Transaction
CREATE TABLE Transaction(
    TransactionID INT PRIMARY KEY,
    CopyID INT NOT NULL,
    UserID INT NOT NULL,
    DateCheckOut DATE NOT NULL,
    DueDate DATE NOT NULL,
    NumRenewals INT NOT NULL,
    ReturnDate DATE NOT NULL
    FOREIGN KEY (CopyID) REFERENCES Copy(CopyID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
)
--Hold
CREATE TABLE Hold(
    HoldID INT PRIMARY KEY,
    CopyID INT NOT NULL,
    HoldDate DATE NOT NULL,
    ExpirationDate DATE NOT NULL,
    Status VARCHAR(255) NOT NULL,
    FOREIGN KEY (CopyID) REFERENCES Copy(CopyID)

)
--Publisher
CREATE TABLE Publisher(
    PublisherID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
)
--Author
CREATE TABLE Author(
    AuthorID INT PRIMARY KEY,
    Name VarCHAR(255) NOT NULL
)
--genre
CREATE TABLE Genre(
    GenreID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
)


--INSERTING DATA

--Inserting into User
INSERT INTO User(UserID, FirstName, LastName, Email, Address, PhoneNumber) VALUES
(1, 'Bryan', 'Johnson', 'anthony64@mcdowell.com', '09428 Hernandez Locks Suite 380, East Barryshire, MS 80347', '(001)073-0354'),
(2, 'Vickie', 'Allison', 'tonya51@yahoo.com', '1735 Jason Ports, Greenshire, DE 41204', '(196)800-9762'),
(3, 'Joshua', 'Williams', 'sharonperez@larson-hamilton.com', '1008 Jennings Light Suite 703, New Elizabethhaven, WV 05988', '(871)988-8590'),
(4, 'Benjamin', 'Gallagher', 'johnsonbrandy@welch.com', 'PSC 7679, Box 9996, APO AE 59534', '(001)188-9925'),
(5, 'Robert', 'Jefferson', 'wallacedebra@yahoo.com', '2899 Martin Street Apt. 876, Jacobfort, ME 07346', '(131)263-6589'),
(6, 'Anna', 'Howe', 'laurawilcox@hotmail.com', '1673 Ashley Fall, North Taraland, MS 15318', '(212)617-5770'),
(7, 'Gabriel', 'Black', 'sean27@yahoo.com', '2614 Ann Gateway Suite 485, East Allenville, IL 35120', '(144)909-7517'),
(8, 'Amber', 'Thomas', 'vcook@yahoo.com', '90378 Roy Greens, Haroldberg, NY 34011', '(001)192-9224'),
(9, 'Beverly', 'Jones', 'joshuahart@gmail.com', '221 Alyssa Rapid Apt. 302, South Travis, MI 72344', '(194)708-3783'),
(10, 'Jonathan', 'Thompson', 'donna98@dixon.com', '48415 Jennifer Crossing, Port Kristineton, OR 09295', '(794)195-2477'),
(11, 'Joyce', 'Dickson', 'montgomeryanthony@frazier.com', '8682 Jones Village Apt. 559, Port Lindsey, ID 01406', '(439)072-1907'),
(12, 'Joseph', 'King', 'darren83@rodriguez.org', '5743 Mack Terrace Suite 891, South Ryanburgh, SC 59556', '(798)995-6841'),
(13, 'Douglas', 'Burns', 'jo60@alexander.org', '78930 Sanchez Village, South Patriciaburgh, KS 37560', '(641)905-9136'),
(14, 'Derek', 'White', 'gbaker@davis.com', '62075 Erik Glen, Kevinburgh, LA 40873', '(245)841-8225'),
(15, 'Scott', 'Martin', 'tiffany21@hotmail.com', '861 Justin Heights Suite 264, Port Madisonberg, AL 10289', '(994)434-7998'),
(16, 'Ann', 'Carroll', 'manntrevor@hotmail.com', 'Unit 3205 Box 3013, DPO AE 14060', '(142)637-1125'),
(17, 'Brent', 'Becker', 'chelsea16@jackson.com', '543 Patrick Spur Apt. 451, Richborough, GA 85017', '(487)280-7451'),
(18, 'Robert', 'Gomez', 'susanbutler@gmail.com', '289 Jones Ford, Aliciabury, MI 49837', '(554)305-5351'),
(19, 'Paul', 'Campbell', 'angela53@cunningham.com', '9964 Brandon Street Suite 672, North Kaylamouth, AR 19629', '(005)179-2076'),
(20, 'Michael', 'Fuentes', 'watsonmelissa@yahoo.com', '5963 Rogers Drive Suite 439, Fischerport, CA 97120', '(128)003-2808'),
(21, 'Travis', 'Spencer', 'jeffrey96@moreno.com', '3033 Gonzalez Mission Apt. 272, Moralesshire, TN 35215', '(101)328-0151'),
(22, 'James', 'Obrien', 'dawn20@yahoo.com', '74597 Reyes Streets Suite 487, Bartlettville, TX 86404', '(121)096-6705'),
(23, 'Kristen', 'Hansen', 'ohopkins@yahoo.com', 'Unit 3379 Box 1123, DPO AA 73445', '(863)218-7605'),
(24, 'Melody', 'Bennett', 'avilajimmy@duncan.org', '874 Cruz Spurs Suite 081, North James, NY 79680', '(979)675-1602'),
(25, 'Nicholas', 'Stone', 'strongsonya@yahoo.com', '863 Amanda Streets, Rhondastad, AR 44228', '(519)923-3729'),
(26, 'Sandy', 'Perez', 'donnacross@gmail.com', 'Unit 9701 Box 5599, DPO AE 75478', '(001)393-7688'),
(27, 'Clifford', 'Williams', 'scottjohn@white.net', '19991 Fry Fords Suite 808, Pinedaberg, AL 21741', '(235)471-1233'),
(28, 'Zachary', 'Serrano', 'austinjimenez@gmail.com', '99923 Taylor Field, New Angela, RI 26549', '(125)619-4215'),
(29, 'Michael', 'Lopez', 'mirandaedwards@whitehead-santos.com', '778 Ronald Meadow Suite 788, Nicholasville, KS 67551', '(151)072-5360'),
(30, 'William', 'Thomas', 'patriciakeller@moore.com', '0613 Johnson Knoll, Martinport, NE 98815', '(104)125-0284'),
(31, 'Monique', 'Tate', 'hrivera@hotmail.com', 'Unit 4425 Box 7274, DPO AP 41523', '(149)026-7522'),
(32, 'Nicole', 'Anderson', 'fsummers@ortiz.com', '66737 Matthew Passage, Adamsside, WV 33669', '(122)090-9087'),
(33, 'Samantha', 'Gonzalez', 'bradybryan@lee.org', '276 Brian Well Suite 866, East Victor, NM 33323', '(330)015-6061'),
(34, 'Samuel', 'Carter', 'vsuarez@ware.com', '71936 Anderson Harbors, New Karen, MS 75254', '(001)468-5784'),
(35, 'Renee', 'Mooney', 'stewartdarren@young-morales.com', '4063 Price Fort, Lake Alexandria, OK 95742', '(027)173-7941'),
(36, 'William', 'Raymond', 'justinflores@gmail.com', '52430 Farrell Parkway, North Carl, WA 50849', '(331)495-4705'),
(37, 'Michael', 'Hernandez', 'timothy70@yahoo.com', '3374 Williams Parkways, Lake Richardport, WA 80949', '(628)142-7721'),
(38, 'Melinda', 'Lewis', 'bruce59@hotmail.com', '534 Potter Burgs, Lake Karishire, IL 25022', '(644)383-2607'),
(39, 'Debra', 'Sanders', 'melanie34@hernandez-castro.info', '37278 Christine Roads Suite 421, Justinport, AK 31314', '(077)699-8082'),
(40, 'Hannah', 'Smith', 'ghernandez@gmail.com', '62166 Andrea Corner Apt. 441, East Alexanderbury, VT 66659', '(109)100-5264'),
(41, 'Kevin', 'Mooney', 'bishopsuzanne@hotmail.com', '133 Eric Harbor Apt. 685, Burgessbury, ID 21578', '(865)383-7249'),
(42, 'Amy', 'Thompson', 'adriandelacruz@yahoo.com', '94859 Michael Run Suite 274, Jordanview, DE 13706', '(138)382-5941'),
(43, 'Scott', 'Sanders', 'johnsonnathaniel@bass.com', 'USS Jimenez, FPO AA 97111', '(184)564-2522'),
(44, 'Ryan', 'Hopkins', 'heather03@gmail.com', 'Unit 8630 Box 1986, DPO AA 30671', '(001)667-5088'),
(45, 'Alex', 'Anderson', 'zmiller@yahoo.com', '56965 Harding Camp Apt. 089, Port Kevinport, NC 27476', '(353)338-1584'),
(46, 'Nicole', 'Rivera', 'tiffanyadams@yahoo.com', '0920 Lewis Plaza, Port Steven, MT 83560', '(001)714-3366'),
(47, 'Jodi', 'Ponce', 'steveharris@yahoo.com', '0349 Raymond Junction, Mahoneyberg, MO 30860', '(183)808-8361'),
(48, 'Gary', 'Sanchez', 'michael23@lewis.com', '52021 Jeremy Ville, New Sharonmouth, NM 97797', '(014)034-6714'),
(49, 'Gerald', 'Ortiz', 'scarroll@hotmail.com', 'PSC 2980, Box 2727, APO AP 62516', '(162)523-1374'),
(50, 'Mark', 'Wolfe', 'monica71@hotmail.com', '5384 Patel Trail, West Kimberlyberg, MS 19373', '(349)979-2273'),
(51, 'Nicholas', 'Sutton', 'danielmiller@donovan.net', '6473 Moyer Wells, Annmouth, OH 47661', '(186)688-0972'),
(52, 'Mary', 'Miller', 'jillianfrancis@hotmail.com', '35083 Matthew Avenue Suite 635, Christinechester, GA 29099', '(818)094-1714'),
(53, 'Jeffrey', 'Farmer', 'jacobjohnson@hoffman.org', '040 Brenda Road, Garciaberg, OR 30735', '(345)323-5608'),
(54, 'Sean', 'Downs', 'ebrewer@yahoo.com', '4996 Mccullough Park Apt. 938, Port Frank, DE 66818', '(001)844-3137'),
(55, 'Laura', 'Perry', 'kristataylor@martinez.com', 'Unit 0240 Box 5152, DPO AP 66958', '(053)094-1726'),
(56, 'Matthew', 'Guerrero', 'mary78@briggs-clark.com', '703 Fleming Brooks, South Jasonmouth, NH 12879', '(193)138-8576'),
(57, 'Rebecca', 'Simon', 'calderonjeffrey@lee.com', '3398 Michael Isle Suite 155, Scottmouth, OH 49218', '(001)447-9304'),
(58, 'Benjamin', 'Peterson', 'jrose@moore.com', '242 Patrick Expressway Suite 071, North Michealbury, NY 41010', '(990)171-6825'),
(59, 'Johnathan', 'Long', 'joycejessica@hancock.com', '458 Monica Shores, Frostfurt, CA 10888', '(473)430-7118'),
(60, 'Jeremy', 'Dorsey', 'shieldsclaudia@smith.com', '7901 Wagner Villages, Alexanderside, MT 90789', '(420)619-9462'),
(61, 'Anthony', 'Hernandez', 'scottwilson@phillips-shelton.com', '5091 Dominguez Estate Apt. 338, South Brandonland, MI 31076', '(190)928-3819'),
(62, 'Jose', 'Silva', 'jennifer71@gmail.com', '728 Yang Ranch, South Shannonhaven, TX 36158', '(165)422-6748'),
(63, 'Karen', 'Lynn', 'johnhenderson@hotmail.com', '599 Ashley Flat Apt. 718, West Sean, WV 07171', '(146)402-0324'),
(64, 'Richard', 'Gardner', 'janiceadams@garcia.info', '6091 Ross Fork, New Fernandoborough, WA 13142', '(556)327-2086'),
(65, 'Robert', 'Reid', 'rodriguezbrandi@jones-wade.com', '345 Sanchez Passage, Haydenton, OK 06693', '(481)022-8034'),
(66, 'Brian', 'Harris', 'wwest@hawkins.com', '747 Olson Plains Apt. 732, Walkerhaven, WV 33952', '(506)056-6905'),
(67, 'Danielle', 'Nolan', 'maria69@miller.net', '191 Victoria Unions, Grahamview, MN 03207', '(130)941-6946');

--INSERT LibraryMember
INSERT INTO LibraryMember(LibraryMemberID, ItemsCheckoutOut, DateJoined, OutstandingBalance, Sex, DOB, Status) VALUES
(21, 5, '2021-07-30', 0.0, 'M', '1988-05-31', 'Active'),
(61, 3, '2025-02-25', 0.0, 'M', '1988-08-09', 'Active'),
(65, 4, '2021-07-18', 0.0, 'M', '1949-05-26', 'Active'),
(41, 2, '2022-07-01', 0.0, 'O', '1985-06-26', 'Active'),
(48, 5, '2024-03-05', 0.0, 'O', '1941-01-15', 'Active'),
(16, 5, '2020-04-17', 0.0, 'M', '1967-02-23', 'Active'),
(47, 2, '2023-04-20', 0.0, 'M', '1942-06-17', 'Active'),
(8, 4, '2020-09-26', 0.0, 'O', '1979-01-30', 'Active'),
(58, 2, '2021-08-08', 0.0, 'M', '1977-01-07', 'Active'),
(24, 3, '2020-05-03', 2.85, 'F', '1965-02-13', 'Active'),
(49, 0, '2024-07-25', 0.0, 'F', '1962-03-21', 'Active'),
(7, 0, '2022-03-28', 0.0, 'O', '2013-05-24', 'Active'),
(38, 3, '2025-02-22', 19.41, 'M', '1971-07-06', 'Suspended'),
(17, 1, '2024-07-11', 0.0, 'F', '1947-05-19', 'Active'),
(66, 4, '2020-06-25', 0.0, 'F', '2003-11-13', 'Active'),
(44, 3, '2024-07-24', 0.0, 'F', '1959-12-23', 'Active'),
(2, 1, '2020-10-07', 0.0, 'M', '1951-02-01', 'Active'),
(33, 2, '2020-08-16', 0.0, 'O', '1988-05-16', 'Active'),
(6, 1, '2021-05-10', 0.0, 'M', '1979-06-26', 'Active'),
(36, 2, '2025-03-16', 0.0, 'O', '1985-03-24', 'Active'),
(3, 3, '2023-06-16', 0.0, 'F', '1969-10-18', 'Active'),
(12, 0, '2022-12-21', 0.0, 'O', '1960-10-18', 'Active'),
(1, 5, '2022-09-13', 0.0, 'M', '1945-03-01', 'Active'),
(31, 2, '2024-09-01', 0.0, 'F', '2001-04-01', 'Active'),
(27, 0, '2024-06-15', 0.0, 'F', '1988-03-18', 'Active'),
(28, 4, '2024-05-26', 0.0, 'F', '1997-08-14', 'Active'),
(5, 4, '2022-01-15', 0.0, 'M', '1958-07-25', 'Active'),
(52, 0, '2022-02-23', 28.07, 'M', '1951-09-08', 'Suspended'),
(23, 5, '2025-03-16', 0.0, 'O', '1942-11-12', 'Active'),
(20, 0, '2024-03-07', 0.0, 'F', '1989-09-13', 'Active'),
(40, 1, '2021-10-11', 0.0, 'O', '1941-12-09', 'Active'),
(43, 4, '2023-10-25', 0.0, 'F', '1959-08-21', 'Active'),
(59, 2, '2024-02-23', 0.0, 'O', '1964-09-17', 'Active'),
(50, 0, '2023-01-25', 0.0, 'M', '1994-04-13', 'Active'),
(26, 5, '2021-07-11', 0.0, 'M', '1978-08-02', 'Active'),
(64, 2, '2020-06-24', 0.0, 'M', '1955-05-17', 'Active'),
(19, 1, '2020-06-08', 0.0, 'M', '1976-12-02', 'Active'),
(37, 3, '2024-05-20', 25.07, 'F', '2003-01-27', 'Suspended'),
(35, 2, '2024-04-29', 0.0, 'M', '1938-02-05', 'Active'),
(9, 3, '2024-05-07', 0.0, 'O', '1974-03-03', 'Active'),
(14, 4, '2022-12-14', 0.0, 'M', '1960-05-07', 'Active'),
(10, 4, '2021-08-25', 0.0, 'O', '1952-09-04', 'Active'),
(46, 3, '2021-01-31', 0.0, 'O', '1972-07-08', 'Active'),
(4, 5, '2023-07-12', 0.0, 'F', '1944-06-26', 'Active'),
(22, 3, '2024-03-16', 0.0, 'F', '1982-02-22', 'Active'),
(60, 4, '2024-03-01', 0.0, 'F', '1959-10-20', 'Active'),
(54, 0, '2020-10-25', 0.0, 'M', '1957-03-18', 'Active'),
(56, 0, '2021-12-04', 0.0, 'M', '1940-06-24', 'Active'),
(13, 3, '2023-12-02', 0.0, 'M', '2013-10-16', 'Active'),
(15, 1, '2023-02-28', 39.31, 'M', '2012-05-19', 'Suspended'),
(53, 2, '2021-11-07', 0.0, 'M', '2008-04-30', 'Active'),
(63, 2, '2020-09-01', 0.0, 'M', '1949-01-01', 'Active'),
(29, 0, '2025-04-03', 33.94, 'M', '1935-09-17', 'Suspended'),
(32, 3, '2021-01-17', 10.14, 'M', '2006-08-21', 'Active'),
(25, 1, '2024-05-08', 0.0, 'F', '1959-11-19', 'Active'),
(62, 1, '2023-11-21', 0.0, 'O', '2013-03-06', 'Active'),
(30, 5, '2024-12-02', 0.0, 'M', '1948-10-01', 'Active'),
(45, 3, '2023-03-20', 0.0, 'O', '1981-11-07', 'Active'),
(42, 3, '2023-02-16', 0.0, 'O', '2002-07-14', 'Active'),
(57, 4, '2021-07-26', 20.92, 'M', '1971-10-08', 'Suspended'),
(55, 3, '2024-01-16', 0.0, 'O', '1956-10-01', 'Active'),
(51, 4, '2023-02-18', 13.21, 'O', '2007-04-23', 'Active'),
(11, 0, '2022-02-03', 36.57, 'M', '1934-05-20', 'Suspended');

--INSERT Library Staff
INSERT INTO LibraryStaff(StaffID, Salary, PositionName, PositionType) VALUES
(39, 44730, 'Librarian', 'Full-Time'),
(67, 39440, 'Technician', 'Part-Time'),
(34, 48364, 'Archivist', 'Full-Time');

--INSERT library Admin
INSERT INTO SystemAdministrator(StaffID, Managees) VALUES
(18, NULL);
