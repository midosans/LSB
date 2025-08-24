import 'package:bloc/bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:lsb/cubit/lsb.state.dart';
import 'package:lsb/helper/Api_helper.dart';
import 'package:lsb/services/refresh_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LsbCubit extends Cubit<LsbState> {
  LsbCubit() : super(LsbInitial());
  final Dio dio = Dio();
    Future<void> embed({
    required String message,
    required String password,
    required dynamic pickedFile, // XFile or File depending on platform
  }) async {
    emit(EmbedLoading());

    try {
      // Load token
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('token');

      // Create MultipartFile for image
      MultipartFile multipartImage;
      if (kIsWeb) {
        // On web we must read bytes and wrap them manually
        final bytes = await pickedFile.readAsBytes();
        multipartImage = MultipartFile.fromBytes(
          bytes,
          filename: "image.png",
          // contentType: MediaType("image", "png"),
        );
      } else {
        // On mobile/desktop we can use fromFile
        multipartImage = await MultipartFile.fromFile(
          pickedFile.path,
          filename: "image.png",
          contentType: MediaType("image", "png"),
        );
      }

      // Match backend field names EXACTLY: message, password, image
      final formData = FormData.fromMap({
        'message': message,
        'password': password,
        'image': multipartImage,
      });

      final response = await dio.post(
        '$BaseURL/embed',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': "Bearer $accessToken"},
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 401) {
        RefreshService();
        embed(message: message, password: password, pickedFile: pickedFile);
      } else if (response.statusCode == 200) {

        emit(EmbedSuccess(bytes: response.data));
      } else {
        final responseData = response.data as Map<String, dynamic>;
        emit(
          EmbedFailure(
            message:
                'Error:- ${responseData['reason']}',
          ),
        );
      }
    } 
    catch (e) {
  if (e is DioException && e.response != null) {
    final data = e.response?.data;

    String? reason;
    if (data is Map<String, dynamic>) {
      reason = data['reason']?.toString();
    } else if (data is String) {
      // In case backend sends plain text error
      reason = data;
    }

    emit(EmbedFailure(
      message: reason ?? 'Request failed',
    ));
  } else {
    emit(EmbedFailure(message: e.toString()));
  }
}
  }
  Future<void> extract({
    required String password,
    required dynamic pickedFile,
  }) async {
    emit(ExtractLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('token');

      // Create MultipartFile for image
      MultipartFile multipartImage;
      if (kIsWeb) {
        // On web we must read bytes and wrap them manually
        final bytes = await pickedFile.readAsBytes();
        multipartImage = MultipartFile.fromBytes(
          bytes,
          filename: "image.png",
          // contentType: MediaType("image", "png"),
        );
      } else {
        // On mobile/desktop we can use fromFile
        multipartImage = await MultipartFile.fromFile(
          pickedFile.path,
          // filename: "image.png",
          // contentType: MediaType("image", "png"),
        );
      }
      final formData = FormData.fromMap({
        'password': password,
        'image': multipartImage,
      });

      final response = await dio.post(
        '$BaseURL/extract',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 401) {
        RefreshService();
        extract(password: password, pickedFile: pickedFile);
      } else if (response.statusCode == 200) {
        final responseMessage = (response.data['message']);
        emit(ExtractSuccess(message: (responseMessage.toString())));
      } else {
        final responseData = response.data as Map<String, dynamic>;
        emit(
          ExtractFailure(
            message:
                'Error:- ${responseData['reason']}',
          ),
        );
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

    emit(ExtractFailure(
      message: reason ?? 'Request failed',
    ));
  } else {
    emit(ExtractFailure(message: e.toString()));
  }
}
  }
   Future saveMessage({
    required String message,
  }) async {
    final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('token');
    final formData = FormData.fromMap({
      'message': message,      // 'rememberMe' :  rememberMe
    });
    emit(SaveMessageLoading());
    try {
      final response = await dio.post(
        '$BaseURL/save_message',
        data: formData,
        options: Options(contentType: 'application/json',
        headers:{'Authorization': "Bearer $accessToken"}, ),
      );
      if(response.statusCode == 401) {
        RefreshService();
        saveMessage(message: message);
      }
      else if (response.statusCode == 200) {
        emit(SaveMessageSuccess());
        return response.data;
      } else {
        final responseData = response.data as Map<String, dynamic>;
        emit(SaveMessageFailure(
            message:
                'Error:- ${responseData['reason']}',
          ));
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

    emit(SaveMessageFailure(
      message: reason ?? 'Request failed',
    ));
  } else {
    emit(SaveMessageFailure(message: e.toString()));
  }
}
  }
}
