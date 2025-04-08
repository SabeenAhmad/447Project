-- Sabeen

-- Anna

-- Hart

-- Kaden

-- Sriya
--Library Member
CREATE TABLE LibraryMember (
    LibraryMemberID INT PRIMARY KEY,
    ItemsCheckoutOut INT NOT NULL,
    DateJoined DATE NOT NULL,
    OutstandingBalance DECIMAL(5,2) DEFAULT 0.00 NOT NULL,
    Sex CHAR(1) NOT NULL,
    DOB DATE NOT NULL,
    Status VARCHAR(20) NOT NULL
);
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