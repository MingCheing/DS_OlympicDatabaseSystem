#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Create Stored Procedure

Delimiter $$ -- Set delimiter to $$ to create the stored procedure

DROP PROCEDURE IF EXISTS insAthlete$$
CREATE Procedure insAthlete(
    N varchar(50), -- Represent Athlete's Name
    G char(6), -- Represent Athlete's Gender 
    D varchar(50), -- Represent Athlete's Discipline
    BD Date, -- Represent Athlete's Birth Date
    SJ varchar(50), -- Represent Athlete's Side Job
    CD char(3)) -- Represent Athlete's Country Code
Comment "This procedure insert a new Athlete in Athlete Table"
BEGIN
        Declare newAtCode int; -- newAtCode stored the new athlete code which is the latest athlete code the Athlete Table plus 1
        select Max(Athlete_Code)+1 from Athlete into newAtCode;
        IF (G IN ('Male','Female')) THEN -- Ensure Value of Gender is valid
            IF (SJ = '') THEN -- If athlete don't have side job then no value will be insert for Side_Job
                Insert into Athlete (Athlete_Code, Name, Gender, Discipline, Birth_Date, Side_Job, Country_Code) Values (newAtCode,N,G,D,BD,NULL,CD);
            ELSE
                Insert into Athlete (Athlete_Code, Name, Gender, Discipline, Birth_Date, Side_Job, Country_Code) Values (newAtCode,N,G,D,BD,SJ,CD);
            END IF;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Gender of Athlete should be Male or Female!'; -- Output an error message to tell the user the inserted Gender is invalid
        END IF;
END$$

DROP PROCEDURE IF EXISTS insOfficial$$
CREATE Procedure insOfficial(
    N varchar(50), -- Represent Official's Name
    G char(6), -- Represent Official's Gender
    R varchar(30), -- Represent Official's Role
    BO varchar(80)) -- Represent Official's Belonged Organisation
Comment "This procedure insert a new Official in Official Table"
BEGIN
        Declare newOfCode int(7); -- newOfCode stored the new official code which is the latest official code the Official Table plus 1
        select Max(Official_Code)+1 from Official into newOfCode;
        IF (G IN ('Male','Female')) THEN -- Ensure Value of Gender is valid
            Insert into Official (Official_Code, Name, Gender, Role, Belonged_Organization) Values (newOfCode,N,G,R,BO);
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Gender of Official should be Male or Female!'; -- Output an error message to tell the user the inserted Gender is invalid
        END IF;
END$$

DROP PROCEDURE IF EXISTS showCountryMedalNumber$$
CREATE PROCEDURE showCountryMedalNumber()
Comment "This procedure display the total number of medal each country"
BEGIN
        Declare done int DEFAULT 0; -- Variable done acts as mark of cursor reach the end
        Declare countrycode CHAR(3); -- Represent Country Code
        -- Create a cursor that stored the code of country that have athlete who wins a medal
        Declare curMedal CURSOR FOR SELECT Country.Country_Code 
                                    FROM (Country JOIN Athlete ON Country.Country_Code = Athlete.Country_Code) 
                                                  JOIN Medal ON Athlete.Athlete_Code = Medal.Athlete_Code;
        Declare CONTINUE HANDLER FOR NOT FOUND Set done = 1; -- Set done = 1 if not more line is found in cursor (means cursor reach the end)
        
        Drop TABLE IF EXISTS Temporary;
        CREATE TEMPORARY TABLE Temporary(Country_Code CHAR(3),Name VARCHAR(40),TotalMedalNumber INT(100) DEFAULT 0); 
        -- Temporary table stored the information of country and their total medal number accordingly
        -- This table with temporary value will be deleted when this procedure End
        
        INSERT INTO Temporary (Country_Code,Name) -- Insert the Country code and name into Temporary Table
        SELECT Country_Code,Name
        FROM Country;
        
        OPEN curMedal; -- Use the cursor created just now
        getCountMedal:LOOP -- The loop will fetch Country_Code in every line of cursor into the countrycode variable until it reach to the end of the cursor 
        FETCH curMedal INTO countrycode; 
            IF done = 1 THEN -- Means that cursor reach the end of data
                LEAVE getCountMedal; -- Exit from loop
            END IF;
            UPDATE Temporary SET TotalMedalNumber = TotalMedalNumber + 1 WHERE Country_Code = countrycode; -- TotalMedalNumber in Temporary plus 1 if the Country_Code in Temporary table is same as countrycode in cursor
            END LOOP getCountMedal;
       CLOSE curMedal;
       
       Select * from Temporary ORDER BY TotalMedalNumber DESC; -- Display the content in Temporary table
END$$

Delimiter ; -- Set the delimiter back to ; to prevent syntax error in mysql

