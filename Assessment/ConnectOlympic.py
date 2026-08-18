#YeeMingCheing_22467577

#Name:Yee Ming Cheing
#StudentID:22467577
#Database System 2024 Sem2
#Purpose:Python Connect to Database Olympic_22467577

import mysql.connector #Import mysql connector
import os #Import Operating System library (access environment variables)

#Get the password and user name from environment variables
DPASSWORD = os.getenv('PASSWORD')
DUSER = os.getenv('USER')

#Connect to Olympic_22467577 Database
db = mysql.connector.connect(
  host = "localhost", #hostname
  user = DUSER, #username
  passwd = DPASSWORD, #userpassword
  database = "Olympic_22467577") #databasename
  
#Create a cursor object to execute the queries
mycursor=db.cursor()

#Prepare the query
ShowAthlete = ("SELECT * FROM Athlete") #Display all the athlete 
ShowWinner = ("SELECT * FROM Winner") #Display all the winner
InsertAthlete = ("CALL insAthlete(%s, %s, %s, %s, %s, %s)") #Insert an athlete using stored procedure
DeleteAthlete = ("DELETE FROM Athlete WHERE Athlete_Code = %s") #Delete specific athlete
UpdateAthlete = ("UPDATE Athlete SET Discipline =%s WHERE Athlete_Code = %s") #Update discipline of a specific athlete
#Display the code and the name of the athlete that has a side job and was born between 1995 and 2005
SampleQueryOne = ("SELECT Athlete_Code,Name,Side_Job FROM Athlete WHERE Side_Job IS NOT NULL AND Birth_Date BETWEEN '1995-01-01' AND '2005-12-31'")
#Display the code, the name, and the role of official come from a Sport Federation
SampleQueryTwo = ("SELECT Official_Code,Name,Role FROM Official WHERE Belonged_Organization LIKE '%Federation%'")

while True: #Keep looping until break
    print("\n\nWelcome\nPlease select one of the following option\n1)Show Athlete Table\n2)Show Winner Table\n3)Insert a athlete into Athlete Table\n4)Delete a athlete into Athlete Table\n5)Update a athlete's disipline into Athlete Table\n6)QueryOne(Display information of the athlete that has a side job and was born between 1995 and 2005)\n7)QueryTwo(Display information of official from a Sport Federation)\n0)Exit") #Display Menu
    choice = input("Enter your choice: ") #Get user choice (an integer)
    
    if (choice == '1'):
        mycursor.execute(ShowAthlete) #Execute the query
        result = mycursor.fetchall() #Fetch all row from query
        for (Athlete_code,Name,Gender,Disipline,Birth_Date,Side_Job,Country_Code) in result:
             print("Athlete Code : {} \nAthlete Name : {} \nGender       : {} \nDisipline    : {} \nBirth Date   : {:%d %b %Y} \nSide Job     : {} \nCountry Code : {} \n ".format(Athlete_code,Name,Gender,Disipline,Birth_Date,Side_Job,Country_Code)) #Format and display all athlete information
    
    elif (choice == '2'):
        mycursor.execute(ShowWinner) #Execute the query
        result = mycursor.fetchall() #Fetch all row from query
        for (Winner_Name,Winner_Code,Award_Date) in result:
             print("Winner Name : {} \nWinner Code : {} \nAward Date   : {:%d %b %Y} \n ".format(Winner_Name,Winner_Code,Award_Date)) #Format and display all athlete information
    
    elif (choice == '3'):
        try: #Error Handling
            name = input("Enter Name: ") #Get the athlete's name from user
            gender = input("Enter Gender: ") #Get the athlete's gender from user
            discipline = input("Enter Discipline: ") #Get the athlete's discipline from user
            birth_date = input("Enter Birth Date (YYYY-MM-DD): ") #Get the athlete's birth date from user
            side_job = input("Enter Side Job (Press enter if no side job): ") #Get athlete's side job from user
            country_code = input("Enter Country Code: ") #Get athlete's country code from user
            if (side_job == ''): #Set a value for side job if the new athlete don't have side job
                val = (name, gender, discipline, birth_date, None, country_code)
            else :
                val = (name, gender, discipline, birth_date, side_job, country_code)
            mycursor.execute(InsertAthlete,val) #Execute the stored prodecure with the data input by user
            db.commit() #Save the changes into the database
        except Exception as e: #Tell the user there is an error and ask the user to try again
            print("An error occurred: ",e) 
            print("\nPlease Try Again")
    
    elif (choice == '4'):
        try: #Error Handling
            search_code = input("Enter Athlete Code of Athlete you want to delete: ")  #Get the athlete code of the athlete that the user want to delete from the user
            val = (search_code,)
            mycursor.execute(DeleteAthlete,val) #Execute the query to delete the athlete using the athlete code get from user
            db.commit() #Save the changes into the database
        except Exception as e: #Tell the user there is an error and ask the user to try again
            print("An error occurred: ",e)
            print("\nPlease Try Again")
    
    elif (choice == '5'):
        try: #Error Handling
            search_code = input("Enter Athlete Code of Athlete you want to update: ") #Get the athlete code of the athlete that the user want to update from the user
            newD = input("Enter the new Discipline:") #Get the athlete's discipline from user
            val = (newD,search_code)
            mycursor.execute(UpdateAthlete,val) #Execute the query to update the athlete using the athlete code and the discipline get from user
            db.commit() #Save the changes into the database
        except Exception as e: #Tell the user there is an error and ask the user to try again
            print("An error occurred: ",e)
            print("\nPlease Try Again")
    
    elif (choice == '6'):
        mycursor.execute(SampleQueryOne) #Execute the query
        result = mycursor.fetchall() #Fetch all row from query
        for row in result:
             print (row) #Display every row in the table
    
    elif (choice == '7'):
        mycursor.execute(SampleQueryTwo) #Execute the query
        result = mycursor.fetchall() #Fetch all row from query
        for row in result:
             print (row) #Display every row in the table
    
    elif (choice == '0'):
        break #Exit from the loop
    
    else: #Invalid choice
        print("Invalid option.Please Try again.")
        
mycursor.close() #Close the cursor
db.close() #Close the connection to the database


