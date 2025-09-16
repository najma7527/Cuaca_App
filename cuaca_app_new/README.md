# Cuaca App

Cuaca App is a Flutter application that provides users with weather information and allows them to manage their profiles and settings. The app includes features for user authentication, profile management, and theme customization.

## Features

- **User Authentication**: Users can log in or register to access the app's features.
- **Weather Information**: Users can view detailed weather information based on their input.
- **Profile Management**: Users can view and edit their profile information, including their name.
- **Settings**: Users can toggle between dark and light mode for a personalized experience.

## File Structure

```
cuaca_app_new
├── lib
│   ├── main.dart               # Entry point of the application
│   ├── login.dart              # Login page for user authentication
│   ├── splash_screen.dart       # Splash screen displayed at app launch
│   ├── profile_page.dart        # User profile page
│   ├── settings_page.dart       # Settings page for theme customization
│   ├── register.dart            # Registration page for new users
│   ├── pages
│   │   └── detail_weather.dart   # Page displaying detailed weather information
│   └── widgets
│       └── custom_theme_switch.dart # Widget for theme switching
├── pubspec.yaml                 # Project configuration file
└── README.md                    # Documentation for the project
```

## Getting Started

To get started with the Cuaca App, follow these steps:

1. **Clone the repository**:
   ```
   git clone <repository-url>
   ```

2. **Navigate to the project directory**:
   ```
   cd cuaca_app_new
   ```

3. **Install dependencies**:
   ```
   flutter pub get
   ```

4. **Run the application**:
   ```
   flutter run
   ```

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.