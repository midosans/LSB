import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Text.dart';

class Massagescreen extends StatelessWidget {
  const Massagescreen({super.key});
  final List<CustomText> tiles = const [
    CustomText(text: 'message', color: ColorsHelper.white, fontSize: 18)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Massage Screen'),
        backgroundColor: ColorsHelper.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(text: 'Saved message', color: ColorsHelper.orange, fontSize: 24) 
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(text: '  Your Messages', color: ColorsHelper.white, fontSize: 24)
            ),
            const Divider(thickness: 1, indent: 10, endIndent: 10, height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tiles.length,
                  itemBuilder: (BuildContext, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: tiles[i],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
