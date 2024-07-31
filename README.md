# Admin App for Head of Department

## Overview
The Admin App is designed exclusively for the Head of Department (HOD) to manage and control the activities within their department. This app allows the HOD to oversee teachers, students, subjects, and class routines, ensuring efficient department management. The app is developed using the Flutter framework and is available on Android.

## Features

### Login
- **HOD Login:**
    - The HOD logs in using their credentials.
    - Only HODs have access; other teachers cannot log in.

### Main Tabs
After logging in, the HOD can see four tabs, each with card view functionality:

1. **Students**
2. **Teachers**
3. **Subjects**
4. **Routine**

### Students Tab
When the HOD clicks the Students card view, they see the following features:
- **Add Student:** Add new students to the department.
- **Remove Student:** Remove students from the department.
- **Update Student:** Update existing student information.
- **Remove Student From Last Semester:** Remove students who have completed the last semester.
- **Student Transfer:** Transfer students from the current semester to the next semester.

### Teachers Tab
When the HOD clicks the Teachers card view, they see the following features:
- **Remove Teacher:** Remove a teacher from the department.
- **Update Teacher:** Update existing teacher information.

### Subjects Tab
When the HOD clicks the Subjects card view, they see the following features:
- **Add New Subject:** Add new subjects to the department.
- **Remove Subject:** Remove existing subjects.
- **Update Subject:** Update information for existing subjects.

### Routine Tab
When the HOD clicks the Routine card view, they see the following features:
- **Add Class:** Add new classes to the routine.
- **View Routine:** View the current class routine.
- **Update Routine:** Update the class routine.

### Logout
- **Logout Button:** Allows the HOD to log out of the app securely.

## User Interface
### Login Page
- Fields: Username, Password
- Login button to access the app.

### Main Interface
- **Card View Tabs:**
    - **Students:** Manage student information and actions.
    - **Teachers:** Manage teacher information and actions.
    - **Subjects:** Manage subjects and related actions.
    - **Routine:** Manage class routines and related actions.

- **Logout Button:** Accessible from the main interface to log out.

## Technology Stack
- **Framework:** Flutter
- **Platform:** Currently available for Android

## Functionality
1. **Login:**
    - HOD enters credentials and logs in.
    - Only HODs are authenticated to access the app.

2. **Students Management:**
    - Add, remove, update, and transfer students.
    - Remove students from the last semester.

3. **Teachers Management:**
    - Remove and update teacher information.

4. **Subjects Management:**
    - Add new subjects, remove existing subjects, and update subject information.

5. **Routine Management:**
    - Add new classes, view the routine, and update the routine.

6. **Logout:**
    - Securely log out of the app using the logout button.

## Conclusion
The Admin App for HODs provides a comprehensive and efficient solution for managing departmental activities. With exclusive access, the HOD can oversee and control student, teacher, subject, and routine information, ensuring smooth departmental operations. Built with Flutter, the app is currently available for Android users.
