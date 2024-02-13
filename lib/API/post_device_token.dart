import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> sendDeviceToken(String token) async {
    final url = 'https://backend-endpoint';
    final data = {'deviceToken': token};

    try {
      await _dio.post(url, data: data);
      print('Device token sent successfully!');
    } catch (e) {
      print('Error sending device token: $e');
    }
  }
}
