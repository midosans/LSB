import 'package:dio/dio.dart';
import 'package:lsb/helper/Api_helper.dart';
import 'package:lsb/services/refresh_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  final Dio dio = Dio();

  Future<List<String>> getAllMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('token');
    try {
      final response = await dio.get(
        "$BaseURL/get_all_messages",
        options: Options(
          headers: {"Authorization": "Bearer $accessToken"},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'success') {
          final List<dynamic> rawMessages = data['messages'];
          return rawMessages.map((e) => e.toString()).toList();
        } else {
          throw Exception(data['reason'] ?? "Failed to load messages");
        }
      } else if (response.statusCode == 401) {
        RefreshService();
        return getAllMessages(); 
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching messages: $e");
    }
  }
}
