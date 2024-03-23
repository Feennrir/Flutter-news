import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import 'package:test_technique/model/Interface/IActuManager.dart';

class ActuApi implements IActuManager {
  static final ActuApi _instance = ActuApi._internal();
  static ActuApi get instance => _instance;
  ActuApi._internal();

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

  @override
  Future<void> submitRegistrationForm({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) async {
    final Uri url = Uri.parse('${baseUrl}authentication/register');
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Accept-Language': 'fr-FR',
      'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
      'X-AP-DeviceUID': 'Documentation',
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;

    // Functionality not implemented
    // if (image != null) {
    //   final imagePath = image.path;
    //   final imageFile = await http.MultipartFile.fromPath('picture', imagePath);
    //   request.files.add(imageFile);
    // }

    try {
      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception('Failed to submit registration form');
      }

    } catch (error) {
      throw Exception('Failed to submit registration form');
    }
  }

  @override
  Future<String?> fetchHtmlContent() async {
    final url = Uri.parse('https://test-pgt-dev.apnl.ws/html');
    final headers = {
      'Accept': 'text/html',
      'Accept-Language': 'fr-FR',
      'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
      'X-AP-DeviceUID': 'Documentation',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Error fetching HTML: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching HTML: $error');
      return null;
    }
  }
}
