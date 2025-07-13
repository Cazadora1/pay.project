# Paydaş - Community Sharing App

A clean, minimalist, mobile-first Flutter UI for a community-sharing app called "Paydaş" (Turkish for "Partner/Companion").

## Features

### 🔐 Authentication
- **Login/Register Screen**: Clean authentication interface with email and password fields
- **Form Validation**: Real-time validation with user-friendly error messages
- **Snackbar Notifications**: Error feedback for failed authentication attempts

### 🏠 Home Page (Post List)
- **AppBar**: Title "İlanlar" with profile and logout icons
- **Post Cards**: Beautiful card-based layout displaying:
  - Post title in bold
  - Description in smaller gray text
  - Category badges with emoji icons
  - Author information and time ago
  - Optional thumbnail images
- **Pull-to-Refresh**: Swipe down to refresh the post list
- **Floating Action Button**: Plus icon to create new posts
- **Empty State**: Friendly message when no posts exist

### ➕ Post Creation
- **Form Fields**: Title and description with validation
- **Category Selection**: Dropdown with "Eşya", "Gıda", "Diğer" options
- **Image Picker**: Optional image selection (simulated in demo)
- **Preview**: Thumbnail preview of selected images
- **Submit Button**: "İlanı Yükle" with loading state
- **Success Feedback**: Snackbar confirmation on successful creation

### 👤 Profile Page (Optional)
- **User Information**: Display logged-in user's email
- **Statistics**: Post count, categories, and activity metrics
- **User Posts**: List of posts created by the current user
- **Logout Button**: Secure logout functionality

## Design Principles

- **Color Scheme**: Green (#4CAF50) as primary color
- **Material Design 3**: Modern Material Design components
- **Typography**: Google Fonts (Poppins) for consistent typography
- **Spacing**: Consistent 16px padding and 12px border radius
- **Mobile-First**: Optimized for mobile devices with responsive design

## Project Structure

```
lib/
├── main.dart                 # App entry point and theme configuration
├── models/
│   └── post.dart            # Post data model
├── screens/
│   ├── login_screen.dart    # Authentication screen
│   ├── home_screen.dart     # Main post list screen
│   ├── create_post_screen.dart # Post creation form
│   └── profile_screen.dart  # User profile screen
├── services/
│   └── auth_service.dart    # Authentication state management
└── widgets/
    └── post_card.dart       # Reusable post card component
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd paydas_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Demo Credentials
For testing purposes, you can use any email and password (minimum 6 characters):
- Email: `test@example.com`
- Password: `123456`

## Dependencies

- **flutter**: Core Flutter framework
- **provider**: State management
- **google_fonts**: Typography
- **firebase_core**: Firebase core functionality (ready for integration)
- **firebase_auth**: Authentication (ready for integration)
- **cloud_firestore**: Database (ready for integration)
- **firebase_storage**: File storage (ready for integration)
- **image_picker**: Image selection (ready for integration)

## Firebase Integration Ready

The app is structured to easily integrate with Firebase:
- Authentication service is abstracted for easy Firebase Auth integration
- Post model includes Firestore serialization methods
- Image upload functionality is prepared for Firebase Storage

## Customization

### Colors
The primary color can be changed in `lib/main.dart`:
```dart
seedColor: const Color(0xFF4CAF50), // Change this color
```

### Categories
Add or modify categories in `lib/screens/create_post_screen.dart`:
```dart
final List<String> _categories = ['Eşya', 'Gıda', 'Diğer'];
```

### Text
All text is in Turkish but can be easily internationalized by extracting strings to a localization file.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.