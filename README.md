# 🎬 Flutter TMDb App

A modern Flutter application for browsing movies and TV shows using [The Movie Database (TMDb)](https://www.themoviedb.org/) API.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![TMDb](https://img.shields.io/badge/TMDb-01B4E4?style=for-the-badge&logo=themoviedatabase&logoColor=white)

## ✨ Features

- 🔐 **User Authentication** - Secure login with TMDb accounts
- 🔍 **Advanced Search** - Search movies and TV shows with real-time results
- 🎭 **Movie Details** - Comprehensive information including cast, crew, and ratings
- 📺 **TV Show Support** - Browse and discover TV series
- ⭐ **User Ratings** - Rate and review your favorite content
- 📱 **Responsive Design** - Optimized for all screen sizes
- 🌙 **Dark/Light Theme** - Customizable app appearance
- 📋 **Watchlists** - Create and manage personal movie lists

## 🚧 Work in Progress

This project is currently under active development. New features and improvements are being added regularly.

### 🎯 Upcoming Features

- [ ] Offline support with local database
- [ ] Social features and user reviews
- [ ] Personalized recommendations
- [ ] Movie trailers and videos
- [ ] Advanced filtering options
- [ ] Push notifications for new releases

## 🏗️ Architecture

The app follows clean architecture principles with:

- **UI Layer**: Flutter widgets with state management
- **Domain Layer**: Business logic and use cases  
- **Data Layer**: API clients and data models
- **State Management**: Provider pattern for reactive UI

## 🛠️ Tech Stack

- **Frontend**: Flutter & Dart
- **State Management**: Provider
- **HTTP Client**: Native Dart HTTP
- **API**: TMDb REST API
- **Authentication**: TMDb Session-based Auth
- **Architecture**: Clean Architecture with MVVM

## 📱 Screenshots

*Screenshots will be added as development progresses*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.17.0)
- Android Studio / VS Code
- TMDb API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Gaygysyz05/flutter-tmdb.git
   cd flutter-tmdb
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **API Configuration**
   - Get your API key from [TMDb](https://www.themoviedb.org/settings/api)
   - Add your API key to the project (configuration details coming soon)

4. **Run the app**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── domain/
│   ├── api_client/          # API communication layer
│   └── data_provider/   
├── resources/           # Data provider
├── ui/
│   ├── elements/            # App elements
│   ├── theme/               # App theming
│   └── widgets/             # Reusable UI components       
└── main.dart                # App entry point
```

## 🤝 Contributing

Contributions are welcome! This project is still in development, so there are many opportunities to contribute.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📋 Development Roadmap

- [x] Basic project setup
- [x] TMDb API integration
- [x] User authentication
- [ ] Movie search and browsing
- [ ] Detailed movie information
- [ ] User ratings and reviews
- [ ] Watchlist functionality
- [ ] TV show support
- [ ] Offline capabilities

## 🐛 Known Issues

- Authentication flow improvements needed
- UI/UX refinements in progress
- Error handling enhancements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [The Movie Database (TMDb)](https://www.themoviedb.org/) for providing the excellent API
- Flutter team for the amazing framework
- Open source community for inspiration and contributions

## 📞 Contact

**Gaygysyz** - [@Gaygysyz05](https://github.com/Gaygysyz05)

Project Link: [https://github.com/Gaygysyz05/flutter-tmdb](https://github.com/Gaygysyz05/flutter-tmdb)

---

⭐ If you found this project helpful, please give it a star!