import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/Actualite.dart';
import '../webservice/api_service.dart';
import 'customWidget/ActualiteListItem.dart';

class ActualitesPage extends StatefulWidget {
  const ActualitesPage({super.key});

  @override
  ActualitesPageState createState() => ActualitesPageState();
}

class ActualitesPageState extends State<ActualitesPage> {
  late List<Actualite> _actualites = [];
  List<Actualite> temp = [
    Actualite(
      id: 1,
      title: 'Test',
      description: 'Test',
      pictureUrl: '',
      publishedAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchActualites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _actualites.isNotEmpty
          ? ListView.builder(
              itemCount: _actualites.length,
              itemBuilder: (context, index) {
                final actualite = _actualites[index];
                return ActualiteListItem(actualite: actualite);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }


  Future<void> _fetchActualites() async {
    try {
      final List<dynamic> data = await ActuApi.instance.fetchActualites();
      setState(() {
        _actualites = data.map((e) => Actualite.fromJson(e)).toList();
        _actualites.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching actualites: $e');
      }
    }
  }
}
