import 'package:bloc/bloc.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:lsb/helper/Api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final Dio dio = Dio();

  Future<dynamic> register({
    required String user_name,
    required String password,
    required String pass_confirm,
  }) async {
    final formData = FormData.fromMap({
      'user_name': user_name,
      'password': password,
      'pass_confirm': pass_confirm,
    });
    emit(RegisterLoading());
    try {
      final response = await dio.post(
        '$BaseURL/register',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 200) {
        emit(Registersuccess());
      } else {
        emit(RegeisterFailure(response.data['reason'] ?? 'Registration failed'));
      }
    } catch (e) {
  if (e is DioException && e.response != null) {
    final data = e.response?.data;

    String? reason;
    if (data is Map<String, dynamic>) {
      reason = data['reason']?.toString();
    } else if (data is String) {
      reason = data;
    }

    emit(RegeisterFailure(
       reason ?? 'Request failed',
    ));
  } else {
    emit(RegeisterFailure( e.toString()));
  }
}
  }
  Future login({
    required String user_name,
    required String password,
    required bool rememberMe,
  }) async {
    final formData = FormData.fromMap({
      'user_name': user_name,
      'password': password,
      // 'rememberMe' :  rememberMe
    });
    emit(LoginLoading());
    try {
      final response = await dio.post(
        '$BaseURL/login',
        data: formData,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        final perf = await SharedPreferences.getInstance();
          await perf.setString('user_name', user_name);
          await perf.setString('token', responseData['access_token']);
        if (rememberMe) {
          await perf.setString('refresh_token', responseData['refresh_token']);
        }
        emit(LoginSuccess());
        return response.data;
      } else {
        emit(LoginFailure(message: response.data['reason'] ?? 'Login failed'));
      }
    } catch (e) {
  if (e is DioException && e.response != null) {
    final data = e.response?.data;

    String? reason;
    if (data is Map<String, dynamic>) {
      reason = data['reason']?.toString();
    } else if (data is String) {
      // In case backend sends plain text error
      reason = data;
    }

    emit(LoginFailure(
      message: reason ?? 'Request failed',
    ));
  } else {
    emit(LoginFailure(message: e.toString()));
  }
}
  }
  }
