import 'package:dio/dio.dart';
import 'package:lsb/helper/Api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> RefreshService() async {
  final Dio dio = Dio();
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token') ;
  try {
    final response = await dio.post(
      BaseURL + '/refresh',
      options: Options(
        headers: {'Authorization': "Bearer ${refreshToken}",
      } ,
        ),
    );
    final responseData = response.data as Map<String, dynamic>;
    if(responseData["status"] == 'success'){
      await prefs.setString('token', responseData['access_token']);
    } 
    return true;
  } catch (e) {
    print('Error in RefreshService: $e');
    return false;
  }
}
