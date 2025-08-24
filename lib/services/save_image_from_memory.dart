import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lsb/services/image_permissions_checker.dart';
import 'package:saver_gallery/saver_gallery.dart';

Future<void> saveImageFromMemory(
    BuildContext context, Uint8List bytes, String filename) async {
  final hasPermission =
      await checkAndRequestPermissions(skipIfExists: false);

  if (!hasPermission) {
    // Show snackbar if no permission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Permission denied. Cannot save image."),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    await SaverGallery.saveImage(
      bytes,
      fileName: filename,
      androidRelativePath: "Pictures/LSB Secret",
      skipIfExists: false,
    );

  } catch (e) {
    // Show snackbar on error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to save image: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}








// import 'dart:typed_data';
// import 'package:lsb/services/image_permissions_checker.dart';
// import 'package:saver_gallery/saver_gallery.dart';

// Future<void> saveImageFromMemory(Uint8List bytes, String filename) async {
//   final hasPermission =await checkAndRequestPermissions(skipIfExists: false);
//   if (hasPermission) {
//     try {
//       await SaverGallery.saveImage(
//         bytes,
//         fileName: filename,
//         androidRelativePath: "Pictures/LSB Secret",
//         skipIfExists: false,
//       );
//     } catch (e) {
//       throw Exception("Failed to save image: $e");
//     }
//   } 
// }

















// import 'dart:io' show Directory, File, Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:html' as html;
  // if (kIsWeb) {
  //   // // ✅ Web: trigger browser download
  //   // final blob = html.Blob([bytes]);
  //   // final url = html.Url.createObjectUrlFromBlob(blob);
  //   // final anchor = html.AnchorElement(href: url)
  //   //   ..setAttribute("download", filename)
  //   //   ..click();
  //   // html.Url.revokeObjectUrl(url);
  // } 
  // else if (Platform.isAndroid || Platform.isIOS) {
  //   // ✅ Mobile: save into Downloads (or Documents on iOS)
  //   // var status = await Permission.storage.request();
  //   // if (!status.isGranted) throw Exception("Storage permission not granted");

  //   Directory? dir;
  //   if (Platform.isAndroid) {
  //     dir = Directory("/storage/emulated/0/Download"); // Downloads folder
  //   } else if (Platform.isIOS) {
  //     dir = await getApplicationDocumentsDirectory(); // App documents folder
  //   }

  //   if (dir == null) throw Exception("Cannot access save directory");

  //   final file = File("${dir.path}/$filename");
  //   await file.writeAsBytes(bytes);
  // }