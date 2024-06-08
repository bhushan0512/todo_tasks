import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/MyAppColors.dart';
import 'package:todo/constants/MyAppStyles.dart';
import 'package:todo/models/show_update_model.dart';
import 'package:todo/providers/service_provider.dart';

class CardToDoListWidget extends ConsumerWidget {
  const CardToDoListWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
      data: (todoData) {
        final getCategory = todoData[index].category;
        Color categoryColor = UIColor.White;

        switch (getCategory) {
          case 'Pending':
            categoryColor = UIColor.Red;
            break;
          case 'Progress':
            categoryColor = UIColor.Orange;
            break;
          case 'Done':
            categoryColor = UIColor.Green;
            break;
        }

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (context) => EditNewTaskModel(
                      title: todoData[index].titleTask,
                      description: todoData[index].description,
                      category: todoData[index].category,
                      docID: todoData[index].docID,
                    ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: UIColor.White, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      onLongPress: () {
                        _showPopupMenu(
                            context, ref, todoData[index].docID ?? "");
                      },
                      leading: Text(
                        (index + 1).toString(),
                        style: MyAppStyles().semiBoldBlackRegularInter(
                          fontSize: 16.sp,
                          decoration: todoData[index].isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      title: Text(
                        todoData[index].titleTask,
                        maxLines: 3,
                        style: MyAppStyles().semiBoldBlackRegularInter(
                          fontSize: 14.sp,
                          decoration: todoData[index].isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(
                        todoData[index].description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MyAppStyles().blackRegularInter(
                          fontSize: 12.sp,
                          decoration: todoData[index].isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          shape: CircleBorder(),
                          value: todoData[index].isDone,
                          onChanged: (value) => ref
                              .read(serviceProvider)
                              .updateTask(todoData[index].docID, value),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  width: 20.w,
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text("Error"),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _showPopupMenu(BuildContext context, WidgetRef ref, String docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Pin'),
                onTap: () {
                  Navigator.pop(context, 'pin');
                },
              ),
              ListTile(
                title: Text('Unpin'),
                onTap: () {
                  Navigator.pop(context, 'unpin');
                },
              ),
              ListTile(
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context, 'delete');
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value == 'pin') {
        // Implement pin functionality
        ref.read(serviceProvider).updateStarTask(docID, true);
      } else if (value == 'unpin') {
        // Implement unpin functionality
        ref.read(serviceProvider).updateStarTask(docID, false);
      } else if (value == 'delete') {
        // Implement delete functionality
        ref.read(serviceProvider).deleteTask(docID);
      }
    });
  }
}
