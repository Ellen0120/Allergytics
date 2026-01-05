# Allergytics 📱

Allergytics is an iOS application designed to help users track allergy symptoms, document possible triggers, and gain insight into recurring patterns over time.  
By combining structured symptom logging with location-based records and visual trend analysis, the app supports better self-awareness and allergy management.

## Features 
- User authentication with Firebase Authentication
- Log allergy symptoms with severity levels
- Record possible triggers and additional notes
- Save the location where symptoms occurred
- Display allergy records on an interactive map with color-coded pins based on severity
- View allergy history in a structured list
- Visualize trends by trigger, symptom, severity, and time of day
- Interactive charts with time range filtering
- Upload and manage profile images using Firebase Storage

## Tech Stack 🛠️
- iOS (Swift)
- UIKit for main app structure
- SwiftUI for data visualization and charts
- Firebase Authentication
- Firebase Firestore
- Firebase Storage
- MapKit and Core Location
- Git and GitHub for version control

## App Architecture 
The app follows a modular UIKit based architecture to improve readability and maintainability.  
Each screen is separated into UI components and view controllers, with clear responsibility boundaries.  
SwiftUI charts are embedded into UIKit using `UIHostingController` to combine modern data visualization with an existing UIKit workflow.

## Documentation
A detailed step-by-step app walkthrough, UI flow, and feature explanation are available in the project presentation slides included in this repository.

## Contributors 👩🏻‍💻
- Ellen
- Arive Maynes
- Yuna Watanabe

## Notes
This project was developed as a collaborative final project for an iOS development course.  
It is intended for educational and portfolio demonstration purposes.
