import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:guide_shark/data/MedicalData.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<Map<String, dynamic>> submitMedicalData(MedicalData data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/ai/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"data": data.toString()}),
    );

    if (response.statusCode == 200) {
      var resp = jsonDecode(response.body);
      var diagnosis = jsonDecode(resp['response']);
      return diagnosis;
    } else {
      throw Exception('Failed to submit data: ${response.statusCode}');
    }

    throw Exception('Response not found');
  }
}
