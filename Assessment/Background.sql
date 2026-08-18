#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Set up the User and the password

DROP USER 'Hello'@'localhost'; -- Drop the Hello User if exist

CREATE USER 'Hello'@'localhost' IDENTIFIED BY 'Pass@1234'; -- Create the Hello User with Password

GRANT ALL PRIVILEGES ON Olympic_22467577.* TO 'Hello'@'localhost'; -- Grant permissions to the Hello User for the database

FLUSH PRIVILEGES; -- Update the Changes
