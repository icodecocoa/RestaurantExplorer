# 🍽️ Restaurant Explorer

Restaurant Explorer is a modular, cleanly-architected iOS application built with SwiftUI. It allows users to discover and explore detailed information about restaurants fetched from a remote API, including ratings, price levels, cuisine, address, and more.

## ✨ Features

- 🔍 Fetch and display a list of restaurants with images, names, and cuisines.
- 📍 Tap into detailed restaurant views with descriptions, ratings, tags, and addresses.
- 🌐 Open venue locations directly in Google Maps.
- 📊 Reactive UI with Swift Concurrency and Combine integration.
- 🖼️ Image caching using `CachedAsyncImage`.
- 📱 Built entirely using SwiftUI with MVVM and Clean Architecture principles.

---

## 🧱 Architecture

The app is structured using **Clean Architecture** and follows the **MVVM** (Model-View-ViewModel) pattern:

RestaurantExplorer/
│
├── Presentation (SwiftUI Views, ViewModels)
├── Domain (Use Cases, Entities)
├── Data (Repositories, API Layer)
├── Resources (Assets, Localizable Strings)
└── Supporting Files (App Delegate, Info.plist)

- **Presentation Layer**: SwiftUI Views and ViewModels with dependency injection and state handling.
- **Domain Layer**: Contains entities and business logic via use cases.
- **Data Layer**: Contains repository implementations and API services.

---

## 🚀 Getting Started

### Requirements

- Xcode 15+
- iOS 16.0+
- Swift 5.9+

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/icodecocoa/restaurant-explorer.git
	
 2.	Open the project in Xcode:

open RestaurantExplorer.xcodeproj

3.	Run the app on Simulator or a real device.

⸻

📡 API Integration

The app fetches restaurant data using a remote API.

Key Endpoints:
	•	List Restaurants: GET /restaurants
	•	Restaurant Details: GET /restaurants/{id}

Ensure the base URL is correctly configured in the network layer or Info.plist.

⸻

🧪 Testing

The app includes modular components that are easily unit testable. (Add test targets to cover ViewModels and UseCases).

⸻

🧩 Technologies Used
	•	SwiftUI
	•	Combine / Swift Concurrency (async/await)
	•	Clean Architecture
	•	MVVM
	•	URLSession
	•	Image Caching with CachedAsyncImage

⸻

🙌 Acknowledgements
	•	Inspired by modern iOS architecture best practices.
	•	Uses system icons from SF Symbols.
	•	Placeholder images handled via CachedAsyncImage.

⸻

👩‍💻 Author

Drashti Lakhani
Feel free to reach out on 
[LinkedIn](https://www.linkedin.com/in/drashti-lakhani/) or [GitHub](https://github.com/icodecocoa)!
