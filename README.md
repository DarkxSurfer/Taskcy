# Taskcy - Task Management App


#### A convenient and user-friendly platform to manage daily life Tasks.


## Overview

Taskcy is a powerful and intuitive task management app that helps users stay organized, productive, and connected. It combines task management with real-time chat, enabling collaboration while keeping track of important tasks.
Features

• User Authentication: Secure login and sign-up using Firebase Authentication.
    
• Task Management: Add, edit, delete, and manage tasks efficiently.
    
• Task Categories & Priorities: Organize tasks by categories (e.g., Work, Personal) and set priorities to focus on important tasks first.
  
• Task Status: Mark tasks as completed or pending with a simple toggle.
  
• Reminders & Notifications: Set task reminders and get notified before deadlines.
  
• Chat Feature: Built-in chat using Firestore, allowing real-time messaging with other users for collaboration.
  
• Dark Mode: Full support for dark mode for a comfortable user experience in low-light environments.
  
• Data Persistence: Uses SharedPreferences for storing tasks locally.
  
• State Management: Managed with GetX for efficient and responsive UI updates.
  
• Responsive Design: Fully responsive, optimized for mobile and tablet devices.
  

## Screenshots
<div style="display: flex; flex-direction: column; gap: 70px;">
  <img src="https://github.com/user-attachments/assets/1b43df82-8ec3-4b8c-9e02-62a7202ae4eb" alt="Screenshot 1" width="200" />
  <img src="https://github.com/user-attachments/assets/59832500-d945-4af4-9b8f-5a3e4db76e43" alt="Screenshot 2" width="200" />
  <img src="https://github.com/user-attachments/assets/cd548613-2e6e-4faf-b95a-bc8caf3e152a" alt="Screenshot 3" width="200" />
  <img src="https://github.com/user-attachments/assets/58daee73-c48a-435e-a681-409be7634dba" alt="Screenshot 4" width="200" />
  <img src="https://github.com/user-attachments/assets/3a742f8e-d9b4-4976-b0f7-25c28538a6a1" alt="Screenshot 5" width="200" />
  <img src="https://github.com/user-attachments/assets/b1733661-6227-4e01-848f-a57faea40a40" alt="Screenshot 6" width="200" />
  <img src="https://github.com/user-attachments/assets/23d0bfa3-496b-4bcc-9e77-11b96372cad8" alt="Screenshot 7" width="200" />
  <img src="https://github.com/user-attachments/assets/7688afb6-deb1-4c99-8ced-30f818aec909" alt="Screenshot 8" width="200" />
  <img src="https://github.com/user-attachments/assets/dacabe78-86b9-4f62-b1bb-9b300f3def2e" alt="Screenshot 9" width="200" />
  <img src="https://github.com/user-attachments/assets/d082e9f6-22e2-46a3-9fe2-a86e92756a20" alt="Screenshot 10" width="200" />
  <img src="https://github.com/user-attachments/assets/ef97861a-6241-4f01-831f-2c44cf69e0c3" alt="Screenshot 11" width="200" />
  <img src="https://github.com/user-attachments/assets/6e67c83f-7b0d-41b3-bb2e-5d8af3e247f9" alt="Screenshot 12" width="200" />
  <img src="https://github.com/user-attachments/assets/8f6e54ff-c156-43d9-a80b-a87f7882a533" alt="Screenshot 13" width="200" />
  <img src="https://github.com/user-attachments/assets/4599bb08-9d52-4f0c-9c25-373435875262" alt="Screenshot 14" width="200" />
  <img src="https://github.com/user-attachments/assets/a27de55f-4502-404f-a6c6-3dbce93fc8d1" alt="Screenshot 15" width="200" />
  <img src="https://github.com/user-attachments/assets/942d01d4-472d-43a1-aa3a-7dd73b5c4e8d" alt="Screenshot 16" width="200" />
</div>



## Installation

### To run Taskcy locally, follow these steps:

 #### Clone the repository:

    git clone https://github.com/DarkxSurfer/Taskcy.git

#### Navigate to the project directory:

    cd Taskcy

#### Install the required dependencies:

    flutter pub get

#### Set up Firebase:

  Create a Firebase project and add the necessary configuration files (Google Services JSON/Plist) to the android and ios directories.
  
  Enable Firebase Authentication and Firestore in your Firebase project.

#### Run the app:

    flutter run

## Tech Stack

• Frontend: Flutter
  
• State Management: GetX
  
• Authentication: Firebase Authentication
  
• Chat: Firestore for real-time messaging
  
• Task Storage: SharedPreferences for local storage
  
• Backend: Firebase Firestore for chat functionality
  
• UI/UX: Clean and modern design with both light and dark mode support
  

## Contributing

Contributions are welcome! If you'd like to add new features, improve the codebase, or fix issues, feel free to submit a pull request. Please make sure your code follows best practices and includes proper documentation.
License

This project is licensed under the MIT License - see the LICENSE file for details.
