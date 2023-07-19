# dna-jail

## commands

### Add new Rehab Activity
Query:
```
INSERT INTO Rehab_Activity VALUES (%s, %s)
```
Adds a new activity to a given rehab center

### Add new weapon
Query:
```
INSERT INTO Gun_Servicing VALUES (%s, %s)
```
Add a new weapon to the database

### Add new personer to jail

SQL Query:
```
    INSERT INTO Prisoner (Block_Code, Cell_Number, Aadhar_Card, First_Name, Last_Name, Crime,
        Address, Execution_Date, Release_Date, Incarceration_Date)
    VALUES
    (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
```

Inserts a new prisoner into the database, specifically into the prisoner table, and assigns them a prison block and cell number with the given information

### Delete prisoner
query = ```DELETE FROM Prisoner WHERE Block_Code = %s AND Prisoner_ID = %s```
Delete the specified prisoner from the database

### Get Avg Credit Score per cell occupancy type
SQL Query:
```
SELECT Occupancy_Type, AVG(Credit_Score) FROM Prisoner As Pr 
        INNER JOIN Prison_Cell AS PC ON Pr.Cell_Number = PC.Cell_Number 
        INNER JOIN Prison_Occupancy AS PO ON Pr.Cell_Number = PO.Cell_Number 
        GROUP BY PO.Occupancy_Type
```
get the average credit score for each occupancy type

Get the average credit score of a prison block

### Get Avg Credit Score per prison block
SQL Query:
```
SELECT AVG(Credit_Score) FROM Prisoners WHERE Block_Code = %s
```

Get the average credit score of a prison block

### Prison Block with the lowest Avg Credit Score
Query:
```
SELECT Block_Code, AVG(Credit_Score) AS Score FROM Prisoner
    GROUP BY Block_Code ORDER BY Score ASC LIMIT 1
```
retrieve the prison block with the lowest average credit score

### Retrieve all prisoners of a given block

SQL Query:
```
SELECT * FROM Prisoners WHERE Block_Code = %
```

Fetches all the prisoners of the specified block

### Retreive Prisoners to be executed
SQL Query:
```
ELECT CONCAT(p.First_Name, " ", p.Last_Name) AS Name FROM Prisoners WHERE 
    Execution_Date > CURRENT_DATE AND Execution_Date <= DATE_ADD(CURRENT_DATE, INTERVAL 1 week)
```
Get the names of the prisoners to be executed in a week



### Search for prisoner by Name
SQL QUERY:
```
SELECT * FROM Prisoner WHERE Name LIKE %s
```
Search for the prisoners whose names start with the input

### Change a staff's assigned block
SQL Query:
```
        update Staff
        set Prison_Block = %s
        where Staff_Id = %s
```
Reassign a staff to some other prison block
