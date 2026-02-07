# 🎬 TMDA — Flutter Movies & TV Shows App

**TMDA** is a production-grade Flutter application that allows users to explore Movies & TV Shows using the TMDB API, manage watchlists, and discover media through a scalable clean-architecture codebase.

Built with a strong focus on performance, modularity, and real-world engineering practices.


![eFashion in app preview](https://i.imgur.com/9OeuI5B.png)

---

## 🚀 Product Overview

TMDA delivers a complete media-browsing experience:

- Authentication via TMDB
- Movies & TV discovery
- Smart multi-category search
- Personalized watchlists
- Trailer playback
- Paginated media browsing
- Rich detail screens with cast & recommendations

This project demonstrates how to structure a feature-scalable Flutter application ready for production growth and team collaboration.

---
## Getting Started

To get started with the TMDA Android app, follow these steps:

1. Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/ZiadM07/tmda.git
```

2. Open Android Studio and select "Open an Existing Project."
3. Navigate to the cloned project directory and select it.
4. Android Studio will build and sync the project automatically.
5. Once the project is synced run `flutter pub get`.
6. if you are running on ios make sure to do the following :
- in terminal type :
```xml
cd ios
```
- Then Type :
```xml
pod install
```

7. After the packages load successfully, navigate to the `lib\core\constants` directory in the project.
8. Open `api_constants.dart` and add the following code, replacing `YOUR_API_KEY` with your TMDB API key and replace `YOUR_ACCOUNT_ID` with your TMDB Account ID :
```xml
apiKey = 'YOUR_API_KEY';
accountId = 'YOUR_ACCOUNT_ID';

```

9. Save the file.
   `0`. Run the app on an emulator or physical device by clicking the "Run" button in Android Studio.

## 📂 Project Structure

```text
lib/
┣ config/
┃ ┣ router/
┃ ┗ theme/
┣ core/
┃ ┣ api/
┃ ┣ constants/
┃ ┣ di/
┃ ┣ framework/
┃ ┣ state/
┃ ┗ utils/
┣ features/
┃ ┣ actors/
┃ ┣ auth/
┃ ┣ main/
┃ ┣ movies/
┃ ┣ profile/
┃ ┣ search/
┃ ┣ shared/
┃ ┣ tv/
┃ ┗ watchlist/
┣ bloc_observer.dart
┣ app.dart
┣ main.dart
┗ route_observer.dart
```
## ✨ Core Features

### 🔐 Authentication

Integrated with TMDB authentication system:

- Sign Up (TMDB account creation)
- Login
- Forgot Password
- Persistent session handling

---

## 🏠 Main Navigation

The app is structured around **4 primary modules**:

| Screen      | Description                            |
|-------------|----------------------------------------|
| 🎥 Movies   | Discover trending & now playing movies |
| 📺 TV Shows | Explore airing & popular TV content    |
| 🔎 Search   | Multi-category search experience       |
| 👤 Profile  | User info & watchlists                 |

---

## 🎥 Movies Module

Displays 3 horizontally scrolling collections:

- **Now Playing**
- **Popular**
- **Top Rated**

Capabilities:

- Smooth horizontal scrolling
- “See All” pagination screens
- Add to Watchlist
- Swipe → Remove from Watchlist
- Detail navigation

---

## 📺 TV Shows Module

Mirrors Movies architecture with domain adjustments:

- **Airing Today** *(replaces Now Playing)*
- **Popular**
- **Top Rated**

Includes identical watchlist and browsing capabilities.

---

## 🔎 Search Module

Advanced multi-tab search:

- Movies
- TV Shows
- Actors

### Pagination Support

- Infinite scroll pagination
- Available in all search tabs
- Optimized API fetching
- Lazy loading results

---

## 👤 Profile Module

User account hub displaying:

- Profile Image
- Name
- Username

### Watchlists

Separated for clarity:

- Movies Watchlist
- TV Shows Watchlist

Features:

- Dedicated “See All” screens
- Swipe-to-remove gestures
- Persistent storage via API

---

## 🎞️ Media Details Experience

Unified detail screen for Movies & TV Shows.

**Content Includes:**

- Overview
- Rating
- Add / Remove Watchlist
- Cast List
- Similar Media
- Recommended Media

### ▶️ Trailer Playback

- Embedded YouTube trailer player
- Available inside details screen
- Seamless in-app playback
- No external redirects

---

## 🧠 Engineering & Architecture

This project follows **Clean Architecture** principles.

### Architecture Layers

Presentation → UI, Cubits, Widgets
Domain → Entities, Use Cases, Repository Contracts
Data → Models, Data Sources, Repository Implementations
Core → Networking, Constants, Utils, Errors


---

### Key Engineering Decisions

- Feature-based folder structure
- Separation of concerns
- Repository pattern
- DTO ↔ Entity mapping
- Scalable state management
- API abstraction layer

---

## 🛠️ Tech Stack

| Technology          | Usage                  |
|---------------------|------------------------|
| Flutter             | UI Framework           |
| Dart                | Programming Language   |
| Bloc / Cubit        | State Management       |
| TMDB API            | Backend Data Source    |
| REST API            | Network Layer          |
| Clean Architecture  | Project Structure      |
| Localization (.arb) | Multi-language support |

---

## 📡 API Integration

Powered by **The Movie Database (TMDB)**.

Data includes:

- Movies & TV lists
- Airing / Trending content
- Cast & Credits
- Recommendations
- Similar media
- Multi-type search
- Authentication
- Trailers (YouTube keys)


---

## ⚡ Performance Considerations

- Optimized scrollable lists
- Infinite scroll pagination
- Lazy image loading
- Modular widget trees
- Watchlist state caching

---

## 👨‍💻 Author

# Ziad Mohamed

 Flutter Developer

 GitHub: https://github.com/ZiadM07

 Email: zeadzizo525@gmail.com\

---
