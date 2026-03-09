# ClimbDB

## Overview

ClimbDB is a database design project that models the ecosystem of indoor climbing gyms.

The goal of this database is to represent how climbers interact with climbing gyms and routes over time. The system is designed to store structured information about:

* climbers and their profiles
* climbing sessions
* routes (with creation and removal dates)
* walls inside gyms
* gym locations and companies
* subscriptions
* climbing styles associated with routes

The database allows us to model real-world climbing activity in a structured and consistent way. It ensures that performance tracking, route lifecycle management, and membership systems can be represented clearly and without redundancy.

This project follows the **MERISE database design methodology**, which includes requirements analysis, conceptual modeling (MCD), logical modeling (LDM), physical implementation (PDM), data insertion, and database querying.

---

# Part 1 – Requirements Analysis and Conceptual Modeling

Part 1 of the project corresponds to **Step 1 and Step 2 of the MERISE methodology**, which focus on requirements analysis and the creation of the conceptual data model (MCD). 

---

# Step 1 – Requirements Analysis

## Prompt Used

Prompt link:
[https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/Prompt_Template_Design_EN](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/Prompt_Template_Design_EN)

### Explanation of the Prompt

To collect the requirements, we used **Generative AI acting as a company in the climbing industry**.

The prompt was written using the **RICARDO framework**, which helps structure prompts in order to obtain precise and relevant answers from a generative AI.

The prompt specifies:

* the role of the AI
* clear instructions for the expected response
* the project context (a climbing gym tracking system)
* formatting constraints
* the desired output (business rules and a raw data dictionary)

The objective of the prompt was to obtain structured requirements that could be used to design the database.

---

## Output from the Generative AI

Output link and our modifications of it:
[https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/GAI_output.md](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/GAI_output.md)

### Result of the Prompt

The AI returned:

* a list of **business rules** describing how the climbing system works
* a **raw data dictionary** describing the data to be stored in the database

The dictionary includes:

* entity concepts
* attribute descriptions
* data meanings
* suggested data types

These elements served as the foundation for building the conceptual model.

### Our Modifications

After analyzing the AI output, we made several modifications to improve the coherence of the model.

The main changes include:

* removal of the **Group** entity
* simplification of the **Session** entity
* creation of a dedicated **Styles** entity
* association of **Style** with **Route** through the **Define** relationship
* addition of the **Company** entity to group gyms belonging to the same chain
* modification of the **Subscription** relationship to include attributes such as:

  * `type`
  * `start_date`
  * `end_date`
  * `status`
  * `subscribtion_id`

These changes helped align the model with the actual objectives of the climbing activity tracking system.

---

# Step 2 – MCD (Conceptual Data Model)

Using the business rules and data dictionary obtained in Step 1, we created a **Conceptual Data Model (MCD)**.

The MCD represents:

* entities
* relationships
* attributes
* identifiers
* cardinalities

The model was created using **Looping**.

Looping file link:
[https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/ClimbingRegisterv1.4.loo](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/ClimbingRegisterv1.4.loo)

The MCD ensures that the data model respects **normalization rules (3NF)** and correctly represents the relationships between the different elements of the climbing ecosystem.

---

# Part 2 – Logical and Physical Database Implementation

Part 2 of the project corresponds to **Step 3, Step 4 and Step 5**, where the conceptual model is transformed into a relational database, populated with data, and queried in a practical scenario. 

---

# Step 3 – LDM and PDM

## Logical Data Model (LDM)

The **Logical Data Model** was derived from the MCD using transformation rules.

This step converts:

* entities into tables
* relationships into foreign keys or associative tables

The resulting relational model defines the final structure of the database.

---

## Physical Data Model (PDM)

The **Physical Data Model** was implemented using SQL.

Two SQL scripts were created:

### Table Creation Script

File:
[`1_creation.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/1_creation.sql)

This script creates all the database tables and defines:

* primary keys
* foreign keys
* referential integrity rules

It also ensures that updates and deletions involving foreign keys are handled automatically.

---

### Validation Constraints

File:
[`2_constraints.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/2_constraints.sql)

This script defines additional validation constraints corresponding to the business rules identified during Step 1.

Examples of constraints include:

* value restrictions using `CHECK`
* uniqueness constraints
* domain validation
* consistency rules on dates and statuses

These constraints ensure the integrity and reliability of the stored data.

---

# Step 4 – Data Insertion

To populate the database, we used **Generative AI** to generate realistic data corresponding to the climbing domain.

A structured prompt was written to:

* describe the relational schema
* specify the number of rows required for each table
* enforce the integrity constraints
* ensure consistency between foreign keys

Prompt link:
[`Prompt_Insertion_EN.md`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/Prompt_Insertion_EN.md)

The generated SQL insertion queries are stored in:

File:
[`3_insertion.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/3_insertion.sql)

This script inserts data for:

* companies
* gyms
* walls
* routes
* climbing styles
* climbers
* sessions
* subscriptions
* route attempts
* route-style associations

---

# Step 5 – Querying the Database

Once the database was created and populated, we designed a **practical use scenario** for the database.

## Usage Scenario – Efrei Sport Climbing

The database is used by the student association **Efrei Sport Climbing** at **Efrei Paris**.

The association organizes climbing sessions for students and tracks their activity in different partner climbing gyms.

The database helps the association:

* identify the most active climbers
* analyze which gyms and walls are most used
* study the popularity of different climbing styles
* detect routes that are frequently attempted but rarely topped
* monitor student subscriptions to partner gym companies
* prepare training sessions based on real member activity

---

## SQL Query File

File:
[`4_interrogation.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/4_interrogation.sql)

This file contains SQL queries used to extract useful information from the database.

The queries cover the main SQL concepts studied in the course:

* projections and selections
* sorting, masks, `IN`, `BETWEEN`, and `DISTINCT`
* aggregation functions with `GROUP BY` and `HAVING`
* joins (inner, outer, multiple joins)
* nested queries with `IN`, `NOT IN`, `EXISTS`, `NOT EXISTS`, `ANY`, and `ALL`

Each query is commented to explain the data being extracted.

---

# Repository Contents

The repository contains:

* [`README.md`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/README.md)
* [`Prompt_Template_Design_EN`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/Prompt_Template_Design_EN)
* [`GAI_output`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/GAI_output.md)
* [`ClimbingRegisterv1.4.loo`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/ClimbingRegisterv1.4.loo)
* [`1_creation.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/1_creation.sql)
* [`2_constraints.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/2_constraints.sql)
* [`Prompt_Insertion_EN.md`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/Prompt_Insertion_EN.md)
* [`3_insertion.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/3_insertion.sql)
* [`4_interrogation.sql`](https://github.com/jeremiel1110/ProjectDB_Bencoil_Ha-Duong/blob/main/4_interrogation.sql)

---

# Conclusion

This project allowed us to go through the complete database design process using the MERISE methodology:

1. Requirements analysis using generative AI
2. Conceptual modeling with an MCD
3. Transformation into relational and physical models
4. Automatic generation of coherent data
5. Querying the database through a real usage scenario

The final result is a complete database system modeling the activity of indoor climbing gyms and the interactions between climbers, sessions, and routes.
