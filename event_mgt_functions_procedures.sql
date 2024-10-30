CREATE PROCEDURE AddEvent
    @EventName NVARCHAR(100),
    @Description NVARCHAR(500),
    @StartDate DATETIME,
    @EndDate DATETIME,
    @VenueID INT,
    @OrganizerID INT
AS
BEGIN
    INSERT INTO Events (EventName, Description, StartDate, EndDate, VenueID, OrganizerID)
    VALUES (@EventName, @Description, @StartDate, @EndDate, @VenueID, @OrganizerID);
END

CREATE PROCEDURE GetTicketsSold
    @EventID INT
AS
BEGIN
    SELECT COUNT(*) AS TicketsSold
    FROM Tickets
    WHERE EventID = @EventID;
END

--functions

CREATE FUNCTION CalculateTotalRevenue(@EventID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10, 2);

    SELECT @TotalRevenue = SUM(Price)
    FROM Tickets
    WHERE EventID = @EventID;

    RETURN ISNULL(@TotalRevenue, 0);
END

CREATE FUNCTION GetNumberOfAttendees(@EventID INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumberOfAttendees INT;

    SELECT @NumberOfAttendees = COUNT(DISTINCT AttendeeID)
    FROM Tickets
    WHERE EventID = @EventID;

    RETURN ISNULL(@NumberOfAttendees, 0);
END
