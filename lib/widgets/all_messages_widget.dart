import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/services/get_message.dart';
import 'package:lsb/services/refresh_service.dart';
import 'package:lsb/widgets/custom_Text.dart';

class AllMessagesWidget extends StatefulWidget {
  const AllMessagesWidget({super.key});

  @override
  State<AllMessagesWidget> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<AllMessagesWidget> {
  late Future<List<String>> messagesFuture;

  @override
  void initState() {
    super.initState();
    messagesFuture = _loadMessages();
  }

  Future<List<String>> _loadMessages() async {
    final refreshOk = await RefreshService();

    if (!refreshOk) {
      throw Exception("Refresh token expired, please login again");
    }

    final service = MessageService();
    return await service.getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: messagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(snapshot.error.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            });

            return Center(
              child: CustomText(
                text: snapshot.error.toString(),
                color: ColorsHelper.white,
                fontSize: 14.sp,
              ),
            );
          }

          final messages = snapshot.data ?? [];
          if (messages.isEmpty) {
            return  Center(
              child: CustomText(
                text: "No messages yet",
                color: ColorsHelper.white,
                fontSize: 12.sp,
              ),
            );
          }

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.only(bottom: 16.h),
                child: ListTile(
                  title: CustomText(
                    text: messages[index],
                    color: ColorsHelper.white,
                    fontSize: 15.sp,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:lsb/helper/Colors_Helper.dart';
// import 'package:lsb/services/get_message.dart';
// import 'package:lsb/services/refresh_service.dart';
// import 'package:lsb/widgets/custom_Text.dart';

// class AllMessagesWidget extends StatefulWidget {
//   const AllMessagesWidget({super.key});

//   @override
//   State<AllMessagesWidget> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<AllMessagesWidget> {
//   late Future<List<String>> messagesFuture;

//   @override
//   void initState() {
//     super.initState();
//     RefreshService();
//     final service = MessageService();
//     messagesFuture = service.getAllMessages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<String>>(
//         future: messagesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: CustomText(
//                 text: "Error: ${snapshot.error}",
//                 color: ColorsHelper.white,
//                 fontSize: 16,
//               ),
//             );
//           }
//           final messages = snapshot.data ?? [];
//           if (messages.isEmpty) {
//             return const Center(
//               child: CustomText(
//                 text: "No messages yet",
//                 color: ColorsHelper.white,
//                 fontSize: 10,
//               ),
//             );
//           }
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: messages.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: ListTile(
//                   title: CustomText(
//                     text: messages[index],
//                     color: ColorsHelper.white,
//                     fontSize: 10,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
