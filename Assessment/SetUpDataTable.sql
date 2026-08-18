#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Setting up the datatable

#Create the Country Table
DROP Table IF EXISTS Country;
CREATE table Country(    
    Country_Code CHAR(3) PRIMARY KEY, -- Set Country Code As Primary Key
    Name VARCHAR(40) NOT NULL
);

#Create the Venue Table
DROP Table IF EXISTS Venue;
CREATE table Venue(    
    Venue_Code CHAR(3) PRIMARY KEY, -- Set Venue Code As Primary Key
    Name VARCHAR(50) NOT NULL
);

#Create the Athlete Table
DROP Table IF EXISTS Athlete;
CREATE table Athlete(   
    Athlete_Code Int(7) PRIMARY KEY, -- Set Athlete Code As Primary Key
    Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(6) NOT NULL,
    Discipline VARCHAR(50), 
    Birth_Date DATE CHECK (Birth_Date >= '1900-01-01'), -- Use CHECK Constraint to ensure a valid athlete's age
    Side_Job VARCHAR(50) DEFAULT 'None', -- Set the Default Value of Side_Job is 'None' for the athlete who does not have side job
    Country_Code CHAR(3) NOT NULL,
    CONSTRAINT fk_country
        FOREIGN KEY (Country_Code)
        REFERENCES Country(Country_Code) -- Country Code from Country table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE -- Delete or Update on Country Code in Country Table will change the Country Code in Athlete Table
);

#Create the Medal Table
DROP Table IF EXISTS Medal;
CREATE table Medal(    
    Athlete_Code Int(7), 
    Medal_Code Int(1), 
    Medal_Type CHAR(6) NOT NULL,
    Award_Date Date CHECK (Award_Date >= '2024-07-23'), -- Use CHECK Constraint to ensure the award date is after the start date of Olympic 2024
    PRIMARY KEY (Athlete_Code,Medal_Code),  -- Set Athlete Code from Athlete Table and Medal Code As Primary Key
    CONSTRAINT fk_medal_athlete
        FOREIGN KEY (Athlete_Code)
        REFERENCES Athlete(Athlete_Code) -- Athlete Code from Athlete table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE -- Delete or Update on Athlete Code in Athlete Table will change the Athlete Code in Medal Table
);

#Create the Event Table
DROP Table IF EXISTS Event;
CREATE table Event(    
    Sport_Code CHAR(3) PRIMARY KEY,  -- Set Sport Code As Primary Key
    Sport_Name VARCHAR(50) NOT NULL,
    Venue_Code CHAR(3) NOT NULL,
    CONSTRAINT fk_venue
        FOREIGN KEY (Venue_Code)
        REFERENCES Venue(Venue_Code) -- Venue Code from Venue table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE -- Delete or Update on Venue Code in Venue Table will change the Venue Code in Event Table
);

#Create the Participation Table
DROP Table IF EXISTS Participation;
CREATE table Participation(     
    Athlete_Code Int(7) NOT NULL, 
    Sport_Code CHAR(3) NOT NULL,
    Started_Date Date CHECK (Started_Date >= '2024-07-23'), -- Use CHECK Constraint to ensure a valid start date
    Ended_Date Date CHECK (Ended_Date >= '2024-07-23'), -- Use CHECK Constraint to ensure a valid end date
    CONSTRAINT fk_participate_athlete
        FOREIGN KEY (Athlete_Code)
        REFERENCES Athlete(Athlete_Code) -- Athlete Code from Athlete table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE, -- Delete or Update on Athlete Code in Athlete Table will change the Athlete Code in Participation Table
    CONSTRAINT fk_participate_event
        FOREIGN KEY (Sport_Code)
        REFERENCES Event(Sport_Code) -- Sport Code from Event table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE -- Delete or Update on Sport Code in Event Table will change the Sport Code in Participation Table
);

#Create the Official Table
DROP Table IF EXISTS Official;
CREATE table Official(    
    Official_Code Int(7),
    Name VARCHAR(50) NOT NULL,
    Gender CHAR(6),
    Role VARCHAR(30),
    Belonged_Organization VARCHAR(80),
    PRIMARY KEY(Official_Code,Belonged_Organization) -- Set Official Code and Belonged_Organization As Primary Key
);

#Create the Event_Management Table
DROP Table IF EXISTS Event_Management;
CREATE table Event_Management(     
    Official_Code Int(7) NOT NULL,
    Belonged_Organization VARCHAR(80) NOT NULL,
    Sport_Code CHAR(3) NOT NULL,
    CONSTRAINT fk_manage_official
        FOREIGN KEY (Official_Code,Belonged_Organization)
        REFERENCES Official(Official_Code,Belonged_Organization) -- Official Code and Belonged Organization from Official table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE, -- Delete or Update on Official Code and Belonged Organization in Official Table will change the Official Code and Belonged Organization in Event_Management Table
    CONSTRAINT fk_manage_event
        FOREIGN KEY (Sport_Code)
        REFERENCES Event(Sport_Code) -- Sport Code from Event table become foreign key
        ON DELETE CASCADE ON UPDATE CASCADE -- Delete or Update on Sport Code in Event Table will change the Sport Code in Event_Management Table
);
