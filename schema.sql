DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff(
    Staff_Id INT AUTO_INCREMENT,
    Aadhar_Card INT NOT NULL UNIQUE,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Start_Date DATE NOT NULL,
    Address TEXT NOT NULL,
    Prison_Block CHAR(1),
    Supervisor_ID INT,
    CONSTRAINT PK_Staff PRIMARY KEY (Staff_Id)
);

DROP TABLE IF EXISTS Admin_Officer;
CREATE TABLE Admin_Officer(
    Admin_ID INT NOT NULL,
    Center_Number INT NOT NULL,
    Prison_Block CHAR(1) NOT NULL,
    CONSTRAINT PK_Admin_Officer PRIMARY KEY (Admin_ID)
);

DROP TABLE IF EXISTS Prison_Guard;
CREATE TABLE Prison_Guard(
    Guard_ID INT NOT NULL,
    Prison_Block CHAR(1) NOT NULL,
    CONSTRAINT PK_Prison_Guard PRIMARY KEY (Guard_ID)
);

DROP TABLE IF EXISTS Prisoner;
CREATE TABLE Prisoner (
    Block_Code CHAR(1) NOT NULL,
    Cell_Number INT NOT NULL,
    Prisoner_Id INT NOT NULL,
    Aadhar_Card INT NOT NULL,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Crime VARCHAR(100) NOT NULL,
    Credit_Score INT DEFAULT 0,
    Address TEXT NOT NULL,
    Execution_Date DATE,
    Release_Date DATE,
    Incarceration_Date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT PK_Prisoner PRIMARY KEY (Block_Code, Prisoner_Id)
);

CREATE TRIGGER Prisoner_PrisonerID BEFORE INSERT ON Prisoner 
FOR EACH ROW SET NEW.Prisoner_Id = (SELECT IFNULL(MAX(Prisoner_ID), 0) + 1 
	FROM Prisoner WHERE Block_Code = NEW.Block_Code);

DROP TABLE IF EXISTS Prison_Block;
CREATE TABLE Prison_Block(
    Security_Level CHAR(1) NOT NULL,
    CONSTRAINT PK_PBlock PRIMARY KEY (Security_Level)
);

DROP TABLE IF EXISTS Weapon;
CREATE TABLE Weapon(
    Guard_ID INT NOT NULL,
    Weapon_Model VARCHAR(20) NOT NULL,
    Last_Service DATE NOT NULL,
    CONSTRAINT PK_Weapon PRIMARY KEY (Guard_ID, Weapon_Model)
);

DROP TABLE IF EXISTS Dependent;
CREATE TABLE Dependent(
    Block_Code CHAR(1) NOT NULL,
    Prisoner_Id INT NOT NULL,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Relation VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Dependent PRIMARY KEY (Block_Code, Prisoner_Id, First_Name, Last_Name)
);


DROP TABLE IF EXISTS Prison_Cell;
CREATE TABLE Prison_Cell(
    Security_Level CHAR(1) NOT NULL,
    Cell_Number INT NOT NULL,
    Occupancy_Status INT DEFAULT 0,
    CONSTRAINT PK_Prison_Cell PRIMARY KEY (Security_Level, Cell_Number)
);


DROP TABLE IF EXISTS Rehab_Center;
CREATE TABLE Rehab_Center(
    Security_Level CHAR(1) NOT NULL,
    Center_Number INT NOT NULL,
    CONSTRAINT PK_Rehab_Center PRIMARY KEY (Security_Level, Center_Number)
);
CREATE TRIGGER Rehab_Center_Center_Number BEFORE INSERT ON Rehab_Center 
FOR EACH ROW SET NEW.Center_Number = (SELECT IFNULL(MAX(Center_Number), 0) + 1 
	FROM Rehab_Center WHERE Security_Level = NEW.Security_Level);


DROP TABLE IF EXISTS Rehab_Activity;
CREATE TABLE Rehab_Activity(
    Center_Number INT NOT NULL,
    Activity_Type VARCHAR(50) NOT NULL,
    CONSTRAINT PK_RehabAct PRIMARY KEY (Center_Number, Activity_Type)
);

DROP TABLE IF EXISTS Monitors;
CREATE TABLE Monitors (
    Admin_ID INT NOT NULL,
    Block_Code CHAR(1) NOT NULL,
    Center_Number INT NOT NULL,
    Prisoner_Id INT NOT NULL,
    CONSTRAINT PK_Monitor PRIMARY KEY (Admin_ID, Block_Code, Prisoner_Id, Center_Number)
);

DROP TABLE IF EXISTS Gun_Servicing;
CREATE TABLE Gun_Servicing(
    Weapon_Model VARCHAR(20) NOT NULL,
    Servicing_Period INT NOT NULL,
    CONSTRAINT PK_Gun_Servicing PRIMARY KEY (Weapon_Model)
);

DROP TABLE IF EXISTS Prison_Occupancy;
CREATE TABLE Prison_Occupancy(
    Cell_Number INT NOT NULL AUTO_INCREMENT,
    Occupancy_Type INT NOT NULL,
    CONSTRAINT PK_POccupancy PRIMARY KEY (Cell_Number)
);





ALTER TABLE Staff 
    ADD CONSTRAINT FK_Staff_PBlock FOREIGN KEY (Prison_Block) 
        REFERENCES Prison_Block(Security_Level),
    ADD CONSTRAINT FK_Staff_Supervisor FOREIGN KEY (Supervisor_ID)
        REFERENCES Admin_Officer(Admin_ID);

ALTER TABLE Admin_Officer
    ADD CONSTRAINT FK_Admin_ID_Staff FOREIGN KEY (Admin_ID)
        REFERENCES Staff(Staff_Id),
    ADD CONSTRAINT PK_Admin_Rehab_Center FOREIGN KEY (Prison_Block, Center_Number)
        REFERENCES Rehab_Center(Security_Level, Center_Number);

ALTER TABLE Prison_Guard
    ADD CONSTRAINT FK_Guard_ID_Staff FOREIGN KEY (Guard_ID)
        REFERENCES Staff(Staff_Id),
    ADD CONSTRAINT FK_PGuard_PBlock FOREIGN KEY (Prison_Block)
        REFERENCES Prison_Block(Security_Level);

ALTER TABLE Prisoner
    ADD CONSTRAINT FK_Prisoner_PCell FOREIGN KEY (Block_Code, Cell_Number)
        REFERENCES Prison_Cell(Security_Level, Cell_Number);

ALTER TABLE Weapon
    ADD CONSTRAINT FK_Weapon_Guard FOREIGN KEY (Guard_ID)
        REFERENCES Prison_Guard(Guard_ID),
    ADD CONSTRAINT FK_Weapon_Model FOREIGN KEY (Weapon_Model)
        REFERENCES Gun_Servicing(Weapon_Model);

ALTER TABLE Dependent
    ADD CONSTRAINT FK_Dependent_Prisoner FOREIGN KEY (Block_Code, Prisoner_Id)
        REFERENCES Prisoner(Block_Code, Prisoner_Id)
		ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Prison_Cell
    ADD CONSTRAINT FK_PCell_PBlock FOREIGN KEY (Security_Level) 
        REFERENCES Prison_Block(Security_Level),
    ADD CONSTRAINT FK_CellNumber FOREIGN KEY (Cell_Number)
        REFERENCES Prison_Occupancy(Cell_Number);

ALTER TABLE Rehab_Center
    ADD CONSTRAINT FK_Rehab_Center_PBlock FOREIGN KEY (Security_Level)
        REFERENCES Prison_Block(Security_Level),
    ADD CONSTRAINT FK_RehabAct FOREIGN KEY (Center_Number)
        REFERENCES Rehab_Activity(Center_Number);

ALTER TABLE Monitors
    ADD CONSTRAINT FK_Monitor_Center FOREIGN KEY (Block_Code, Center_Number)
        REFERENCES Rehab_Center(Security_Level, Center_Number),
    ADD CONSTRAINT FK_Monitor_Prisoner FOREIGN KEY (Block_Code, Prisoner_Id)
        REFERENCES Prisoner(Block_Code, Prisoner_Id);

DROP TRIGGER IF EXISTS Credit_On_Update;
CREATE TRIGGER Credit_On_Update
    AFTER UPDATE ON Prisoner FOR EACH ROW
    UPDATE Prison_Block SET Total_Credit = Total_Credit - OLD.Credit_Score + NEW.Credit_Score;


CREATE VIEW Prison_Block_View
AS SELECT Block_Code AS Prison_Block, Count(*), SUM(Credit_Score) FROM Prisoner GROUP BY Prison_Block;