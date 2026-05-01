# movie_app

A new Flutter project.

## Movies Flutter Application

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

## Firebase Project

This project uses Firebase for authentication and cloud data storage.  
You can access the Firebase project here:  
**[Firebase Console Project Link](https://console.firebase.google.com/u/0/project/movie-3af75/overview)**

---

## App Flow

1. User signs up or logs in  
2. User creates or updates their profile  
3. Movies are fetched from the API  
4. User can search, browse, and view details  
5. User can save movies to their watch list  
6. Watch history is stored per user

---

## Sceenshots

<img width="1080" height="2412" alt="1" src="https://github.com/user-attachments/assets/95b253eb-a5c2-4d83-84f6-bfc34ed20025" />
<img width="716" height="1600" alt="14" src="https://github.com/user-attachments/assets/a96f1b22-855f-4dc9-a04e-8ab285da8626" />
<img width="716" height="1600" alt="15" src="https://github.com/user-attachments/assets/60918ebd-cbf0-4bf8-9366-de319049d10b" />
<img width="716" height="1600" alt="13" src="https://github.com/user-attachments/assets/1b3d7d13-abad-423c-9df9-50cf375a4ed9" />
<img width="716" height="1600" alt="16" src="https://github.com/user-attachments/assets/490dde70-f509-4c3d-a402-a467a8a357bb" />
<img width="716" height="1600" alt="12" src="https://github.com/user-attachments/assets/dfb00d94-59f6-429f-a9a2-d6384d502348" />
<img width="716" height="1600" alt="11" src="https://github.com/user-attachments/assets/0a1f7572-0226-40e6-804a-85c7a529425a" />
<img width="716" height="1600" alt="10" src="https://github.com/user-attachments/assets/304a2b4c-254d-4132-8a4b-45d9fee0f1b1" />
<img width="716" height="1600" alt="9" src="https://github.com/user-attachments/assets/ebed32f8-a277-4ec6-9b4f-4f2500dbc235" />
<img width="716" height="1600" alt="8" src="https://github.com/user-attachments/assets/4e2581bf-6cc4-4740-b172-b314a30697fb" />
<img width="716" height="1600" alt="7" src="https://github.com/user-attachments/assets/cfa270a8-a591-4f13-be4f-80fc3d6324b4" />
<img width="1080" height="2412" alt="6" src="https://github.com/user-attachments/assets/c27b1bf0-8454-435e-ba3e-ab3b07390fd2" />
<img width="716" height="1600" alt="5" src="https://github.com/user-attachments/assets/e41bdb86-7f4e-4819-9984-3f6042a2b3b7" />
<img width="716" height="1600" alt="4" src="https://github.com/user-attachments/assets/ee465102-73b8-4b55-8395-eb1d8abd4f66" />
<img width="716" height="1600" alt="3" src="https://github.com/user-attachments/assets/51951bac-2f56-4240-9b7e-2615e9e4904e" />
<img width="716" height="1600" alt="2" src="https://github.com/user-attachments/assets/667c2c70-8b9a-4445-8c28-4741f25e5393" />


---
## Update

### March 2026
- Added TMDB API as a fallback data source when the original YTS API fails.  
- This ensures the app continues to fetch movie details even if the YTS server is down.  
- TMDB API documentation: [Getting Started](https://developer.themoviedb.org/reference/getting-started)


---

## Project Goal

This project demonstrates real-world Flutter development using clean architecture, secure authentication, cloud and local data storage, and scalable state management.
