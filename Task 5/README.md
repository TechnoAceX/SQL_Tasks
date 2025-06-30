# 🎓 SQL Subject Allotment System

This project implements a SQL-based system to automate the allocation of Open Elective Subjects to students based on their GPA and subject preferences.

---

## 📌 Problem Statement

Each student provides **5 subject preferences**. The allotment should be:
- Based on **GPA (highest first)**
- Each subject has **limited seats**
- A student is allotted the **first subject with available seats** from their preference list
- If **no preferences are available**, the student is marked **unallotted**

---

## 🧱 Database Schema

### 1. `StudentDetails`
| Column       | Type         |
|--------------|--------------|
| StudentId    | INT (PK)     |
| StudentName  | VARCHAR(100) |
| GPA          | DECIMAL(4,2) |
| Branch       | VARCHAR(10)  |
| Section      | VARCHAR(10)  |

### 2. `SubjectDetails`
| Column         | Type         |
|----------------|--------------|
| SubjectId      | VARCHAR(10) (PK) |
| SubjectName    | VARCHAR(100) |
| MaxSeats       | INT          |
| RemainingSeats | INT          |

### 3. `StudentPreference`
| Column     | Type         |
|------------|--------------|
| StudentId  | INT (FK)     |
| SubjectId  | VARCHAR(10) (FK) |
| Preference | INT (1–5)    |

### 4. `Allotments`
| Column     | Type         |
|------------|--------------|
| SubjectId  | VARCHAR(10)  |
| StudentId  | INT          |

### 5. `UnallotedStudents`
| Column     | Type         |
|------------|--------------|
| StudentId  | INT (PK)     |

---

## 🛠️ Stored Procedure: `AllocateSubjects`

This procedure:
- Iterates through students in **descending GPA**
- For each student, checks preferences from 1 to 5
- Allots the **first subject with available seats**
- Updates `RemainingSeats`
- If no seat is available in any preferred subject, inserts into `UnallotedStudents`

---

## 🚀 How to Use

1. Run all `CREATE TABLE` and `INSERT` statements to setup the database
2. Execute the procedure:
```sql
EXEC AllocateSubjects;
