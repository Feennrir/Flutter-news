import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_technique/pages/ActualitesPage.dart';
import 'package:test_technique/utils/constants.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const NewsApplication());
}


class NewsApplication extends StatelessWidget {
  const NewsApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Application',
      theme: ThemeData(
        scaffoldBackgroundColor: colorBackground,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3, // The number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Actualités'),
            backgroundColor: colorBackground,
            foregroundColor: colorText,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'), // Tab 1
                Tab(icon: Icon(Icons.search), text: 'Search'), // Tab 2
                Tab(icon: Icon(Icons.settings), text: 'Settings'), // Tab 3
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ActualitesPage(), // Content for Tab 1
              Text('Search'), // Content for Tab 2
              Text('Settings'), // Content for Tab 3
            ],
          ),
        ),
      ),
    );
  }
}