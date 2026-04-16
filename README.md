# 🌤 Weather App (Flutter)

A modern Flutter weather application that provides real-time weather updates, hourly forecasts, and daily predictions with a beautiful glassmorphism UI.

---

## 📱 Features

* 🔍 **City Search**

  * Search cities using GeoDB API
  * Autocomplete suggestions with country

* 🌦 **Real-Time Weather**

  * Current temperature, conditions
  * Min/Max temperature

* ⏱ **Hourly Forecast**

  * Next 24-hour weather updates

* 📅 **Daily Forecast**

  * Multi-day weather predictions

* 🔔 **Local Notifications**

  * Weather updates for recently searched cities

* 🎨 **Modern UI**

  * Glassmorphism design using LiquidGlass
  * Smooth animations with Lottie

* 🌙 **Dark / Light Theme**

  * Dynamic theme switching

---

## 🛠 Tech Stack

* **Flutter (Dart)**
* **Provider** (State Management)
* **Dio** (API Calls)
* **OpenWeather API** (Weather Data)
* **GeoDB API** (City Search)
* **Flutter Local Notifications**
* **Timezone Package**
* **Lottie Animations **

---

## 🔗 APIs Used

### 🌍 City Search API

* GeoDB Cities API
* Used for autocomplete search with latitude & longitude

### 🌦 Weather API

* OpenWeather OneCall API
* Provides:

  * Current weather
  * Hourly forecast
  * Daily forecast

---

## 🧠 App Flow

1. User searches for a city
2. GeoDB API returns:

   * City name
   * Country
   * Latitude & Longitude
3. App uses lat/lon to call OpenWeather API
4. Weather data is displayed on UI
5. Notification scheduled for selected city

---

## 📂 Project Structure

```bash
lib/
│
├── models/            # Data models (Weather, Hourly, Daily)
├── provider/          # State management (Provider)
├── service/           # API services (Dio, Notifications)
├── screens/           # UI screens
│   ├── homeScreen.dart
│   ├── searchScreen.dart
│   └── emptyStateScreen.dart
│
├── widgets/           # Reusable UI components
├── constants/         # Text & theme constants
└── main.dart          # Entry point
```

---

## ⚙️ Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/your-username/weather-app.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Create `.env` file:

```env
API_KEY=your_openweather_api_key
CITY_API_KEY=your_rapidapi_key
```

4. Run the app:

```bash
flutter run
```

---

## ⚠️ Known Issues

* Network errors may cause temporary empty state

---

## 🚀 Future Improvements

* 📍 Current location weather
* 💾 Save favorite cities
* 📊 Weather charts & analytics
* ☁️ Cloud sync
* 🔄 Background updates (WorkManager)

---

## 👨‍💻 Author

**Aman Sachla**

---

## 🎨 Assets & Credits

* 🌦 Weather animations sourced from **Meteocons Lottie Pack**
* Created by **Bas Milius**
* GitHub Repository: https://github.com/basmilius/meteocons

These animations are used for visual representation of weather conditions such as sunrise, sunset, wind, and more.

---

### 📜 License

Please refer to the original repository for license details:
https://github.com/basmilius/meteocons/blob/main/LICENSE

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!
