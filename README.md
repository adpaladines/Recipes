
[![License][license-image]][license-url] [![Swift Version][swift-image]][swift-url]  [![SwiftUI][swiftUI-image]][swiftUI-url]

[swift-image]:https://img.shields.io/badge/Swift-5.8.1-orange?style=for-the-badge
[swift-url]: https://swift.org/

[license-image]: https://img.shields.io/badge/License-MIT-blue?style=for-the-badge
[license-url]: LICENSE

[SwiftUI-image]: https://img.shields.io/badge/SwiftUI-3.0-orange?style=for-the-badge&logo=swift&logoColor=white
[SwiftUI-url]: https://developer.apple.com/xcode/swiftui/


# Final Project 

This is an iOS app to look for a recipe of our like! The app is written in Swift and uses MVVM architecture.

## Name:
Flavor Planet

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

### Screen Record:

https://github.com/apaladines-techconsulting/Recipes/assets/138136886/61bdc4d3-0193-421a-942b-92cf72cefbdf

### Screenshots:
|Login Module|Screen 1|Screen 2|
|---|---|---|
| Login | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/2c930ff7-07e3-4bab-93cb-2d61e1214faa) | |
| Login with email | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/d9c82827-2a2a-40a7-b769-ead2a7229697) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/322512d5-7eaf-419f-8890-3afe01ca8ceb) |
| Register with email | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/431a285f-55b0-4f60-aa5c-ef9089c14a08) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/fbf36679-7766-4861-b652-acc32c5c52d2) |
| Login GMail | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/ad1ba8dc-6697-475a-8c5a-2f1c193407b3) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/740d03f0-a95e-452d-8fa0-1f751bcccb69) |

|Meals Module|Screen 1| Screen 2 | Screen 3 |
|---|---|---|---|
| Main List Screen | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/63f12ffa-45e6-4496-9eff-1b2624921897) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/423104cf-3a17-4b08-831f-2c22fa3bf61f) | |
| Mail List Screen Options | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/b788e92f-1128-4a1f-9f09-54f07a028cda) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/0e2cc314-b621-4767-aa6a-55dbd58d36e4) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/7dd58b40-fa83-4fcb-9ab7-23effce7a6e7) |
| Favorites List Screen | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/b8c00f14-18f7-4cf8-86be-a9a364d2d378) | | |
| Details Screen | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/9d28760a-3f44-49d0-94e0-7d9d5ef932a6) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/c3da0bab-37c9-4ed0-9ebf-e176732e50c5) | ![image](https://github.com/apaladines-techconsulting/Recipes/assets/138136886/b9d9a495-3d8e-4e67-9ad8-a6062562a612) |
