# 🌤️ Weather App  

A sleek and responsive **Flutter** weather application that fetches real-time weather data for multiple cities worldwide. The app allows users to select a city from a **visually appealing dropdown list** and displays key weather details, including temperature, humidity, wind speed, and more.  

## 🚀 Features  
✅ **Real-time Weather Data** – Fetches live weather updates using OpenWeather API  
✅ **City Selection** – Clickable city name with an elegant dropdown list  
✅ **Beautiful UI** – Modern, dark-themed design with smooth animations  
✅ **International Cities** – Select from a pre-sorted list of major global cities  
✅ **Weather Icons** – Displays weather conditions with high-quality icons  
✅ **Material 3 Support** – Uses Flutter’s latest UI enhancements  

## 🎥 Demo Video  
### Preview of the App in Action  
[![Watch the Video](https://img.youtube.com/vi/your_video_id/0.jpg)](https://github.com/user-attachments/assets/54764a07-b5b4-4dea-9986-22fe16257361)

## 🛠️ Tech Stack  
- **Flutter** (Dart)  
- **Material 3**  
- **OpenWeather API** (for fetching real-time weather)  
- **intl package** (for formatted date & time)  

## 🔧 Installation  
1. **Clone the repository**  
   ```bash
   git clone https://github.com/shashican17/weather_app.git
   cd weather_app
   ```  
2. **Install dependencies**  
   ```bash
   flutter pub get
   ```  
3. **Run the application**  
   ```bash
   flutter run
   ```  

## 🔑 API Key Setup  
To use the OpenWeather API, create a file named `consts.dart` in the `lib/` folder and add:  
```dart
const String OPENWEATHER_API_KEY = "your_api_key_here";
```  
Replace `"your_api_key_here"` with your actual API key from [OpenWeather](https://openweathermap.org/api).  
