
   /*CREATE DATABASE*/
   

CREATE DATABASE RaceEventManagementDB;
GO

USE RaceEventManagementDB;
GO



   /*CREATE TABLE: UserProfile*/
   

CREATE TABLE UserProfile
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    EmailAddress VARCHAR(150) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    UserRole VARCHAR(50) NOT NULL
);
GO



   /*CREATE TABLE: Organiser
   One UserProfile can be associated with one Organiser record*/


CREATE TABLE Organiser
(
    OrganiserId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL UNIQUE,
    Department VARCHAR(100) NOT NULL,
    UserImage VARCHAR(255) NULL,

    CONSTRAINT FK_Organiser_UserProfile
        FOREIGN KEY (UserId)
        REFERENCES UserProfile(UserId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO



   /*CREATE TABLE: Participant
   One UserProfile can be associated with one Participant record*/
   

CREATE TABLE Participant
(
    ParticipantId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL UNIQUE,
    Height DECIMAL(5,2) NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    FirstTimeParticipant BIT NOT NULL,
    Age INT NOT NULL,

    CONSTRAINT FK_Participant_UserProfile
        FOREIGN KEY (UserId)
        REFERENCES UserProfile(UserId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT CHK_Participant_Age
        CHECK (Age > 0),

    CONSTRAINT CHK_Participant_Height
        CHECK (Height > 0)
);
GO



    /*Category Table */


CREATE TABLE Category
(
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryDescription VARCHAR(150) NOT NULL,
    Details VARCHAR(255) NULL,
    Age INT NOT NULL,

    CONSTRAINT CHK_Category_Age
        CHECK (Age > 0)
);
GO



   /*CREATE TABLE: RaceEvent
   Many RaceEvents belong to one Category*/

CREATE TABLE RaceEvent
(
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId INT NOT NULL,
    RaceDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    RaceName VARCHAR(150) NOT NULL,
    RaceDetails VARCHAR(500) NULL,
    EnrolmentClosingDate DATE NOT NULL,

    CONSTRAINT FK_RaceEvent_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT CHK_EnrolmentClosingDate
        CHECK (EnrolmentClosingDate <= RaceDate)
);
GO


 
  /* CREATE TABLE: Enrolment
   Links UserProfile and RaceEvent  */
   

CREATE TABLE Enrolment
(
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    EventId INT NOT NULL,

    CONSTRAINT FK_Enrolment_UserProfile
        FOREIGN KEY (UserId)
        REFERENCES UserProfile(UserId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Enrolment_RaceEvent
        FOREIGN KEY (EventId)
        REFERENCES RaceEvent(EventId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- Prevent the same participant from enrolling twice
    -- in the same race event
    CONSTRAINT UQ_Enrolment_User_Event
        UNIQUE (UserId, EventId)
);
GO



  /* CREATE TABLE: Result
   Linked to both Enrolment and UserProfile*/

CREATE TABLE Result
(
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL,
    UserId INT NOT NULL,
    BestTime TIME NOT NULL,

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentId)
        REFERENCES Enrolment(EnrolmentId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Result_UserProfile
        FOREIGN KEY (UserId)
        REFERENCES UserProfile(UserId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
GO



   /*INSERT DATA: UserProfile*/

INSERT INTO UserProfile (FullName, EmailAddress, Password, UserRole)
VALUES
('John Smith', 'john.smith@email.com', 'Password123', 'Organiser'),
('Sarah Johnson', 'sarah.johnson@email.com', 'Password123', 'Organiser'),
('Michael Brown', 'michael.brown@email.com', 'Password123', 'Participant'),
('Thabo Mokoena', 'thabo.mokoena@email.com', 'Password123', 'Participant'),
('Zinhle Dlamini', 'zinhle.dlamini@email.com', 'Password123', 'Participant'),
('David Williams', 'david.williams@email.com', 'Password123', 'Participant'),
('Amanda Jacobs', 'amanda.jacobs@email.com', 'Password123', 'Participant');
GO



  /* INSERT DATA: Organiser */

INSERT INTO Organiser (UserId, Department, UserImage)
VALUES
(1, 'Event Management', 'john.jpg'),
(2, 'Sports Administration', 'sarah.jpg'),
(3, 'Community Events', 'michael.jpg'),
(4, 'Race Coordination', 'thabo.jpg'),
(5, 'Marketing Department', 'zinhle.jpg');
GO


/* INSERT DATA: Participant */

INSERT INTO Participant (UserId, Height, Gender, FirstTimeParticipant, Age)
VALUES
(3, 1.80, 'Male', 1, 25),
(4, 1.75, 'Male', 0, 30),
(5, 1.65, 'Female', 1, 22),
(6, 1.82, 'Male', 0, 28),
(7, 1.70, 'Female', 1, 26);
GO


/* INSERT DATA: Category*/

INSERT INTO Category (CategoryDescription, Details, Age)
VALUES
('Junior Race', 'Race category for young participants', 16),
('Senior Race', 'Race category for adult participants', 18),
('Veteran Race', 'Race category for experienced runners', 40),
('Marathon', 'Long distance endurance race', 18),
('Fun Run', 'Casual race suitable for all participants', 12);
GO


/* INSERT DATA: RaceEvent */

INSERT INTO RaceEvent
(
    CategoryId,
    RaceDate,
    Location,
    RaceName,
    RaceDetails,
    EnrolmentClosingDate
)
VALUES
(1, '2026-10-10', 'Pretoria', 'Pretoria Junior Challenge',
 'A 5km race for junior runners.', '2026-10-01'),

(2, '2026-10-20', 'Johannesburg', 'Joburg Senior Sprint',
 'A competitive 10km race for senior participants.', '2026-10-10'),

(3, '2026-11-05', 'Cape Town', 'Cape Veteran Run',
 'A race specifically designed for veteran runners.', '2026-10-25'),

(4, '2026-11-15', 'Durban', 'Durban City Marathon',
 'A full marathon through the city of Durban.', '2026-11-01'),

(5, '2026-12-01', 'Bloemfontein', 'Summer Fun Run',
 'A fun and relaxed community race.', '2026-11-20');
GO


/* INSERT DATA: Enrolment */

INSERT INTO Enrolment (UserId, EventId)
VALUES
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(7, 5);
GO


/* INSERT DATA: Result */

INSERT INTO Result (EnrolmentId, UserId, BestTime)
VALUES
(1, 3, '00:25:30'),
(2, 4, '00:45:15'),
(3, 5, '00:50:40'),
(4, 6, '03:15:20'),
(5, 7, '00:35:10');
GO


/* TEST QUERIES CHATGPT USED AS REFERENCE*/

SELECT * FROM UserProfile;
SELECT * FROM Organiser;
SELECT * FROM Participant;
SELECT * FROM Category;
SELECT * FROM RaceEvent;
SELECT * FROM Enrolment;
SELECT * FROM Result;
GO
