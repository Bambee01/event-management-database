# Event Management System Database

## Overview

The **Event Management System Database** is designed to facilitate the management of events, venues, organizers, attendees, and ticket sales. This database allows organizations to efficiently plan and execute various types of events, from conferences to workshops, while keeping track of all related data.

## Features

- **Venues**: Manage different venues where events can be held, including location and capacity.
- **Organizers**: Track event organizers, including their contact information.
- **Events**: Create and manage events with details such as name, description, date, venue, and organizer.
- **Attendees**: Record attendee information, including names and contact details.
- **Tickets**: Manage ticket sales, including types of tickets and pricing.

## Database Schema

The database consists of the following tables:

1. **Venues**
    - `VenueID` (Primary Key)
    - `VenueName`
    - `Location`
    - `Capacity`
2. **Organizers**
    - `OrganizerID` (Primary Key)
    - `OrganizerName`
    - `ContactEmail`
    - `ContactPhone`
3. **Events**
    - `EventID` (Primary Key)
    - `EventName`
    - `Description`
    - `StartDate`
    - `EndDate`
    - `VenueID` (Foreign Key)
    - `OrganizerID` (Foreign Key)
4. **Attendees**
    - `AttendeeID` (Primary Key)
    - `FullName`
    - `Email`
    - `Phone`
5. **Tickets**
    - `TicketID` (Primary Key)
    - `EventID` (Foreign Key)
    - `AttendeeID` (Foreign Key)
    - `TicketType`
    - `Price`

## Installation

To set up the Event Management System database:

1. **Clone the Repository**
    
    ```bash
    bash
    Copy code
    git clone https://github.com/yourusername/event-management-system.git
    cd event-management-system
    
    ```
    
2. **Create the Database**
Use the following SQL script to create the database and tables:
    
    ```sql
    sql
    Copy code
    -- SQL script for creating the database and tables
    -- Include the SQL statements provided earlier
    
    ```
    
3. **Insert Sample Data**
Populate the tables with sample data using the `INSERT` statements provided.

## Usage

After setting up the database, you can use SQL queries to perform various operations, such as:

- Retrieve a list of events:
    
    ```sql
    sql
    Copy code
    SELECT * FROM Events;
    
    ```
    
- Get details of all venues:
    
    ```sql
    sql
    Copy code
    SELECT * FROM Venues;
    
    ```
    
- Check ticket sales for a specific event:
    
    ```sql
    sql
    Copy code
    SELECT * FROM Tickets WHERE EventID = <EventID>;
    
    ```
    
- Find attendees for a specific event:
    
    ```sql
    sql
    Copy code
    SELECT a.FullName, a.Email
    FROM Attendees a
    JOIN Tickets t ON a.AttendeeID = t.AttendeeID
    WHERE t.EventID = <EventID>;
    
    ```
    
- **Stored Procedures**:
    - `AddEvent`: Takes parameters for event details and inserts a new event into the `Events` table.
    - `GetTicketsSold`: Accepts an `EventID` and returns the count of tickets sold for that event.
- **Functions**:
    - `CalculateTotalRevenue`: Accepts an `EventID` and returns the total revenue generated from ticket sales for that event.
    - `GetNumberOfAttendees`: Accepts an `EventID` and returns the total number of unique attendees for that event based on ticket sales.
