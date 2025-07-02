// import 'package:bloc/bloc.dart';
// import 'package:lsb/cubit/auth_state.dart';
// import 'package:dio/dio.dart';
// import 'package:lsb/helper/Api_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//   final Dio dio = Dio();

//   Future<dynamic> register(
//     String user,
//     String password,
//     String pass_confirm,
//   ) async {
//     emit(RegisterLoading());
//     try {
//       final response = await dio.post(
//         '$BaseURL/register',
//         data: {
//           'user_name': user,
//           'password': password,
//           'pass_confirm': pass_confirm,
//         },
//       );
//       if (response.statusCode == 200) {
//         emit(Registersuccess());
//       } else {
//         emit(RegeisterFailure('Registration failed'));
//       }
//     } catch (e) {
//       emit(RegeisterFailure(e.toString()));
//     }
//   }

//   Future login(String user_name, String password, bool rememberMe) async {
//     emit(LoginLoading());
//     try {
//       final response = await dio.post(
//         '$BaseURL/login',
//         data: {'user_name': user_name, 'password': password},
//       );
//       if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
//         final responseData = response.data as Map<String, dynamic>;
//         final perf = await SharedPreferences.getInstance();
//         if (rememberMe) {
//           await perf.setString('user_name', responseData['user_name']?.toString() ?? '');
//           await perf.setString('token', responseData['token']?.toString() ?? '');
//         } 
//         emit(LoginSuccess());
//         return response.data;
//       } else {
//         emit(LoginFailure(message:'$response'));
//       }
//     } catch (e) {
//       emit(LoginFailure(message: e.toString()));
//     }
//   }
// }
