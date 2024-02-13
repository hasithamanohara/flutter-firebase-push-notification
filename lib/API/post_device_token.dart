import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> sendDeviceToken(String token) async {
    final url =
        'https://your-backend-api.com/token-endpoint'; // Replace with your actual API endpoint
    final data = {'deviceToken': token}; // Customize the payload as needed

    try {
      await _dio.post(url, data: data);
      print('Device token sent successfully!');
    } catch (e) {
      print('Error sending device token: $e');
    }
  }
}
