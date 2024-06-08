import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/providers/radio_rovider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.categColor,
    required this.inputValue,
    required this.onChangeValue,
  });

  final String titleRadio;
  final Color categColor;
  final int inputValue;
  final VoidCallback onChangeValue;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Theme(
      data: ThemeData(unselectedWidgetColor: categColor),
      child: RadioListTile(
        activeColor: categColor,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: Offset(-22, 0),
          child: Text(
            titleRadio,
            style: GoogleFonts.inter(
                color: categColor,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp),
          ),
        ),
        value: inputValue,
        groupValue: radio,
        onChanged: (value) => onChangeValue(),
      ),
    );
  }
}
