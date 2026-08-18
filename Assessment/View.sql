#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Create View

#Create the view that only show the athelete name ,code and award date of athelete who wins the match 
DROP VIEW IF EXISTS Winner;
CREATE VIEW Winner AS
    SELECT Athlete.Name AS Winner_Name,Medal.Athlete_Code AS Winner_Code,Award_Date
    FROM Medal NATURAL JOIN Athlete; -- Medal table and Athlete table Join By Athlete_Code

#Create the view that show athlete name ,code and their competition venue name accordingly    
Drop VIEW IF EXISTS Athlete_Venue;
CREATE VIEW Athlete_Venue AS
    SELECT Athlete.Name AS Athlete_Name,Participation.Athlete_Code AS Athlete_Code,Venue.Name AS Venue_Name
    FROM (((Athlete JOIN Participation ON Athlete.Athlete_Code = Participation.Athlete_Code) -- Athlete table Join Participation table accordingly using Athlete_code
                    JOIN Event ON Participation.Sport_Code = Event.Sport_Code) -- Then,the joined table join Event using Sport_Code
                    JOIN Venue ON Event.Venue_Code = Venue.Venue_Code);  -- Then,join the latest table Venue using Venue_Code
 
