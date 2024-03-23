import 'dart:io';

abstract class IActuManager {
  Future<List<dynamic>> fetchActualites();
  Future<void> submitRegistrationForm({
    required String name,
    required String email,
    required String phone,
    File? image,
  });
  Future<String?> fetchHtmlContent();
}