#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Create Trigger

Delimiter $$  -- Set delimiter to $$ to create the trigger

#Create trigger that ensure the new insert athlete age is not lower than minimum age which is 13
CREATE TRIGGER check_age_insert_athlete
    BEFORE INSERT ON Athlete -- trigger before any insert on Athlete table
    FOR EACH ROW
    BEGIN
        IF ROUND((DATEDIFF(CURDATE(),NEW.Birth_Date) / 365),0) < 13 THEN -- Means if age lower than 13
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Athlete must be at least 13 years old!'; -- Output an error message to tell the user the inserted Birth_Date is invalid
        END IF;
    END$$

#Create trigger that prevent wrong update on the value of Medal Type
CREATE TRIGGER change_medalcode_update_medal
    BEFORE UPDATE ON Medal -- trigger before any update on Medal table
    For Each ROW
    BEGIN
        IF NEW.Medal_Code = 1 AND NEW.Medal_Type <> 'Gold' THEN -- If code is 1 but type is not gold
            SET NEW.Medal_Type = 'Gold';
        ELSEIF NEW.Medal_Code = 2 AND NEW.Medal_Type <> 'Silver' THEN -- If code is 2 but type is not silver
            SET NEW.Medal_Type = 'Silver';
        ELSEIF NEW.Medal_Code = 3 AND NEW.Medal_Type <> 'Bronze' THEN -- If code is 3 but type is not bronze
            SET NEW.Medal_Type = 'Bronze';
        ELSEIF NEW.Medal_Code <> 1 OR NEW.Medal_Code <> 2 OR NEW.Medal_Code <> 1 THEN -- If code is not 1,2,or 3
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Medal Code!'; -- Output an error message to tell the user the value of Medal_Code is invalid
        END IF;
    END$$
    
Delimiter ; -- Set the delimiter back to ; to prevent syntax error in mysql
        
        
        

