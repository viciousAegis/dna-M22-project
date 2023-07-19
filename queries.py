import pymysql
import pymysql.cursors
import datetime

import utils


# update
def update_staff_block(cursor: pymysql.cursors.DictCursor):
    """Change a staff's assigned block"""
    utils.printNewL()
    blockcode = input("Enter the block code: ")
    staffid = input("Enter the staff id: ")
    up = f"""
        update Staff
        set Prison_Block = %s
        where Staff_Id = %s
    """
    cursor.execute(up, (blockcode, staffid))


    if cursor.rowcount == 1:
        print(f"Updated the assigned block of staff with id: {staffid}")
    else:
        print("No such staff exists")



def addPrisoner(cursor: pymysql.cursors.DictCursor):
    """Adds a new prisoner to the Jail"""

    cursor.execute("SELECT Security_Level FROM Prison_Block;")
    blocks = [x["Security_Level"] for x in cursor.fetchall()]
    
    query = """
    INSERT INTO Prisoner (Block_Code, Cell_Number, Aadhar_Card, First_Name, Last_Name, Crime,
        Address, Execution_Date, Release_Date, Incarceration_Date)
    VALUES
    (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    utils.printNewL();

    print("Choose Prison Block:")
    block_code = input(repr(blocks)+"\n")
    cell_no = input("Cell Number: ")
    aadhar = input("Aadhar Number: ")
    first_name = input("First name: ")
    last_name = input("Last name: ")
    address = input("Address: ")
    crime = input("Crime Committed: ")
    incarceration_date = datetime.date.today()
    
    isExecuted = (input("Is the prisoner on the death row (y/n): ") == "y")

    execution_date = None
    release_date = None
    if isExecuted:
        execution_date = utils.parseddmmyy(input("Execution date (dd-mm-YYYY): "))
    else:
        release_date = utils.parseddmmyy(input("Release date (dd-mm-YYYY): "))


    cursor.execute(query, (block_code, cell_no, aadhar, first_name, last_name, crime, address, execution_date, release_date, incarceration_date))
    cursor.execute("UPDATE Prison_Cell SET Occupancy_Status = Occupancy_Status + 1 WHERE Cell_Number = %s", (cell_no,))
    
    print(f"Prisoner {first_name} {last_name} added successfully to block {block_code} cell {cell_no}")



def getPrisonersOfABlock(cursor: pymysql.cursors.DictCursor):
    """Get data of prisoners of a specific block"""

    print("Select Block:")
    cursor.execute("SELECT Security_Level FROM Prison_Block;")
    blocks = [x["Security_Level"] for x in cursor.fetchall()]
    block = input(str(blocks))

    query = """SELECT * FROM Prisoner WHERE Block_Code = %s"""

    cursor.execute(query, (block,))

    # query2 = """SELECT * FROM PRISONER LIMIT 1"""
    # cursor.execute(query2)
    columns = [x[0] for x in cursor.description]
    utils.printNewL()
    for key in columns:
            print(f"{key}", end="\t")

    print()
    for x in cursor:
        # print(x)
        for key in x:
            print(f"{x[key]}", end="\t")
        print()


def retrivePrisonersToBeExecuted(cursor: pymysql.cursors.DictCursor):
    """Get the names of the prisoners to be executed in a week"""
    query = """SELECT CONCAT(p.First_Name, " ", p.Last_Name) AS Name, Execution_Date FROM Prisoner AS p WHERE 
    Execution_Date > CURRENT_DATE AND Execution_Date <= DATE_ADD(CURRENT_DATE, INTERVAL 1 week)
    """

    cursor.execute(query)
    utils.printNewL();
    columns = [x[0] for x in cursor.description]
    for key in columns:
        print(f"{key}", end="\t")
    print()
    for row in cursor:
        print(f'{row["Name"]}\t{row["Execution_Date"]}')

    
def getAvgCreditScore(cursor: pymysql.cursors.DictCursor):
    """Get the average credit score of a prison block"""
    query = """SELECT AVG(Credit_Score) AS Cr FROM Prisoner WHERE Block_Code = %s"""
    
    utils.printNewL();
    print("Select Block:")
    cursor.execute("SELECT Security_Level FROM Prison_Block;")
    blocks = [x["Security_Level"] for x in cursor.fetchall()]
    block = int(input(f"{str(blocks)}\n"))

    cursor.execute(query, (block,))

    print(f"Average Score of Block {block}: " + str(cursor.fetchone()['Cr']))

def searchPrisoners(cursor: pymysql.cursors.DictCursor):
    """Search for the prisoners whose names start with the input"""

    query = """SELECT * FROM Prisoner WHERE FIrst_Name LIKE %s"""

    prefix = (input("Starting with: ")) + '%'

    cursor.execute(query, (prefix,))
    columns = [x[0] for x in cursor.description]
    for key in columns:
        print(f"{key}", end="\t")
    print()
    for row in cursor:
        for key in row:
            print(f"{row[key]}", end="\t")
        print()



def getLowestBlock(cursor: pymysql.cursors.DictCursor):
    """Find the prison block with the lowest average credit score"""

    query = """SELECT Block_Code, AVG(Credit_Score) AS Score FROM Prisoner
    GROUP BY Block_Code ORDER BY Score ASC LIMIT 1"""

    cursor.execute(query)
    utils.printNewL();
    print("Block: " + cursor.fetchone()['Block_Code'])


def getAvgCreditOccupancy(cursor: pymysql.cursors.DictCursor):
    """Get the average credit score for each Occupancy type"""

    query = """SELECT Occupancy_Type, AVG(Credit_Score) FROM Prisoner As Pr 
        INNER JOIN Prison_Cell AS PC ON Pr.Cell_Number = PC.Cell_Number 
        INNER JOIN Prison_Occupancy AS PO ON Pr.Cell_Number = PO.Cell_Number 
        GROUP BY PO.Occupancy_Type
    """

    cursor.execute(query)
    utils.printNewL();
    print("Occupancy Type | Average Credit Score")
    for x in cursor:
        print(f"\t{x['Occupancy_Type']}  :  {x['AVG(Credit_Score)']}")
        


def addAWeapon(cursor: pymysql.cursors.DictCursor):
    """Add a new weapon"""
    query = """INSERT INTO Gun_Servicing VALUES (%s, %s)"""
    utils.printNewL()
    with cursor:
        name = input("Enter Weapon Name: ")
        servicing_period = int(input("Enter the Servicing Period in days: "))
        cursor.execute(query, (name, servicing_period))
        print(f"Added {name} successfully")
    

def addANewRehabActivity(cursor: pymysql.cursors.DictCursor):
    """Add a new rehab activity"""
    query = """INSERT INTO Rehab_Activity VALUES (%s, %s)"""

    cursor.execute("SELECT DISTINCT(Center_Number) FROM Rehab_Center")

    centers = [x["Center_Number"] for x in cursor.fetchall()]
    utils.printNewL()
    print("Select a center:")
    center = input(str(centers) + ":\n")
    activity = input("Enter the activity type: ")

    cursor.execute(query, (center, activity))
    print(f"Added {activity} to center {center} successfully")

    
def deletePrisoner(cursor: pymysql.cursors.DictCursor):
    """Delete a Prisoner"""
    query = """DELETE FROM Prisoner WHERE Block_Code = %s AND Prisoner_ID = %s"""

    utils.printNewL()
    cursor.execute("SELECT Security_Level FROM Prison_Block;")
    blocks = [x["Security_Level"] for x in cursor.fetchall()]
    print("Choose Prison Block:")
    block_code = input(repr(blocks)+'\n')
    pid = input("Enter the Prisoner ID: ")

    cursor.execute(query, (block_code, pid))
    if(cursor.rowcount == 0):
        print("No such prisoner found")
    else:
        print(f"Deleted prisoner {pid} from block {block_code} successfully")

