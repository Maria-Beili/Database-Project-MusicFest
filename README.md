
Music Festival Database Project
Overview
This project consists of a comprehensive database design and implementation for a music festival management system, developed as a series of labs for academic purposes. The repository includes different components, each focusing on distinct aspects of database design, data manipulation, and advanced SQL programming.

The goal is to build and optimize a database system that can manage various entities involved in a music festival, such as festivalgoers, staff, artists, products, vendors, shows, and stages. The project is divided into three main labs:

LAB00: Introduction to database design.
LAB01-01: Basic database modeling, creation, and population.
LAB01-02: Advanced database querying and procedural programming.
Repository Structure
The repository is structured as follows:

README.md: This document, providing an overview of the project.
LAB00: Files and scripts related to the conceptual design of the database.
LAB01-01: SQL scripts and documentation for the initial implementation and data insertion.
LAB01-02: Advanced SQL programming, including triggers, procedures, and optimization scripts.
models/: Contains the conceptual and relational models in PDF format.
sql/: SQL scripts for creating, populating, and exporting the database.

LAB Descriptions
LAB00: Intro to Database Design
The goal of this initial lab is to create a Conceptual Model of the music festival scenario using the Entity-Relationship (ER) model. This model serves as the basis for the following labs.

Key steps include:

Entity Identification: Defining key entities such as Person, Staff, Festival, Stage, Product, Provider, and more.
Relationship Mapping: Establishing relationships like Attends, WorksAt, Sells, Organizes, and Performs.
Attribute Definition: Specifying attributes for each entity and relationship, ensuring a detailed representation of the festival's data.
LAB01-01: Database Design, DDL, and DML
This lab focuses on transitioning the conceptual model into a Relational Model and implementing it using SQL.

Goals:
Design the Relational Model: Convert the ER diagram into relational tables with proper primary and foreign keys.
Implement the Database Schema: Use Data Definition Language (DDL) commands to create tables and enforce constraints.
Populate the Database: Insert data using Data Manipulation Language (DML) commands from provided .csv files.
Export the Database: Create an export script to back up the complete database.
Outputs:
music_festival_db_deploy.sql: Script to create the database schema.
music_festival_db_population.sql: Script to populate the database with initial data.
Files Submitted:
music_festival_db_models.pdf: PDF with the conceptual and relational models.
SQL scripts: music_festival_db_deploy.sql, music_festival_db_population.sql.
LAB01-02: Advanced Querying and Procedural Programming
This lab extends the database implementation by focusing on complex queries and procedural programming using PL/SQL. It includes:

SQL Queries (DQL):

Implement complex queries to retrieve detailed insights, such as festivalgoer profiles, attendance statistics, and staff employment metrics.
Each query is stored in separate .sql files, and views are created for efficient data access.
Database Improvements:

Identify and resolve issues in the existing relational model.
Propose improvements and provide an updated relational model.
PL/SQL Programming:

Implement Procedures, Triggers, Events, and Functions to automate business logic and ensure data integrity.
Example requirements include dynamically assigning staff to stages, automating currency conversions, and generating reports.
Key Requirements:
Procedures: Automate tasks like updating staff experience, calculating product prices in multiple currencies, and generating festival attendance reports.
Triggers: Implement logic to enforce rules, such as assigning bartenders or security members to less staffed locations.
Events: Schedule tasks like monthly updates for staff experience or daily price updates.

Submission:
Updated SQL scripts for each new requirement (e.g., req01_music_festival.sql, req02_music_festival.sql, etc.).
PDF explaining relational model improvements and justifications (music_festival_db_new_models.pdf).
How to Run
Setup the Database:

Clone the repository.
Run music_festival_db_deploy.sql to create the schema.
Execute music_festival_db_population.sql to populate the database.

Run Queries:

Execute the query scripts in LAB01-02 to retrieve insights.
Test PL/SQL Procedures and Triggers:

Execute the scripts in the given order (req01_music_festival.sql, req02_music_festival.sql, etc.) to see the procedural programming in action.
Group Members
This project was developed by a group of three people as part of a university course. Each member contributed to the conceptual design, relational model, and advanced SQL programming.
