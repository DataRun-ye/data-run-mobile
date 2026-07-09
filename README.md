# Data-Run-Mobile

## Overview

Data-Run-Mobile is a Flutter application developed for the National Malaria Control Program (NMCP)
in Yemen. The app facilitates the submission and synchronization of malaria-related data with the
main backend system, Data-run-Api. This tool is designed to streamline data collection processes and
ensure accurate and timely data transmission to support malaria control efforts.

## Features

- **Dynamic Form Download**: The app downloads forms designed on the backend, which can include
  various question types.
- **Question Types**: Supports Text, Number, Date, Multi Answer, Single Answer, Image, and File
  questions.
- **Data Submission**: Users can submit various malaria-related data directly from the app.
- **Data Synchronization**: The app syncs submitted data with the Data-run-Api, ensuring all
  information is up-to-date.
- **User Authentication**: Secure login and authentication to ensure data integrity and privacy.
- **User Management**: Quickly create users and assign them to particular teams.
- **Offline Mode**: Allows data entry even when offline; data will be synced once the internet
  connection is restored.
- **User-Friendly Interface**: Simple and intuitive design to facilitate ease of use by healthcare
  workers.
-

## Screenshots

# Project Name

## Screenshots

| ![1](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/1.png)   | ![2](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/2.png)  | ![3](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/3.png)   |
|---------------------------|--------------------------|---------------------------|
| ![4](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/4.png)   | ![5](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/5.png)  | ![6](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/6.png)   |
| ![7](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/7.png)   | ![8](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/8.png)  | ![9](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/9.png)   |
| ![10](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/10.png) | ![11](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/11.png) | ![12](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/12.png) |
| ![13](https://raw.githubusercontent.com/Hamza-ye/images-uploads/refs/heads/main/datarun-screenshots/13.png) |                          |                           |

## Installation

To install Data-Run-Mobile on your device, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Hamza-ye/datarunmobile.git
   ```
2. **Navigate to the Project Directory**:
   ```bash
   cd data-run-mobile
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   ```bash
   flutter run
   ```

## Usage

We manage **field activities** involving teams and assignments, where data collection is a core task. Activities may target specific entities such as **locations, health facilities, or people**, and could involve tasks like distributing items (e.g., ITNs, medicines) or supervising teams. Each team has **planned locations** and **allocated quantities** for their assignments.

### **Current Design**:

1. **Assignments**: Link an activity, orgUnit, team, and day.
2. **Activity**: Groups assignments, teams, and tasks within a defined time frame.
3. **Teams**: A "person entity" created before linking a user, allowing assignment distribution. Later, a user can be linked to a person to gain permissions and configurations upon login,
4. **Users**: Store login info (username, password, etc.).
5. **DataForm Templates**: Templates for data collection, varying per team/task, DataForm Templates can be linked to an assignment/ or just a general form to collect data with no particular assignment, when linked they are used to submit data for the assignment progress.
6. **Data Submission**: Stores submitted data linked to teams with context related attributes such as user, team, assignment...etc
--- 

### **Current Approach**

### **Assignments**

- **Definition**:
    
    Assignments link an activity, organization unit (orgUnit), assigned team, day, and a map of dynamic attributes (e.g., `ITNs`, `Population`):
    
    ```json
    { "attributeName": "attributeValue" }
    
    ```
    
    - Assignments are implemented hierarchically, allowing parent-child relationships. For example:
        - **Supervisor Assignment**:
            - **Activity**: ITNs Supervision.
            - **OrgUnit**: District supervised.
            - **Team**: Supervisor team.
            - **StartDay**: 1.
            - **Allocated Resources**: Total district ITNs and population.
        - **Child Assignment**:
            - **Activity**: ITNs Distribution.
            - **OrgUnit**: Village within the district.
            - **Team**: Field distribution team.
            - **StartDay**: 1.
            - **Allocated Resources**: Village ITNs and population.

### **Forms Template and submissions**
- **Templates**:
    - Data collection templates vary based on team or assignment needs.
    - Forms may be general or linked to specific assignments for tracking progress.
- **Submissions**:
    - Store collected data, including metadata like timestamps, GPS coordinates, assignment reference if the template is linked to an assignment, and user identifiers.

1. **Form templates linked to an assignment/task**:
    - Assignments can have one or more **DataForms** linked to it and with the right permission assigned teams/users can access these forms to collect data about the assignment if they have this assignment assigned to them or is a sub assignment of their assignement.
    - Example assignment for a team:
        
        ```json
        {
          "uid": "llm1EHPJ5kh",
          "entityScope": "Assigned",
          "activity": { "uid": "RHl5bdmYXVr" },
          "startDay": 1,
          "orgUnit": { "uid": "HgWpVtC10fF" },
          "team": { "uid": "YFNLJEoYpfy" },
          "allocatedResources": { "ITNs": 899, "Population": 89 },
          "parent": { "uid": "rSBRh6eofeH" },
          "forms": [
            "Tcf3Ks9ZRpB",
            "RtnmK39VXTY"
          ]
        }
        
        ```
---

## **Goal, Mobile App (First Release)**
### Modular Forms Integration

- Create **Form Templates** that dynamically adapt to the context:
    - Fields can reference **Tasks** or **Assignments** (e.g., `targetedOrgUnit`, `population`, `resourcesUsed`).
    - Some forms are independent of tasks/assignments for surveys or general reporting.
    - Allow flexible linking between forms and entities, enabling progress tracking, summaries, or data validation.

### **Example Configuring ITNs Distribution Campaigns**
**Task**:

```json
{
  "id": "task_001",
  "name": "Distribute ITNs in Village A",
  "description": "Daily path for team A",
  "startDate": "2024-01-01",
  "endDate": "2024-01-01",
  "allocatedResources": ["ITNs"],
  "targetedOrgUnits": ["village_a", "school_b"],
  "metadata": { "population": 1000, "ITNs": 500 }
}

```

**Assignment**:

```json
{
  "id": "assign_001",
  "taskId": "task_001",
  "assignee": "team_a",
  "assignedForms": ["form_001"],
  "status": "active"
}

```

### **Teams**

- **Dynamic Configuration**:
    - Teams can be formed for specific projects and dissolved afterward.
    - Teams are hierarchical, with supervisors managing subordinate teams.
    - teams can be assigned to one or more assignments and a team can manage or report about the assignment of their managed teams
- Example of Team:

```json
{
    "uid": "P5fjmw0elDV",
    "code": "317",
    "name": "team-317",
    "disabled": false,
    "activity": { "uid": "RHl5bdmYXVr" },
    "users": [ { "uid": "qqHQA2BFJJf" } ],
    "assignments": [
        { "uid": "DDl4bimW3Vr" },
        { "uid": "ERT5bd4Y6Vr" }
    ],
    "managedTeams": [],
    "formPermissions": [
        { "form": "form_001", "permissions": ["VIEW_TRACK_SUMMARY"] },
        { "form": "form_002", "permissions": ["ADD_SUBMISSIONS"] }
    ]
}

```

**Form Templates**:

```json
[
    {
    "id": "form_001",
    "name": "assigned location resource distribution data",
    "fields": [
        { "name": "orgUnit", "type": "reference", "ref": "orgUnit" },
        { "name": "resourcesUsed", "type": "number" },
        { "name": "population", "type": "number" },
    ]
    },
    {
    "id": "form_002",
    "name": "teams allocated resource movement transactions",
    "fields": [
        { "name": "orgUnit/centeral wh location", "type": "reference", "ref": "orgUnit" },
        {"id": "transactions", "name": "resource to teams transactions details", "type": "table" , 
        "fields": [
            { "name": "team", "type": "reference", "ref": "managedTeams" },
            { "name": "resourcesDispensedToTeam", "type": "number" }
        ]
       }     
    ]
    }
]
```
---

## Modules
Different modules based on the user context.
 
### 1. Activities

Available when user have a team that is part of activities/assignment workflow, and include the following:
- **Assignment Explorer**
**Purpose**: Facilitate management of Assignments.

- **Features**:
**1. Assignments View**:
- List Assignments with attributes like start date, end date, allocated resources, and status.
- Filters for Assignment type, date range, or completion status:
  * **Elements:**
      * **Assignment Title:** (e.g., "Distribute ITNs in Village A")
      * **Due Date/Time:** (visual indicator for overdue tasks)
      * **Status:** (e.g., "In Progress," "Completed," "Reassigned")
      * **Assignee:** (Team name or individual user)
      * **Priority:** (Optional: High, Medium, Low)
      * **Actions:** 
          * "View Details" 
          * "Mark as Complete"
          * "Reassign" 
          * "Reschedule"
          * "report progress"
          * "View Reports" 
          
**2. Assignment Details**
    * **Component:** A modal or expanded view when "View Details" is clicked.
    * **Elements:**
        * **Detailed Description:** (Expanded view of the task description)
        * **Attributes:** (Display key-value pairs of task attributes)
            * Example: "Population": 1000, "Allocated ITNs": 500
        * **Subtasks:** (If applicable, display a nested list of subtasks)
        * **Assigned Forms:** (List of forms associated with the assignment)
        * **Progress Bar:** (Visual representation of assignment completion)
        * **Comments Section:** (For team communication)

**3. Assignments Map**

* **Component:** An interactive map integrated within the app.
* **Functionality:**
    * Display assignments on a map (if applicable).
    * Allow users to filter assignments by location, status, or other criteria.
    * Potentially integrate GPS location tracking for field workers.

### 2. Forms Management**
this section is available for users that are part of activity workflow, or users that are not part of any activity or assignment workflow.

* Introduce a dedicated "Forms" tab or section within the app.
* This tab would list all available forms that the user has permission to access.
* Users can filter forms by type (e.g., "General Surveys, activity, assignment progress forms, ...etc").
* Each form card would display the form name, description, and a "Start Form" button.
* **Flexible Form Linking:** If the form is also associated with an assignment assigned to the user Allow the users to link the form to existing assignment when adding/opening a new form.
**UI Indicators:** Clearly distinguish between assignment-linked forms and standalone forms within the UI.
* For example:
    * Use different icons or colors to differentiate form types.
    * Display a clear indication if a form is linked to a specific assignment.

### 3. Team Management

* **Component:** A dedicated section for managing teams.
* **Elements:**
    * **Team Roster:** (List of team members)
    * **Team Assignments:** (View and manage assignments for the team)
    * **Team Performance:** (Track team progress and identify potential bottlenecks)

### 4. Dashboard

* **Component:** A personalized overview of a user's assignments.
* **Elements:**
    * **Key Performance Indicators (KPIs):** (e.g., number of completed tasks, overdue tasks, progress percentage)
    * **Charts and Graphs:** (Visualize task completion rates, resource usage, etc.)
    * **Customizable Widgets:** (Allow users to add/remove widgets based on their preferences)

### 5. Notifications

* **Component:** In-app notifications or push notifications.
* **Functionality:**
    * Alert users of new assignments, task updates, or urgent issues.

## Contributing

We welcome contributions to enhance Data-Run-Mobile. Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please contact:

- **Project Maintainer**: Hamza
- **Email**: 7amza.it@gmail.com
