import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<bool> checkAndRequestPermissions({required bool skipIfExists}) async {
  if (!Platform.isAndroid && !Platform.isIOS) {
    return false; // Only Android and iOS supported
  }

  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;

    if (sdkInt >= 33) {
      // Android 13+ → use READ_MEDIA_IMAGES
      return await Permission.photos.request().isGranted;
    } else if (sdkInt >= 29) {
      // Android 10–12 → use storage permission
      if (skipIfExists) {
        return await Permission.storage.request().isGranted;
      }
      // For saving images, WRITE is not needed but STORAGE is required
      return await Permission.storage.request().isGranted;
    } else {
      // Android 9 and below → needs full storage permission
      return await Permission.storage.request().isGranted;
    }
  } else if (Platform.isIOS) {
    // iOS gallery permissions
    return skipIfExists
        ? await Permission.photos.request().isGranted
        : await Permission.photosAddOnly.request().isGranted;
  }

  return false; // Unsupported platform
}

// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:device_info_plus/device_info_plus.dart';

// Future<bool> checkAndRequestPermissions({required bool skipIfExists}) async {
//   if (!Platform.isAndroid && !Platform.isIOS) {
//     return false; // Only Android and iOS platforms are supported
//   }

//   if (Platform.isAndroid) {
//     final deviceInfo = await DeviceInfoPlugin().androidInfo;
//     final sdkInt = deviceInfo.version.sdkInt;

//     if (skipIfExists) {
//       // Read permission is required to check if the file already exists
//       return sdkInt >= 33
//           ? await Permission.photos.request().isGranted
//           : await Permission.storage.request().isGranted;
//     } else {
//       // No read permission required for Android SDK 29 and above
//       return sdkInt >= 29 ? true : await Permission.storage.request().isGranted;
//     }
//   } else if (Platform.isIOS) {
//     // iOS permission for saving images to the gallery
//     return skipIfExists
//         ? await Permission.photos.request().isGranted
//         : await Permission.photosAddOnly.request().isGranted;
//   }

//   return false; // Unsupported platforms
// }