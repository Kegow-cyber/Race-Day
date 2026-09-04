# Race Day - Event Management System

A comprehensive race event management platform built with **ASP.NET MVC** and a modern **backend API**. The system enables seamless organization and participation in race events with role-based functionality for organizers and participants.

## Overview

Race Day is a full-stack web application designed to streamline the planning, enrollment, and management of race events. Whether you're organizing a community fun run, competitive sprint, or marathon, this platform provides the tools needed to manage participants, track enrollments, and record race results.

## Features

- **Event Management**: Create and manage race events with customizable categories
- **User Roles**: Specialized functionality for Participants and Organisers
- **Event Enrollment**: Streamlined enrollment process for race participants
- **Results Tracking**: Record and track participant race times and performance
- **Category Management**: Organize races by age groups and difficulty levels
- **User Profiles**: Comprehensive user management system with role-based access

## Technology Stack

- **Frontend**: ASP.NET MVC
- **Backend**: RESTful API
- **Database**: SQL Server (RaceEventManagementDB)
- **Language**: C#, SQL

## User Roles

### Participant
Participants are the runners and athletes competing in race events. They can:
- Create and manage their user profiles
- Browse available race events
- Enroll in race events matching their category
- View their race results and performance history
- Track their personal best times

### Organiser
Organisers are event coordinators and administrators who manage the platform. They can:
- Create and configure new race events
- Manage event categories and enrollment periods
- Monitor participant enrollments
- Record and publish race results
- Oversee event logistics and coordination

## Database Schema

The application uses a normalized SQL Server database with the following core entities:

- **UserProfile**: Base user information with role assignment
- **Participant**: Participant-specific details (age, height, gender, participation history)
- **Organiser**: Organiser-specific information (department, profile image)
- **Category**: Race categories based on age and experience level
- **RaceEvent**: Individual race events linked to categories
- **Enrolment**: Participant enrollment records for specific events
- **Result**: Race performance data and timing information

For detailed database structure and schema documentation, see `docs/SQLQuery-create database.sql`.

## Documentation

### Database Documentation
- **Location**: `/docs/SQLQuery-create database.sql`
- **Contents**: Complete database schema with table definitions, constraints, and sample data
- Includes CREATE TABLE statements for all entities
- Sample INSERT statements for testing and development

## Getting Started

1. Clone the repository
2. Set up the SQL Server database using the schema provided in `/docs/SQLQuery-create database.sql`
3. Configure the connection string in your ASP.NET MVC application
4. Run the application and navigate to the home page
5. Log in with appropriate role (Participant or Organiser)

## API Endpoints

The backend API provides RESTful endpoints for:
- User authentication and profile management
- Event CRUD operations
- Enrollment management
- Results submission and retrieval
- Category management

## CI/CD Workflows (GitHub Actions)
<img src="" />

## References
GitHub Copilot was used in some stages of writing this README file.

