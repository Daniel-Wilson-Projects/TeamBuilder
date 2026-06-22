Project: Team Builder a Hierarchical User & Role Manager (Grails Framework)

Overview
This project is a Grails Framework application designed to model and manage Users and Roles in a hierarchical, flow‑chart‑style structure. It was originally part of a larger system but has since been excised into a standalone module for experimentation, refactoring, and future reuse.

The application includes the ability for the project itself to manage its own Users and Roles, making it both a demonstration of Grails’ flexibility and a foundation for future plugin‑style development.

Features
Grails-based architecture — Built using Grails conventions, domain classes, services, and controllers.

User & Role hierarchy — Visual, tree-like structure for representing nested roles and organizational relationships.

Self-management — The application can administer its own Users and Roles.

Oracle JSON datatype integration — Experimental support for writing and querying JSON columns directly using SQL.

Direct SQL JSON search — Enables efficient querying of structured JSON data without ORM overhead.

Modularized from a larger system — Cleaned and separated for standalone development and testing.

Technical Notes
Oracle JSON Datatype Experimentation
This project served as a testbed for:

Writing JSON documents into Oracle’s native JSON column type

Executing direct SQL queries against JSON fields

Evaluating performance and indexing behavior

This experimentation informed how JSON-based metadata could be stored and queried in larger enterprise systems.

Project Extraction
The codebase was originally part of a broader enterprise application. It has been:

Isolated into its own repository

Cleaned of system-specific dependencies

Retained primarily for architectural reference and future enhancement

Future Plans
If time allows, the next phase of this project would focus on transforming it into a front-end–driven JavaScript plugin, with the backend becoming optional or replaceable.

Planned improvements include:

Database decoupling — Move logic away from Oracle-specific features to make the project backend-agnostic.

Front-end rearchitecture — Shift more logic to the client side for a smoother, more interactive experience.

Reusable JS plugin — Turn the hierarchy UI into a standalone component that can be embedded in other applications.

API-first design — Expose clean REST endpoints for external systems.
