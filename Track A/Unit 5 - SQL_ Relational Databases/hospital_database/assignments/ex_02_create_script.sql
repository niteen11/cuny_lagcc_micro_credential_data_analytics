DROP TABLE IF EXISTS Affiliated_With;
CREATE TABLE Affiliated_With (
  Physician INTEGER NOT NULL,
  Department INTEGER NOT NULL,
  PrimaryAffiliation BOOLEAN NOT NULL,
  CONSTRAINT fk_Affiliated_With_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Affiliated_With_Department_DepartmentID FOREIGN KEY(Department) REFERENCES Department(DepartmentID),
  PRIMARY KEY(Physician, Department)
);

DROP TABLE IF EXISTS Procedures;
CREATE TABLE Procedures (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Cost REAL NOT NULL
);

DROP TABLE IF EXISTS Trained_In;
CREATE TABLE Trained_In (
  Physician INTEGER NOT NULL,
  Treatment INTEGER NOT NULL,
  CertificationDate TIMESTAMP NOT NULL,
  CertificationExpires TIMESTAMP NOT NULL,
  CONSTRAINT fk_Trained_In_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Trained_In_Procedures_Code FOREIGN KEY(Treatment) REFERENCES Procedures(Code),
  PRIMARY KEY(Physician, Treatment)
);

DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Address VARCHAR(30) NOT NULL,
  Phone VARCHAR(30) NOT NULL,
  InsuranceID INTEGER NOT NULL,
  PCP INTEGER NOT NULL,
  CONSTRAINT fk_Patient_Physician_EmployeeID FOREIGN KEY(PCP) REFERENCES Physician(EmployeeID)
);