import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_technique/model/Interface/IActuManager.dart';

class ActuApi implements IActuManager {
  static final ActuApi _instance = ActuApi._internal();
  static ActuApi get instance => _instance;
  // Private constructor
  ActuApi._internal();

  // Getter to get the unique instance of the class
  factory ActuApi() {
    return _instance;
  }

  final String? baseUrl = 'https://test-pgt-dev.apnl.ws/';

  @override
  Future<List<dynamic>> fetchActualites() async {
    String url = "${baseUrl}events";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
        'X-AP-DeviceUID': 'trial',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch actualites');
    }
  }
}
