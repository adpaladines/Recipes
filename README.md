# Final Project 

This is an iOS app to look for a recipe of our like! The app is written in Swift and uses MVVM architecture.

## Name:
FlavorPlanet

### Project Description:
In this app you will be able to look for meals from a big list from API [themealdb.com](https://www.themealdb.com/api.php).

This application was inspired on [Behance.net recipe-app-ui](https://www.behance.net/gallery/176410731/recipe-app-ui?tracking_source=search_projects|recipe+app+design) UX design.

### Table of Contents:
In the structure files contains: 
- Model
- View
- ViewModel
- Network
- Coordinator
- Tests part:
    - NetworkAPITests
    - ViewModelTests with MockJSON files and its data.

### Installation
Can be used with Xcode 14.3 and above. Compatible with iPhone and iPad with minimum iOS version 16.0.

### Frameworks used:
- Combine.
- SwiftUI.
- CoreData with Awayt Async.
- [KingFisher](https://github.com/onevcat/Kingfisher).
- [Hideable TabView](https://gitlab.com/AliMertOzhayta/hidabletabview-swiftui.git).
- [firebase-ios-sdk](https://github.com/firebase/firebase-ios-sdk).
- [GoogleSignIn-iOS](https://github.com/google/GoogleSignIn-iOS).

### Architecture:
- Architecture: MVVM-C -> Model View ViewModel Coordinator (Coordinator Pattern).

### Design Patterns
- Patterns: Observer, Singleton and Async await.

# Offline Storage
- CoreData
- UserDefaults & @AppStorage
- Custom UserDefaults methods to Store `Array<String>`

# Security (optional)
Implemeantaion
1. Jailbroke detection
2. SSL Certifacte pinning- using URLSesssion

iOS Security options Discussion:
 1.Data Storage Security
 2.Network layer Security
 3.Jailbroken Detection
 4.Development techniques or best practices
 5.Code secuirty scans using blackduck sites

### Functionalities:
- Gmail login.
- Select preffered three categories (first run) @AppStore (userDefaults).
- Full list of recipes from selected categories.
- Search textBox (debounce).
- Favorites (in CoreData).
- Recipes Details with images and or YouTube videos.
- Profile Screen UIKit (optional).

### Test Cases:
 - TDD: Units tests for success and failure situations. Faked responses using FakeNetworkManager using test jsons. Written test cases for view model testing

### Accessibility
1. Added accessiblity for Voice Over and Dynamic fonts using accessiblityLabel,accessiblityValue,accessiblityTrait,accessiblityHint

### Screenshots:
|List of Meals|DetailScreen|
|---|---|
| | |
