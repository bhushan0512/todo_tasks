import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/MyAppColors.dart';
import 'package:todo/constants/MyAppStyles.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/providers/radio_rovider.dart';
import 'package:todo/providers/service_provider.dart';

import 'package:todo/widgets/my_textformfield.dart';
import 'package:todo/widgets/radio_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  static GlobalKey<FormState> _formKey = GlobalKey();

  static TextEditingController titleController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: UIColor.White,
        ),
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Task Details",
                    textAlign: TextAlign.center,
                    style: MyAppStyles().boldBlackRegularInter(fontSize: 28.sp),
                  )),
              Divider(
                thickness: 1.2,
                color: UIColor.Grey,
              ),
              SizedBox(height: 12.h),
              Text(
                "Title Task",
                style: MyAppStyles()
                    .semiBoldBlackRegularInter(fontSize: 16.sp), //heading one
              ),
              SizedBox(height: 6.h),
              MyTextField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 1) {
                      return 'Title is too short!';
                    }
                    return null;
                  },
                  inputAction: TextInputAction.done,
                  maxLines: 1,
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  controller: titleController,
                  hintText: "Add Task name",
                  obscureText: false),
              SizedBox(height: 12.h),
              Text(
                "Description",
                style: MyAppStyles()
                    .semiBoldBlackRegularInter(fontSize: 16.sp), //heading one
              ),
              SizedBox(height: 6.h),
              MyTextField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 1) {
                      return 'Description is too short!';
                    }
                    return null;
                  },
                  inputAction: TextInputAction.done,
                  maxLines: 4,
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  controller: descriptionController,
                  hintText: "Add Descriptions",
                  obscureText: false),
              SizedBox(height: 12.h),
              Text(
                "Category",
                style: MyAppStyles()
                    .semiBoldBlackRegularInter(fontSize: 16.sp), //heading one
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioWidget(
                      titleRadio: "PEND",
                      categColor: Colors.red,
                      inputValue: 1,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 1),
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      titleRadio: "PROG",
                      categColor: Colors.orange,
                      inputValue: 2,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 2),
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      titleRadio: "DONE",
                      categColor: Colors.green,
                      inputValue: 3,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 3),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UIColor.White,
                        foregroundColor: UIColor.Green,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: UIColor.Green),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      onPressed: () {
                        ref.read(radioProvider.notifier).update((state) => 1);
                        titleController.clear();
                        descriptionController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UIColor.Green,
                        foregroundColor: UIColor.White,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      onPressed: () {
                        final getRadioValue = ref.read(radioProvider);

                        String category = '';

                        switch (getRadioValue) {
                          case 1:
                            category = 'Pending';
                            break;
                          case 2:
                            category = 'Progress';
                            break;
                          case 3:
                            category = "Done";
                            break;
                        }
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        ref.read(serviceProvider).addNewTask(TodoModel(
                              titleTask: titleController.text,
                              description: descriptionController.text,
                              category: category,
                              isDone: false,
                              isStar: false,
                            ));
                        ref.read(radioProvider.notifier).update((state) => 1);
                        titleController.clear();
                        descriptionController.clear();

                        Navigator.of(context).pop();
                      },
                      child: Text("Create"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
