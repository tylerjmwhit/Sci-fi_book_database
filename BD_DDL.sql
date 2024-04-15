USE twhitmar_cs355sp23;

DROP TABLE IF EXISTS BD_Publisher_PhoneNumber;
DROP TABLE IF EXISTS BD_Book_Reader;
DROP TABLE IF EXISTS BD_Award;
DROP TABLE IF EXISTS BD_Review;
DROP TABLE IF EXISTS BD_Book;
DROP TABLE IF EXISTS BD_Reader;
DROP TABLE IF EXISTS BD_Publisher;
DROP TABLE IF EXISTS BD_Author;

-- Table creation
CREATE TABLE BD_Author(
	Name	VARCHAR(255) UNIQUE,
	Email	VARCHAR(320) NOT NULL UNIQUE,
	PRIMARY KEY(Name)
);
    
CREATE TABLE BD_Publisher(
	Name	VARCHAR(255) UNIQUE NOT NULL,
    State	CHAR(2) NOT NULL,
    City	VARCHAR(255) NOT NULL,
    Street	VARCHAR(255) NOT NULL,
    Zip		CHAR(5) NOT NULL,
    PRIMARY KEY(Name)
);

CREATE TABLE BD_Reader(
	Email	VARCHAR(320) UNIQUE,
    Name	VARCHAR(255) NOT NULL,
    PRIMARY KEY(Email)
);

CREATE TABLE BD_Book(
	Title			VARCHAR(255) NOT NULL,
    Author_Name		VARCHAR(255) NOT NULL,
    Genre			VARCHAR(255) NOT NULL,
    Publisher_Name	VARCHAR(255),
    PRIMARY KEY(Title, Author_Name),
    FOREIGN KEY(Author_Name) REFERENCES BD_Author (Name)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(Publisher_Name) REFERENCES BD_Publisher(Name)
		ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE BD_Review(
	Timestamp	TIMESTAMP NOT NULL,
    Email		VARCHAR(255) NOT NULL,
    Title		VARCHAR(255) NOT NULL,
    Author_Name	VARCHAR(255) NOT NULL,
    Rating		NUMERIC(1,0) NOT NULL CHECK (Rating >= 1 AND Rating <=5),
    Review		MEDIUMTEXT,
    PRIMARY KEY(Timestamp, Email, Title, Author_Name),
    FOREIGN KEY(Email) REFERENCES BD_Reader (Email)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(Title, Author_Name) REFERENCES BD_Book (Title, Author_Name)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE BD_Award(
	Name		VARCHAR(255) NOT NULL,
    Title		VARCHAR(255) NOT NULL,
    Author_name	VARCHAR(255) NOT NULL,
    Year		NUMERIC(4,0) CHECK (Year >= 1770 AND Year <=2100),
    Category 	VARCHAR(255),
    PRIMARY KEY (Name, Title, Author_name),
	FOREIGN KEY(Title, Author_Name) REFERENCES BD_Book (Title, Author_Name)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE BD_Book_Reader(
	Email		VARCHAR(320) NOT NULL,
    Title		VARCHAR(255) NOT NULL,
    Author_Name	VARCHAR(255) NOT NULL,
    PRIMARY KEY(Email, Title, Author_Name),
    FOREIGN KEY(Email) REFERENCES BD_Reader	(Email)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(Title, Author_Name) REFERENCES BD_Book (Title, Author_Name)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE BD_Publisher_PhoneNumber(
	Name			VARCHAR(255) NOT NULL,
    Phone_Number	CHAR(12) NOT NULL UNIQUE,
    PRIMARY KEY(Name, Phone_Number),
    FOREIGN KEY(Name) REFERENCES BD_Publisher(Name)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert statements to populate the tables

INSERT INTO BD_Author (Name, Email) VALUES
	('John Doe', 'johndoe@example.com'),
	('Jane Doe', 'janedoe@example.com'),
	('Bob Smith', 'bobsmith@example.com'),
	('Mary Johnson', 'maryjohnson@example.com'),
	('David Lee', 'davidlee@example.com'),
	('Emily Brown', 'emilybrown@example.com'),
	('Mark Davis', 'markdavis@example.com'),
	('Rachel Kim', 'rachelkim@example.com'),
	('Tommy Lee', 'tommylee@example.com'),
	('Samantha Jones', 'samanthajones@example.com'),
	('Andrew Davis', 'andrewdavis@example.com'),
	('Jessica Wang', 'jessicawang@example.com'),
	('Eric Lee', 'ericlee@example.com'),
	('Karen Johnson', 'karenjohnson@example.com'),
	('Steve Smith', 'stevesmith@example.com'),
	('Lisa Kim', 'lisakim@example.com'),
	('Peter Brown', 'peterbrown@example.com'),
	('Julie Davis', 'juliedavis@example.com'),
	('Samuel Lee', 'samuelle@example.com'),
	('Nina Jones', 'ninajones@example.com');
    
INSERT INTO BD_Publisher (Name, State, City, Street, Zip) VALUES
	('Penguin Books', 'NY', 'New York', '1745 Broadway', '10019'),
    ('HarperCollins', 'NY', 'New York', '195 Broadway', '10007'),
    ('Hachette Book Group', 'NY', 'New York', '1290 Avenue of the Americas', '10104'),
    ('Macmillan Publishers', 'NY', 'New York', '120 Broadway', '10271'),
    ('Simon & Schuster', 'NY', 'New York', '1230 Avenue of the Americas', '10020'),
    ('Oxford University Press', 'NY', 'New York', '198 Madison Avenue', '10016'),
    ('Cambridge University Press', 'NY', 'New York', '32 East 57th Street', '10022'),
    ('Taylor & Francis', 'NY', 'New York', '711 Third Avenue', '10017'),
    ('John Wiley & Sons', 'NJ', 'Hoboken', '111 River Street', '07030'),
    ('Pearson Education', 'NJ', 'Upper Saddle River', '100 Route 17', '07458'),
    ('Scholastic Corporation', 'NY', 'New York', '557 Broadway', '10012'),
    ('Bloomsbury Publishing', 'NY', 'New York', '1385 Broadway', '10018'),
    ('Harlequin Enterprises', 'NY', 'New York', '195 Broadway', '10007'),
    ('Elsevier', 'NY', 'New York', '360 Park Avenue South', '10010'),
    ('Wolters Kluwer', 'NY', 'New York', '76 Ninth Avenue', '10011'),
    ('Houghton Mifflin Harcourt', 'MA', 'Boston', '125 High Street', '02110'),
    ('Perseus Books Group', 'NY', 'New York', '245 West 17th Street', '10011'),
    ('Random House', 'NY', 'New York', '1745 Broadway', '10019'),
    ('Little, Brown and Company', 'NY', 'New York', '1290 Avenue of the Americas', '10104'),
    ('Knopf Doubleday Publishing Group', 'NY', 'New York', '1745 Broadway', '10019');
    
INSERT INTO BD_Reader (Email, Name) VALUES
    ('johndoe@example.com', 'John Doe'),
    ('janedoe@example.com', 'Jane Doe'),
    ('bobsmith@example.com', 'Bob Smith'),
    ('maryjohnson@example.com', 'Mary Johnson'),
    ('davidlee@example.com', 'David Lee'),
    ('emilybrown@example.com', 'Emily Brown'),
    ('markdavis@example.com', 'Mark Davis'),
    ('rachelkim@example.com', 'Rachel Kim'),
    ('tommylee@example.com', 'Tommy Lee'),
    ('samanthajones@example.com', 'Samantha Jones'),
    ('alexsmith@example.com', 'Alex Smith'),
    ('lisawang@example.com', 'Lisa Wang'),
    ('kevintan@example.com', 'Kevin Tan'),
    ('annawong@example.com', 'Anna Wong'),
    ('franklinng@example.com', 'Franklin Ng'),
    ('janetliu@example.com', 'Janet Liu'),
    ('danielwu@example.com', 'Daniel Wu'),
    ('olivertan@example.com', 'Oliver Tan'),
    ('stacychen@example.com', 'Stacy Chen'),
    ('harryzhang@example.com', 'Harry Zhang');
    
INSERT INTO BD_Book (Title, Author_Name, Genre, Publisher_Name) VALUES
	('Galactic Empire', 'John Doe', 'Space Opera', 'Random House'),
    ('Time Cruncher', 'John Doe', 'Cyberpunk', 'Random House'),
	('The Last Hope', 'Jane Doe', 'Apocalyptic Science Fiction', 'Penguin Books'),
	('The Mindnet', 'Bob Smith', 'Cyberpunk', 'HarperCollins'),
	('Earth Under Siege', 'Mary Johnson', 'Apocalyptic Science Fiction', 'Perseus Books Group'),
	('The Void', 'David Lee', 'Hard Science Fiction', 'Penguin Books'),
	('Chaos Engine', 'Emily Brown', 'Cyberpunk', 'Random House'),
	('The Rebellion', 'Mark Davis', 'Dystopian Fiction', 'Wolters Kluwer'),
	('Star Command', 'Rachel Kim', 'Military Science Fiction', 'Simon & Schuster'),
	('Echoes from the Future', 'Tommy Lee', 'Hard Science Fiction', 'Penguin Books'),
	('Neon Dreams', 'Samantha Jones', 'Cyberpunk', 'Random House'),
	('Space Odyssey', 'Andrew Davis', 'Space Opera', 'HarperCollins'),
	('The Final Problem', 'Jessica Wang', 'Apocalyptic Science Fiction', 'Penguin Books'),
	('The Last Empire', 'Eric Lee', 'Dystopian Fiction', 'Harlequin Enterprises'),
    ('Sunside Crusie', 'Eric Lee', 'Dystopian Fiction', 'Harlequin Enterprises'),
	('The Singularity', 'Karen Johnson', 'Hard Science Fiction', 'Simon & Schuster'),
	('Machine Wars', 'Steve Smith', 'Military Science Fiction', 'HarperCollins'),
	('City of Neon', 'Lisa Kim', 'Cyberpunk', 'Random House'),
	('The Lost Colony', 'Peter Brown', 'Space Opera', 'Penguin Books'),
	('The Omega Point', 'Julie Davis', 'Hard Science Fiction', 'Simon & Schuster'),
	('Aftermath', 'Samuel Lee', 'Apocalyptic Science Fiction', 'HarperCollins'),
	('Red Planet', 'Nina Jones', 'Dystopian Fiction', 'Penguin Books');
    
INSERT INTO BD_Review (Timestamp, Email, Title, Author_Name, Rating, Review) VALUES 
    ('2023-04-03 10:15:00', 'harryzhang@example.com', 'Galactic Empire', 'John Doe', 4, 'Great book, loved the world-building!'),
    ('2023-04-02 15:30:00', 'rachelkim@example.com', 'The Last Hope', 'Jane Doe', 5, 'Absolutely loved it, the writing was fantastic!'),
    ('2023-04-01 18:45:00', 'davidlee@example.com', 'The Mindnet', 'Bob Smith', 3, 'Interesting story but the characters were a bit flat.'),
    ('2023-03-31 21:00:00', 'olivertan@example.com', 'Earth Under Siege', 'Mary Johnson', 4, 'Enjoyed the themes and the writing style.'),
    ('2023-03-30 12:00:00', 'maryjohnson@example.com', 'The Void', 'David Lee', 5, 'Amazing book, couldn\'t put it down!'),
    ('2023-04-03 10:15:00', 'maryjohnson@example.com', 'Galactic Empire', 'John Doe', 5, 'Great book, loved the world-building!'),
    ('2023-04-02 15:30:00', 'olivertan@example.com', 'The Last Hope', 'Jane Doe', 4, 'Absolutely loved it, the writing was fantastic!'),
    ('2023-04-01 18:45:00', 'davidlee@example.com', 'Machine Wars', 'Steve Smith', 3, 'Interesting story but the characters were a bit flat.'),
    ('2023-03-31 21:00:00', 'davidlee@example.com', 'Aftermath', 'Samuel Lee', 4, 'Enjoyed the themes and the writing style.'),
    ('2023-03-30 12:00:00', 'maryjohnson@example.com', 'Neon Dreams', 'Samantha Jones', 5, 'Amazing book, couldn\'t put it down!');

INSERT INTO BD_Award(Name, Title, Author_name, Year, Category) VALUES
	('Hugo Awards', 'Galactic Empire', 'John Doe', 1980, 'Best Novel'),
    ('Hugo Awards','Sunside Crusie', 'Eric Lee', 2010,'Best Novel'),
	('Nebula Awards', 'The Last Hope', 'Jane Doe', 1995, 'Best Novel'),
	('Arthur C. Clarke Award', 'The Mindnet', 'Bob Smith', 2001, 'Best Science Fiction Novel'),
	('Hugo Awards', 'Earth Under Siege', 'Mary Johnson', 2010, 'Best Novel'),
	('Nebula Awards', 'The Void', 'David Lee', 2005, 'Best Novel'),
	('Philip K. Dick Award', 'Chaos Engine', 'Emily Brown', 2015, 'Best Paperback Original'),
	('Nebula Awards', 'Star Command', 'Rachel Kim', 2021, 'Best Novel'),
	('Arthur C. Clarke Award', 'Echoes from the Future', 'Tommy Lee', 2022, 'Best Science Fiction Novel'),
	('Philip K. Dick Award', 'Neon Dreams', 'Samantha Jones', 2018, 'Best Paperback Original'),
    ('Hugo Awards', 'The Rebellion', 'Mark Davis', 2022, 'Best Novel'),
	('Hugo Awards', 'Chaos Engine', 'Emily Brown', 2021, 'Best Novel'),
	('Locus Awards', 'The Mindnet', 'Bob Smith', 2022, 'Best Science Fiction Novel'),
	('Nebula Awards', 'Echoes from the Future', 'Tommy Lee', 2024, 'Best Science Fiction Novel'),
	('Hugo Awards', 'The Void', 'David Lee', 2022, 'Best Science Fiction Novel'),
	('Locus Awards', 'The Lost Colony', 'Peter Brown', 2023, 'Best Science Fiction Novel'),
	('Hugo Awards', 'The Last Empire', 'Eric Lee', 2021, 'Best Novel'),
    ('Locus Awards', 'The Last Empire', 'Eric Lee', 2021, 'Best Novel'),
	('Nebula Awards', 'The Singularity', 'Karen Johnson', 2022, 'Best Science Fiction Novel');

INSERT INTO BD_Publisher_PhoneNumber(Name, Phone_Number) VALUES
	('Penguin Books', '212-366-2000'),
	('HarperCollins', '212-207-7000'),
	('Hachette Book Group', '212-364-1100'),
	('Macmillan Publishers', '646-307-5151'),
	('Simon & Schuster', '212-698-7000'),
	('Oxford University Press', '212-726-6000'),
	('Cambridge University Press', '212-337-5000'),
	('Taylor & Francis', '212-216-7800'),
	('John Wiley & Sons', '201-748-6000'),
	('Pearson Education', '201-236-7000');
    
INSERT INTO BD_Book_Reader (Email, Title, Author_Name) VALUES
    ('janetliu@example.com', 'Galactic Empire', 'John Doe'),
    ('samanthajones@example.com', 'The Last Hope', 'Jane Doe'),
    ('janetliu@example.com', 'The Mindnet', 'Bob Smith'),
    ('olivertan@example.com', 'Earth Under Siege', 'Mary Johnson'),
    ('stacychen@example.com', 'The Void', 'David Lee'),
    ('emilybrown@example.com', 'Chaos Engine', 'Emily Brown'),
    ('alexsmith@example.com', 'The Rebellion', 'Mark Davis'),
    ('stacychen@example.com', 'Star Command', 'Rachel Kim'),
    ('tommylee@example.com', 'Echoes from the Future', 'Tommy Lee'),
    ('stacychen@example.com', 'Neon Dreams', 'Samantha Jones'),
    ('alexsmith@example.com', 'Space Odyssey', 'Andrew Davis'),
    ('lisawang@example.com', 'The Final Problem', 'Jessica Wang'),
    ('kevintan@example.com', 'The Last Empire', 'Eric Lee'),
    ('annawong@example.com', 'The Singularity', 'Karen Johnson'),
    ('franklinng@example.com', 'Machine Wars', 'Steve Smith'),
    ('janetliu@example.com', 'City of Neon', 'Lisa Kim'),
    ('danielwu@example.com', 'The Lost Colony', 'Peter Brown'),
    ('olivertan@example.com', 'The Omega Point', 'Julie Davis'),
    ('stacychen@example.com', 'Aftermath', 'Samuel Lee'),
    ('harryzhang@example.com', 'Red Planet', 'Nina Jones');











    

