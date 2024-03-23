import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_technique/pages/ActualitesPage.dart';
import 'package:test_technique/pages/InfosPage.dart';
import 'package:test_technique/pages/InscriptionPage.dart';
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
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.info), text: 'Info'),
                Tab(icon: Icon(Icons.settings), text: "Sign in"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ActualitesPage(),
              InfosPage(),
              InscriptionPage(),
            ],
          ),
        ),
      ),
    );
  }
}