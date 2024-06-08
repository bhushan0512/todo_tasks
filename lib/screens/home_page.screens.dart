import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:todo/models/show_model.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/constants/MyAppColors.dart';
import 'package:todo/constants/MyAppStyles.dart';
import 'package:todo/providers/service_provider.dart';
import 'package:todo/widgets/card_todo_widget.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final fetchStreamProviderWrapperNotifier = Provider.autoDispose<void>((ref) {
    ref.watch(fetchStreamProviderWrapper);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(fetchStreamProviderWrapperNotifier);
    // first variable is to get the data of Authenticated User
    final data = ref.watch(fireBaseAuthProvider);

    //  Second variable to access the Logout Function
    final auth = ref.watch(authenticationProvider);

    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          PhosphorIcons.plus(),
          size: 25.h,
          color: UIColor.Black,
        ),
        backgroundColor: UIColor.LightGreen,
        onPressed: () {
          showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            context: context,
            builder: (context) => AddNewTaskModel(),
          );
        },
      ),
      backgroundColor: UIColor.Grey,
      appBar: AppBar(
        backgroundColor: UIColor.Green,
        elevation: 0,
        title: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
          title: Text(
            "Hello,",
            style: MyAppStyles().semiBoldBlackRegularInter(fontSize: 18.sp),
          ),
          subtitle: Text(
            data.currentUser?.email ?? "No email",
            style: MyAppStyles().whiteRegularInter(fontSize: 14.sp),
          ),
          trailing: GestureDetector(
            onTap: () => FirebaseAuth.instance.signOut(),
            child: Icon(
              PhosphorIcons.signOut(),
              size: 25.h,
              color: UIColor.Black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today\'s Task",
                        style: MyAppStyles()
                            .boldBlackRegularInter(fontSize: 24.sp),
                      ),
                      Text(
                        DateFormat('EEEE, d MMMM').format(DateTime.now()),
                        style:
                            MyAppStyles().darkGreyRegularInter(fontSize: 16.sp),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                  itemCount: todoData.value?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CardToDoListWidget(
                        index: index,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
