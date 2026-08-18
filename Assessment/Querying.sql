#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Get Answer from querying

#1.Display the code and the name of the athlete that has a side job and was born between 1995 and 2005

SELECT Athlete_Code,Name,Side_Job 
FROM Athlete 
WHERE Side_Job IS NOT NULL AND -- Ensure the athlete has side job
Birth_Date BETWEEN '1995-01-01' AND '2005-12-31'; -- Filter for athlete born between 01/01/1995 to 31/12/2005

#2.Display the code, the name, and the role of official come from a Sport Federation

SELECT Official_Code,Name,Role 
FROM Official 
WHERE Belonged_Organization LIKE '%Federation%'; -- Filter for organization name that contain 'Federation'

#3.Display the code, the name, and the total number of athletes represented by the country

SELECT Country.Name, Country.Country_Code,COUNT(Athlete.Country_Code) AS 'Number of athlete represented' -- COUNT Keyword calculate the total number of country_code which represent the total number of athlete in country
FROM Country INNER JOIN Athlete ON Country.Country_Code = Athlete.Country_Code -- Country table join Athlete table if they have same country code
Group BY Country.Country_Code , Country.Name -- Shows the result by country code and the name
ORDER BY COUNT(Athlete.Country_Code) DESC; -- Arrage the data by the number of athlete in a country in descending order

#4.Display the total number of uses for competition at each venue

SELECT Venue.Venue_Code,Venue.Name,COUNT(Event.Venue_Code) AS 'Total number of uses' -- Count Keyword calculate the total number of venue used
FROM Venue LEFT OUTER Join Event ON Venue.Venue_Code = Event.Venue_Code -- Left outer join allow display 0 in query table
GROUP BY Venue.Venue_Code,Venue.Name -- Shows the result by Venue code and name
ORDER BY COUNT(Event.Venue_Code) DESC; -- Arrage the data by the number of vanue used in descending order

#5.Display the code, name, gender,and birthday of the athlete who was born on the same date

SELECT DISTINCT A1.Athlete_Code,A1.Name,A1.Gender,A1.Birth_Date -- DISTICT Keyword remove the repeating row
FROM Athlete AS A1 JOIN Athlete AS A2 ON A1.Birth_Date = A2.Birth_Date AND A1.Athlete_Code <> A2.Athlete_Code -- Self Join
ORDER BY A1.Birth_Date; -- Arrage the data by the birth date in ascending order

#6.Display the all related information of an official

Select Official.Official_Code,Official.Name,Gender,Belonged_Organization,Event.Sport_Code,Event.Sport_Name
FROM Official NATURAL JOIN Event_Management NATURAL JOIN Event; 
-- Official join Event_Management by same Official code
-- Event join Event_Management by same sport code

#7.Display the code, name, gender,and the age of the athlete who has the smallest age

SELECT Athlete_Code,Name,Gender,ROUND((DATEDIFF(CURDATE(),Birth_Date) / 365),0) AS Age
FROM Athlete
WHERE (DATEDIFF(CURDATE(),Birth_Date) / 365) <= ALL(SELECT DATEDIFF(CURDATE(),Birth_Date) / 365 FROM Athlete); -- Compare the value of an age with all the age of Athlete using subqueries (if it satisfied the '<=' condition means the age is the smallest)

#8.Display the event that uses most days to complete

SELECT Sport_Name, MAX(DATEDIFF(Ended_Date,Started_Date)) AS 'Maximum Days used' 
FROM Event NATURAL JOIN Participation -- Join by same Sport code
GROUP BY Sport_Name -- Shows the result by Sport Name
HAVING MAX(DATEDIFF(Ended_Date,Started_Date)) = (SELECT MAX(DATEDIFF(Ended_Date,Started_Date)) FROM Event NATURAL JOIN Participation); -- Compare the max days used of every sport with the maximum days used which is 17 days using sub queries

