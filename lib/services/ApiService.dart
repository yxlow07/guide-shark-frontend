import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:guide_shark/data/MedicalData.dart';
import 'dart:io';
import 'dart:async';

class ApiService {
  static const String baseUrl = 'https://yuxuan013.pythonanywhere.com/';

  Future<Map<String, dynamic>> submitMedicalData(MedicalData data) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/ai/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"data": data.toString()}),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('The connection has timed out. Server is unreachable.');
            },
          );

      if (response.statusCode == 200) {
        var resp = jsonDecode(response.body);
        var diagnosis = jsonDecode(resp['response']);
        return diagnosis;
      } else {
        throw Exception('Failed to submit data: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('No internet connection. ${e.message}, ${e.osError}, ${e.address}, ${e.port}');
    } on TimeoutException catch (e) {
      throw Exception('Connection timed out. Server is unreachable. ${e.message}');
    } catch (e) {
      throw Exception('Error submitting data: ${e.toString()}');
    }
  }
}
