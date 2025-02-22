import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  String _selectedCity = "Amsterdam";

  final List<String> _cities = [
    "Amsterdam",
    "Athens",
    "Bangkok",
    "Barcelona",
    "Beijing",
    "Berlin",
    "Boston",
    "Buenos Aires",
    "Cairo",
    "Chicago",
    "Delhi",
    "Dubai",
    "Hong Kong",
    "Istanbul",
    "Jakarta",
    "Johannesburg",
    "Kuala Lumpur",
    "Las Vegas",
    "London",
    "Los Angeles",
    "Madrid",
    "Mexico City",
    "Miami",
    "Moscow",
    "Mumbai",
    "New York",
    "Osaka",
    "Paris",
    "Rio de Janeiro",
    "Rome",
    "San Francisco",
    "Seoul",
    "Shanghai",
    "Singapore",
    "Sydney",
    "Tokyo",
    "Toronto",
    "Vancouver",
    "Vienna",
    "Zurich"
  ]..sort();

  @override
  void initState() {
    super.initState();
    _fetchWeather(_selectedCity);
  }

  void _fetchWeather(String city) {
    _wf.currentWeatherByCityName(city).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _locationHeader(),
        const SizedBox(height: 30),
        _dateTimeInfo(),
        const SizedBox(height: 25),
        _weatherIcon(),
        const SizedBox(height: 15),
        _currentTemp(),
        const SizedBox(height: 20),
        _extraInfo(),
      ],
    );
  }

  Widget _locationHeader() {
    return GestureDetector(
      onTap: () => _showCitySelectionDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCity,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }

  void _showCitySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2D64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Select a City",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _cities.length,
              itemBuilder: (context, index) {
                bool isSelected = _cities[index] == _selectedCity;
                return Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.deepPurpleAccent
                        : const Color(0xFF464A9B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(
                      _cities[index],
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedCity = _cities[index];
                        _fetchWeather(_selectedCity);
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          "${DateFormat("EEEE").format(now)}, ${DateFormat("d MMM y").format(now)}",
          style: const TextStyle(fontSize: 18, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription?.toUpperCase() ?? "",
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
          color: Colors.white, fontSize: 90, fontWeight: FontWeight.bold),
    );
  }

  Widget _extraInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoItem("Max",
                  "${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C"),
              _infoItem("Min",
                  "${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoItem(
                  "Wind", "${_weather?.windSpeed?.toStringAsFixed(0)} m/s"),
              _infoItem(
                  "Humidity", "${_weather?.humidity?.toStringAsFixed(0)}%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
