# DB Box

## Project Description
The "DB Box" project is designed to help students learn how to perform CRUD (Create, Read, Update, Delete) operations on a TODO list using the `sqflite` package in Flutter. The project also includes advanced features like bookmarking or favoriting TODOs, stored locally using the `shared_preferences` package.

Additionally, students will implement a splash screen, a one-time introduction screen, and a theme toggle functionality that maintains its state persistently across app sessions. The project adheres to the Model-View-Controller (MVC) pattern to promote clean code architecture and includes state management through either `Provider` or `GetX`.

This project offers a comprehensive learning experience in building database-driven applications, managing local storage, and incorporating essential user interface elements such as splash screens and themes. By the end of this project, students will be able to manage app state efficiently, handle persistent data storage, and create intuitive user interfaces.

---

## Features

- **TODO List with CRUD Operations**
  - Implement CRUD functionalities for TODOs using the `sqflite` package to store data in a local SQLite database.

- **Bookmarking/Favoriting**
  - Allow users to bookmark or favorite specific TODO items and store these in local storage using the `shared_preferences` package.

- **Splash Screen**
  - Display a splash screen when the app is launched.

- **Introduction Screen**
  - Add a one-time introduction screen that appears only on the first app launch, tracked using `shared_preferences`.

- **Theme Toggle**
  - Enable users to toggle between light and dark themes, with the selected theme saved persistently using `shared_preferences`.

- **MVC Architecture**
  - Follow the Model-View-Controller (MVC) pattern to maintain a clear separation between the Model, View, and Controller layers.

- **State Management**
  - Manage app state using either `Provider` or `GetX`, ensuring efficient handling of the TODO list and theme persistence.

---

## Screenshots
<img src="https://github.com/user-attachments/assets/a3b450eb-939e-4529-8ae1-7283c3755830" alt="Screenshot 1" style="width: 300px; height: auto;"> &nbsp;
<img src="https://github.com/user-attachments/assets/989adf31-5450-4f70-ac8a-50a6500f5cfb" alt="Screenshot 2" style="width: 300px; height: auto;"> &nbsp;
<img src="https://github.com/user-attachments/assets/a1d138bf-09c4-46ab-8783-0d5d26e294de" alt="Screenshot 2" style="width: 300px; height: auto;"> &nbsp;
<img src="https://github.com/user-attachments/assets/017a6fc3-6a39-4b11-bacf-f1af5247fcc0" alt="Screenshot 2" style="width: 300px; height: auto;"> &nbsp;
<img src="https://github.com/user-attachments/assets/e207aeb1-eeb5-4305-84ee-3fde60781709" alt="Screenshot 2" style="width: 300px; height: auto;"> &nbsp;
<img src="https://github.com/user-attachments/assets/d3642068-1f9e-4f5f-827b-09c94098d751" alt="Screenshot 2" style="width: 300px; height: auto;"> &nbsp;

---

## Technologies Used

- **Language:** Dart
- **Framework:** Flutter
- **Architecture:** MVC with `Provider` or `GetX` for state management
- **Local Storage:**
  - `sqflite` for SQLite database operations
  - `shared_preferences` for persistent storage

---

## Usage

- **CRUD Operations**: Add, edit, delete, and view TODO items.
- **Bookmarking**: Mark specific TODOs as favorite for easy access.
- **Theme Toggle**: Switch between light and dark themes in the app settings.
- **Splash and Introduction Screens**: Enjoy a smooth onboarding experience.

---

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

