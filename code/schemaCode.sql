-- Sabeen

-- Anna

-- Hart

-- Kaden
CREATE TABLE Item (
    ISBN CHAR(13) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    PublicationYear INT NOT NULL,
    PublisherID INT NOT NULL,
    GenreID INT NOT NULL,
    Quantity INT DEFAULT 0,
    AuthorID INT NOT NULL,
    CONSTRAINT fk_publisher FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID),
    CONSTRAINT fk_genre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
    CONSTRAINT fk_author FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

CREATE TABLE Book (
	ItemID INT PRIMARY KEY,
    QuantityAvailable INT NOT NULL,
    CONSTRAINT fk_item FOREIGN KEY (ItemID) REFERENCES Item(ItemID) 
);

CREATE TABLE DigitalMedia (
	ItemID INT PRIMARY KEY, 
	Medium VARCHAR(225) NOT NULL, 
    CONSTRAINT fk_item_digital_media FOREIGN KEY (ItemID) REFERENCES Item(ItemID) 

-- Sriya

-- Audrey
