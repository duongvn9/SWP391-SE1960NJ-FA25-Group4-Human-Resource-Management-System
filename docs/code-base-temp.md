# 🏢 HRMS - Cấu trúc dự án

## Backend Structure

```
src/main/java/group4/hrms/
├── config/          # System configuration (database, security)
├── controller/      # Presentation Layer (Servlets)
│   ├── auth/       # Authentication controllers
│   ├── attendance/ # Time tracking controllers
│   ├── employee/   # Employee management controllers
│   └── payroll/    # Payroll management controllers
├── service/         # Business Logic Layer
│   ├── auth/       # Authentication services
│   └── employee/   # Employee services
├── repository/      # Data Access Layer
│   └── employee/   # Employee data access
├── entity/          # Domain Models (JPA entities)
├── dto/            # Data Transfer Objects
│   ├── request/    # Request DTOs
│   └── response/   # Response DTOs
├── mapper/         # Entity ↔ DTO mapping
├── exception/      # Custom Exception hierarchy
├── filter/         # Servlet Filters (auth, CORS, etc.)
├── util/           # Utility classes
└── constants/      # Application constants
```

## Frontend Structure

```
src/main/webapp/
├── assets/         # Static resources
│   ├── css/       # Custom stylesheets
│   ├── js/        # JavaScript files
│   └── images/    # Images and icons
├── WEB-INF/
│   ├── views/     # JSP Pages
│   │   ├── auth/          # Authentication pages
│   │   ├── dashboard/     # Dashboard pages
│   │   ├── attendance/    # Time tracking views
│   │   ├── identity/      # Employee profile views
│   │   ├── leave/         # Leave management views
│   │   ├── payroll/       # Payroll views
│   │   ├── recruitment/   # Hiring process views
│   │   ├── requesttask/   # Task request views
│   │   ├── contract/      # Contract management views
│   │   ├── system/        # System admin views
│   │   └── layout/        # Shared components
│   ├── web.xml    # Servlet configuration
│   └── beans.xml  # CDI configuration
└── META-INF/      # Application metadata
    └── context.xml # DataSource configuration
```

## Resources Structure

```
src/main/resources/
├── application.properties # Database configuration
├── logback.xml            # Logging configuration
└── META-INF/
    └── persistence.xml    # JPA configuration
```
