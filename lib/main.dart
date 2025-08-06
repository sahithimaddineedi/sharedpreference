import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PreferenceDemo());
  }
}

class PreferenceDemo extends StatefulWidget {
  const PreferenceDemo({super.key});

  @override
  State<PreferenceDemo> createState() => _PreferenceDemoState();
}

class _PreferenceDemoState extends State<PreferenceDemo> {
  late SharedPreferences prefs;

  bool isLoggedIn = false;
  bool isDarkMode = false;
  String language = 'en';
  String email = '';
  int lastViewedId = 0;
  int val = 0;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      language = prefs.getString('languageCode') ?? 'en';
      email = prefs.getString('email') ?? '';
      lastViewedId = prefs.getInt('lastViewedItemId') ?? 0;
    });
  }

  Future<void> _savePrefs() async {
    await prefs.setBool('isLoggedIn', true);
    await prefs.setBool('isDarkMode', true);
    await prefs.setString('languageCode', 'aa');
    await prefs.setString('email', 'example@mail.com');
    await prefs.setInt('lastViewedItemId', 2025);

    _loadPrefs(); // Refresh UI
  }

  Future<void> _clearPrefs() async {
    await prefs.clear();
    _loadPrefs(); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SharedPreferences Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Login: $isLoggedIn"),
            Text("Dark Mode: $isDarkMode"),
            Text("Language: $language"),
            Text("Email: $email"),
            Text("Last Viewed ID: $lastViewedId"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePrefs,
              child: const Text("Save All Data"),
            ),
            ElevatedButton(
              onPressed: _clearPrefs,
              child: const Text("Clear All Data"),
            ),
          ],
        ),
      ),
    );
  }
}

