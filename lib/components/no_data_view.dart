import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSectionHeaderColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 100, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kNoDataImageBanner),
            const SizedBox(height: 10,),
            const Text(kNoRecordsFound, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kListTitleColor),)
          ],
        ),
      ),
    );
  }
}
