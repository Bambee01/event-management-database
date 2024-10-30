-- Create the Event Management Database
CREATE DATABASE EventManagementDB;
GO

USE EventManagementDB;
GO

-- Table for storing Event Information
CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    VenueID INT,
    OrganizerID INT,
    CONSTRAINT FK_Events_Venue FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
    CONSTRAINT FK_Events_Organizer FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID)
);

-- Table for storing Venue Information
CREATE TABLE Venues (
    VenueID INT PRIMARY KEY IDENTITY(1,1),
    VenueName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    Capacity INT NOT NULL
);

-- Table for storing Organizer Information
CREATE TABLE Organizers (
    OrganizerID INT PRIMARY KEY IDENTITY(1,1),
    OrganizerName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100),
    ContactPhone NVARCHAR(15)
);

-- Table for storing Attendee Information
CREATE TABLE Attendees (
    AttendeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15)
);

-- Table for Ticketing
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    AttendeeID INT NOT NULL,
    TicketType NVARCHAR(50) NOT NULL, -- E.g., General Admission, VIP, etc.
    Price DECIMAL(10, 2) NOT NULL,
    PurchaseDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Tickets_Event FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_Tickets_Attendee FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- Table for Event Schedule (e.g., individual sessions within the event)
CREATE TABLE EventSchedule (
    ScheduleID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    SessionName NVARCHAR(100) NOT NULL,
    Speaker NVARCHAR(100),
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Location NVARCHAR(100),
    CONSTRAINT FK_EventSchedule_Event FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- Table for Event Feedback
CREATE TABLE EventFeedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    AttendeeID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5), -- Rating out of 5
    Comments NVARCHAR(MAX),
    FeedbackDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_EventFeedback_Event FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_EventFeedback_Attendee FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- Table for storing event categories (optional)
CREATE TABLE EventCategories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL
);

-- Many-to-Many relationship table for Event-Categories
CREATE TABLE EventCategoryMapping (
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT PK_EventCategoryMapping PRIMARY KEY (EventID, CategoryID),
    CONSTRAINT FK_EventCategoryMapping_Event FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT FK_EventCategoryMapping_Category FOREIGN KEY (CategoryID) REFERENCES EventCategories(CategoryID)
);

-- Insert data into Venues
INSERT INTO Venues (VenueName, Location, Capacity)
VALUES 
('Conference Hall A', '123 Main St', 200),
('Expo Center B', '456 Elm St', 500),
('Main Auditorium', '789 Oak St', 350),
('Outdoor Arena', '101 Maple Ave', 1000),
('City Center Banquet Hall', '202 Pine St', 300),
('Community Center Room 1', '303 Cedar Rd', 150),
('Tech Park Pavilion', '404 Birch Blvd', 450),
('Downtown Theater', '505 Walnut Dr', 600),
('Innovation Lab', '606 Cherry Ln', 80),
('University Hall', '707 Maplewood Ave', 250),
('Grand Ballroom', '808 Oakwood Dr', 750),
('Exhibit Hall C', '909 Spruce St', 650),
('City Library Conference Room', '110 Sycamore Ave', 100),
('Sports Complex Field', '112 Willow Rd', 1200),
('The Garden Center', '214 Ivy Ln', 300),
('Community Hall', '316 Rose Dr', 350),
('Business District Lounge', '418 Palm Blvd', 150),
('Lakeview Convention Hall', '520 Lake Rd', 500),
('Art Museum Hall', '622 Hilltop Ave', 200),
('Marina Bay Center', '724 River Rd', 300);

-- Insert data into Organizers
INSERT INTO Organizers (OrganizerName, ContactEmail, ContactPhone)
VALUES 
('Tech Events Inc.', 'contact@techevents.com', '123-456-7890'),
('Event Masters', 'info@eventmasters.com', '234-567-8901'),
('Biz Conferences', 'support@bizconf.com', '345-678-9012'),
('Sports Meetups', 'contact@sportsmeetups.com', '456-789-0123'),
('Academic Gatherings', 'hello@academics.com', '567-890-1234'),
('Community Hub', 'info@communityhub.com', '678-901-2345'),
('Youth Empowerment', 'youth@empowerment.com', '789-012-3456'),
('Tech World', 'world@tech.com', '890-123-4567'),
('Leadership Summits', 'summits@leadership.com', '901-234-5678'),
('Health and Wellness', 'health@wellness.com', '012-345-6789'),
('Green Earth', 'contact@greenearth.org', '123-456-7800'),
('Art and Culture', 'info@artculture.com', '234-567-8900'),
('Innovation Network', 'innovation@network.com', '345-678-9001'),
('Future Leaders', 'future@leaders.com', '456-789-9102'),
('Local Heroes', 'heroes@local.com', '567-890-1203'),
('Career Boost', 'boost@career.com', '678-901-2304'),
('Digital Solutions', 'solutions@digital.com', '789-012-3405'),
('Music and Arts', 'arts@music.com', '890-123-4506'),
('Entrepreneurs Network', 'contact@entrepreneurs.com', '901-234-5607'),
('Wellbeing Fest', 'wellbeing@fest.com', '012-345-6708');

-- Insert data into Events
INSERT INTO Events (EventName, Description, StartDate, EndDate, VenueID, OrganizerID)
VALUES 
('Tech Conference 2024', 'A conference for tech enthusiasts', '2024-11-01 09:00', '2024-11-01 17:00', 1, 1),
('Sports Expo', 'Expo for sports equipment and technology', '2024-11-05 10:00', '2024-11-05 16:00', 2, 4),
('Youth Empowerment Summit', 'A summit to empower youth leaders', '2024-11-10 08:00', '2024-11-10 18:00', 3, 7),
('Health & Wellness Fair', 'Health and wellness promotion', '2024-11-12 09:00', '2024-11-12 15:00', 4, 10),
('Art Showcase', 'Showcasing local and international art', '2024-11-15 11:00', '2024-11-15 19:00', 5, 12),
('Green Earth Forum', 'Environmental awareness event', '2024-11-20 09:00', '2024-11-20 17:00', 6, 11),
('Career Development Workshop', 'Career tips and guidance', '2024-11-23 10:00', '2024-11-23 14:00', 7, 16),
('Digital Transformation Seminar', 'Seminar on digital transformation', '2024-11-25 08:00', '2024-11-25 16:00', 8, 18),
('Music & Arts Festival', 'Festival of music and arts', '2024-11-27 14:00', '2024-11-27 22:00', 9, 19),
('Innovation Expo', 'Expo for innovators and inventors', '2024-12-01 09:00', '2024-12-01 17:00', 10, 13),
('Local Heroes Awards', 'Awards for local heroes', '2024-12-03 18:00', '2024-12-03 21:00', 11, 15),
('Science & Technology Forum', 'Science and technology conference', '2024-12-05 08:00', '2024-12-05 17:00', 12, 2),
('Academic Conference', 'Research and academic presentations', '2024-12-08 09:00', '2024-12-08 18:00', 13, 5),
('Community Gathering', 'Gathering for community members', '2024-12-10 09:00', '2024-12-10 12:00', 14, 6),
('Wellness Retreat', 'A retreat focusing on wellness', '2024-12-15 08:00', '2024-12-15 17:00', 15, 20),
('Entrepreneurship Summit', 'Summit for entrepreneurs', '2024-12-18 09:00', '2024-12-18 18:00', 16, 14),
('Tech Meetup', 'Meetup for tech enthusiasts', '2024-12-20 09:00', '2024-12-20 12:00', 17, 8),
('Business Leadership Conference', 'Conference on business leadership', '2024-12-22 08:00', '2024-12-22 17:00', 18, 9),
('Startup Pitch Event', 'Pitch event for startups', '2024-12-23 10:00', '2024-12-23 16:00', 19, 3),
('Arts & Culture Gala', 'Gala celebrating arts and culture', '2024-12-25 18:00', '2024-12-25 23:00', 20, 12);

-- Insert data into Attendees
INSERT INTO Attendees (FullName, Email, Phone)
VALUES 
('John Doe', 'johndoe@example.com', '111-111-1111'),
('Jane Smith', 'janesmith@example.com', '222-222-2222'),
('Alice Johnson', 'alicej@example.com', '333-333-3333'),
('Bob Brown', 'bobbrown@example.com', '444-444-4444'),
('Charlie Black', 'charlieb@example.com', '555-555-5555'),
('Diane White', 'dianew@example.com', '666-666-6666'),
('Evan Green', 'evang@example.com', '777-777-7777'),
('Fiona Blue', 'fionab@example.com', '888-888-8888'),
('George Gray', 'georgeg@example.com', '999-999-9999'),
('Hannah Pink', 'hannahp@example.com', '101-101-1010'),
('Ian Red', 'ianr@example.com', '202-202-2020'),
('Jack Silver', 'jacks@example.com', '303-303-3030'),
('Kara Gold', 'karag@example.com', '404-404-4040'),
('Liam Amber', 'liama@example.com', '505-505-5050'),
('Mia Violet', 'miav@example.com', '606-606-6060'),
('Noah Indigo', 'noahi@example.com', '707-707-7070'),
('Olivia Cyan', 'oliviac@example.com', '808-808-8080'),
('Paul Lime', 'paull@example.com', '909-909-9090'),
('Quinn Yellow', 'quinny@example.com', '010-010-1010'),
('Ruby Maroon', 'rubym@example.com', '020-202-0202');

-- Insert data into Tickets (assuming EventID and AttendeeID are chosen from Events and Attendees tables)
-- Insert data into Tickets
INSERT INTO Tickets (EventID, AttendeeID, TicketType, Price)
VALUES 
(1, 1, 'General Admission', 50.00),
(1, 2, 'VIP', 100.00),
(1, 3, 'General Admission', 50.00),
(1, 4, 'Student', 25.00),
(1, 5, 'VIP', 100.00),
(1, 6, 'General Admission', 50.00),
(1, 7, 'Group Package', 200.00),
(1, 8, 'Early Bird', 45.00),
(2, 1, 'Exhibitor', 200.00),
(2, 2, 'General Admission', 30.00),
(2, 3, 'VIP', 80.00),
(2, 4, 'Student', 15.00),
(2, 5, 'General Admission', 30.00),
(3, 6, 'General Admission', 20.00),
(3, 7, 'VIP', 60.00),
(3, 8, 'Group Package', 150.00),
(4, 1, 'General Admission', 20.00),
(4, 2, 'Family Package', 40.00),
(5, 3, 'Exhibitor', 250.00),
(5, 4, 'VIP', 90.00),
(6, 5, 'General Admission', 10.00),
(6, 6, 'VIP', 40.00),
(7, 7, 'Student', 10.00),
(7, 8, 'General Admission', 25.00),
(8, 1, 'General Admission', 55.00),
(8, 2, 'VIP', 110.00),
(9, 3, 'General Admission', 60.00),
(9, 4, 'VIP', 120.00),
(10, 5, 'General Admission', 70.00),
(10, 6, 'Early Bird', 60.00),
(11, 7, 'General Admission', 25.00),
(11, 8, 'VIP', 75.00),
(12, 1, 'General Admission', 30.00),
(12, 2, 'VIP', 80.00),
(13, 3, 'Student', 15.00),
(13, 4, 'Group Package', 100.00),
(14, 5, 'General Admission', 20.00),
(14, 6, 'VIP', 45.00),
(15, 7, 'General Admission', 10.00),
(15, 8, 'VIP', 40.00),
(16, 1, 'Student', 10.00),
(16, 2, 'General Admission', 30.00),
(17, 3, 'VIP', 100.00),
(17, 4, 'Group Package', 200.00),
(18, 5, 'Early Bird', 40.00),
(18, 6, 'General Admission', 25.00),
(19, 7, 'VIP', 90.00),
(19, 8, 'General Admission', 50.00),
(20, 1, 'VIP', 120.00),
(20, 2, 'General Admission', 60.00);



