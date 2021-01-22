
DROP TABLE IF EXISTS Prescribes;
CREATE TABLE Prescribes (
  Physician INTEGER NOT NULL,
  Patient INTEGER NOT NULL, 
  Medication INTEGER NOT NULL, 
  Date TIMESTAMP NOT NULL,
  Appointment INTEGER,  
  Dose VARCHAR(30) NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, Date),
  CONSTRAINT fk_Prescribes_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Prescribes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Prescribes_Medication_Code FOREIGN KEY(Medication) REFERENCES Medication(Code),
  CONSTRAINT fk_Prescribes_Appointment_AppointmentID FOREIGN KEY(Appointment) REFERENCES Appointment(AppointmentID)
);

DROP TABLE IF EXISTS Block;
CREATE TABLE Block (
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  PRIMARY KEY(BlockFloor, BlockCode)
); 

DROP TABLE IF EXISTS Room;
CREATE TABLE Room (
  RoomNumber INTEGER PRIMARY KEY NOT NULL,
  RoomType VARCHAR(30) NOT NULL,
  BlockFloor INTEGER NOT NULL,  
  BlockCode INTEGER NOT NULL,  
  Unavailable BOOLEAN NOT NULL,
  CONSTRAINT fk_Room_Block_PK FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode)
);

DROP TABLE IF EXISTS On_Call;
CREATE TABLE On_Call (
  Nurse INTEGER NOT NULL,
  BlockFloor INTEGER NOT NULL, 
  BlockCode INTEGER NOT NULL,
  OnCallStartDate TIMESTAMP NOT NULL,
  OnCallEndDate TIMESTAMP NOT NULL,
  PRIMARY KEY(Nurse, BlockFloor, BlockCode, OnCallStartDate, OnCallEndDate),
  CONSTRAINT fk_OnCall_Nurse_EmployeeID FOREIGN KEY(Nurse) REFERENCES Nurse(EmployeeID),
  CONSTRAINT fk_OnCall_Block_Floor FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode) 
);

DROP TABLE IF EXISTS Stay;
CREATE TABLE Stay (
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
  Room INTEGER NOT NULL,
  StayStartDate TIMESTAMP NOT NULL,
  StayEndDate TIMESTAMP NOT NULL,
  CONSTRAINT fk_Stay_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Stay_Room_Number FOREIGN KEY(Room) REFERENCES Room(RoomNumber)
);

DROP TABLE IF EXISTS Undergoes;
CREATE TABLE Undergoes (
  Patient INTEGER NOT NULL,
  Procedures INTEGER NOT NULL,
  Stay INTEGER NOT NULL,
  DateUndergoes TIMESTAMP NOT NULL,
  Physician INTEGER NOT NULL,
  AssistingNurse INTEGER,
  PRIMARY KEY(Patient, Procedures, Stay, DateUndergoes),
  CONSTRAINT fk_Undergoes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Undergoes_Procedures_Code FOREIGN KEY(Procedures) REFERENCES Procedures(Code),
  CONSTRAINT fk_Undergoes_Stay_StayID FOREIGN KEY(Stay) REFERENCES Stay(StayID),
  CONSTRAINT fk_Undergoes_Physician_EmployeeID FOREIGN KEY(Physician) REFERENCES Physician(EmployeeID),
  CONSTRAINT fk_Undergoes_Nurse_EmployeeID FOREIGN KEY(AssistingNurse) REFERENCES Nurse(EmployeeID)
);