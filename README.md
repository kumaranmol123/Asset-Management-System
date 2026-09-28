[Uploading README.md…]()
# Asset Management System

A web-based **Asset Management System** developed using Java, JSP, Servlets, JDBC, MySQL, HTML, CSS, and JavaScript.

The system is designed to manage employees, company assets, asset assignments, asset status, maintenance records, and assignment history through a centralized web application.

## Features

- User Login
- Dashboard
- Employee Registration
- Employee Management
- Asset Registration
- Asset Management
- Assign Assets to Employees
- Update Asset Status
- Asset Maintenance Tracking
- Assignment History
- Sidebar Navigation
- MySQL Database Integration
- JDBC-based database operations

## Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend development |
| JSP | Dynamic web pages |
| Servlets | Request handling and business logic |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML | Page structure |
| CSS | Styling and layout |
| JavaScript | Client-side interaction |
| Maven | Project and dependency management |
| Apache Tomcat | Web application server |
| IntelliJ IDEA | Development environment |

## Project Modules

### 1. Login
Provides authentication for users before accessing the asset management system.

### 2. Dashboard
Provides the main interface for accessing different asset management functions.

### 3. Employee Management
Stores and manages employee information such as employee ID, name, department, designation, and contact.

### 4. Asset Management
Stores and manages asset information including asset code, type, brand, model, serial number, purchase date, department, location, status, and remarks.

### 5. Asset Assignment
Assigns assets to employees and records assigned date, return date, and assignment status.

### 6. Asset Status Management
Updates asset status such as:
- Available
- Assigned
- Defective
- Under Maintenance

### 7. Maintenance
Records asset maintenance details including problem, action taken, maintenance date, and status.

### 8. Assignment History
Displays previous and current asset assignment records.

## Database Design

The project uses MySQL.

### Main Tables

```text
users
employees
assets
asset_assignment
maintenance
```

### Relationships

```text
employees
    |
    | employee_id
    v
asset_assignment
    ^
    |
    | asset_id
    |
assets
    |
    | asset_id
    v
maintenance
```

The `asset_assignment` table connects employees with assets using foreign keys.

## Database Setup

Create the database:

```sql
CREATE DATABASE asset_management;
USE asset_management;
```

Create the required tables using the SQL script included in the project.

Important relationships:

```text
assets.asset_id
        ↓
asset_assignment.asset_id

employees.employee_id
        ↓
asset_assignment.employee_id

assets.asset_id
        ↓
maintenance.asset_id
```

## Project Structure

```text
AssetManagement_System/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── ...
│       │
│       └── webapp/
│           ├── dashboard.jsp
│           ├── sidebar.jsp
│           ├── sidebar.css
│           ├── register.jsp
│           ├── add-asset.jsp
│           ├── employees.jsp
│           ├── assets.jsp
│           ├── assign-asset.jsp
│           ├── update-status.jsp
│           ├── maintenance.jsp
│           └── assignment-history.jsp
│
├── pom.xml
├── .gitignore
└── README.md
```

## OOP Concepts

The Java backend is organized using object-oriented programming principles.

### Encapsulation
Model classes such as `Employee`, `Asset`, `AssetAssignment`, and `Maintenance` use private fields with getters and setters.

### Classes and Objects
Database entities are represented as Java classes and their data is handled through objects.

### Abstraction
DAO classes hide JDBC and SQL implementation details from Servlets.

## How to Run

### Prerequisites

- JDK
- IntelliJ IDEA
- MySQL
- Apache Tomcat
- Maven

### Steps

1. Clone the repository:

```bash
git clone https://github.com/YOUR-USERNAME/Asset-Management-System.git
```

2. Open the project in IntelliJ IDEA.

3. Configure MySQL.

4. Create the `asset_management` database.

5. Execute the project's SQL script.

6. Configure the database connection in the Java backend.

7. Configure Apache Tomcat.

8. Build the Maven project:

```bash
mvn clean package
```

9. Deploy/run the application using Tomcat.

10. Open the application in a browser.

## Database Configuration

Example JDBC configuration:

```java
String url = "jdbc:mysql://localhost:3306/asset_management";
String username = "root";
String password = "YOUR_PASSWORD";
```

**Do not upload your real database password to GitHub.**

Use a local configuration file or environment variables for sensitive credentials.

## Future Enhancements

- Role-based access control
- Search and advanced filtering
- Asset return workflow
- Automatic asset availability updates
- Dashboard statistics and charts
- Email notifications
- PDF/Excel report generation
- Improved validation and error handling
- Responsive mobile interface

## Author

**Kumar Anmol**

B.Tech Computer Science and Engineering

## License

This project is developed for educational and project purposes.
