import 'dart:typed_data';
import 'dart:io' show Directory, File, Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'dart:html' as html;

Future<void> saveImageFromMemory(Uint8List bytes, String filename) async {
  if (kIsWeb) {
    // // ✅ Web: trigger browser download
    // final blob = html.Blob([bytes]);
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.AnchorElement(href: url)
    //   ..setAttribute("download", filename)
    //   ..click();
    // html.Url.revokeObjectUrl(url);
  } else if (Platform.isAndroid || Platform.isIOS) {
    // ✅ Mobile: save into Downloads (or Documents on iOS)
    var status = await Permission.storage.request();
    if (!status.isGranted) throw Exception("Storage permission not granted");

    Directory? dir;
    if (Platform.isAndroid) {
      dir = Directory("/storage/emulated/0/Download"); // Downloads folder
    } else if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory(); // App documents folder
    }

    if (dir == null) throw Exception("Cannot access save directory");

    final file = File("${dir.path}/$filename");
    await file.writeAsBytes(bytes);
  }
}