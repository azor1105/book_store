import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DayItem extends StatelessWidget {
  const DayItem({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          now.day == dateTime.day &&
                  now.month == dateTime.month &&
                  now.year == dateTime.year
              ? 'Today'
              : DateFormat.MMMMd().format(dateTime),
          style: PoppinsFont.w600.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  final DateTime dateTime;
}
