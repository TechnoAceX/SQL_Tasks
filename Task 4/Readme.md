# Assignment 4: Subject Allotment System

This project demonstrates a stored procedure that automates the allocation of subjects to students based on their preferences and GPA, as part of an internship SQL assignment.

---

## ✅ Objective

To assign students to one of their preferred subjects following the rules:

- Each student selects *5 subjects* in order of preference.
- Each subject has *limited seats*.
- Students are allotted based on *highest GPA first*.
- A student receives the *first available subject* from their preferences.
- If none of the 5 subjects are available, the student is marked *unallotted*.

---

## 🧱 Database Tables

**1. StudentDetails**  
Contains student info and GPA

**2. SubjectDetails**  
Subject names and seat availability

**3. StudentPreference**  
Stores 5 preferences per student

**4. Allotments**  
Output: student and subject mapping

**5. UnallotedStudents**  
Output: list of students who didn’t get any preferred subject

---

## 🛠 Stored Procedure: AllocateSubjects

- Uses a cursor to iterate over students sorted by GPA (descending)
- Checks preferences 1 to 5
- Allots the first available subject
- Updates seat count
- Inserts into *Allotments* or *UnallotedStudents*

---

## ▶️ How to Run

1. Execute table creation and sample `INSERT` statements.
2. Run the stored procedure:

## 📁 Files Included

Subject_Allotment.sql – Contains:

Table creation
Sample data insertion
Stored procedure
Execution and result queries
README.md – Contains explanation of logic, table structures, and execution guide.
