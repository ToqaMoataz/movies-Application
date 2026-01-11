# movie_app

A new Flutter project.

## Getting Started

# Movies Flutter Application

A Flutter mobile application that allows users to discover movies, search, browse by category, and view detailed information about each movie.  
The app provides a personalized experience by allowing users to save their watch history, manage their profile, and create a "To Watch" list.

---

## Features

- Search for movies  
- Browse movies by category  
- View detailed movie information  
- User authentication using Firebase  
- Manage user profile  
- Personal "To Watch" list  
- Watch history for each user  
- Cloud-based data storage using Firestore  
- Fetching movie data from external APIs  

---

## Design (Figma)

The UI/UX for this project was designed using Figma.  
You can view the design here:  
https://www.figma.com/design/O51USUdiAaw2ptWy60PTrz/Movies?node-id=52-641&t=plSMleRAGBNcAfd0

---

## APIs Used

This application uses the following movie API to fetch real-time data:  

API Provider:  
https://yts.mx/api

The API is used to retrieve:
- Movie lists  
- Movie details  
- Categories  
- Search results  

---

## Architecture

The app follows Clean Architecture principles to ensure scalability, testability, and maintainability.  
State management is handled using Cubit.

---

## Technologies Used

- Flutter and Dart  
- Firebase Authentication  
- Cloud Firestore  
- Hive (Local Storage)  
- REST APIs  
- Cubit (State Management)  

---

## Data Management

- User authentication is handled securely via Firebase  
- User profile, watch history, and to-watch list are stored in Firestore  
- Hive is used for fast local caching and offline persistence  

---

## App Flow

1. User signs up or logs in  
2. User creates or updates their profile  
3. Movies are fetched from the API  
4. User can search, browse, and view details  
5. User can save movies to their watch list  
6. Watch history is stored per user  

---

## Project Goal

This project demonstrates real-world Flutter development using clean architecture, secure authentication, cloud and local data storage, and scalable state management.
