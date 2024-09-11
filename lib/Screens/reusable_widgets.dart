import 'package:flutter/material.dart';
import 'package:note_app/Hive/hive_helper.dart';
import 'package:note_app/Screens/cubit/note_cubit.dart';

void showDialogFun({
  required BuildContext context,
  required NoteCubit cubit,
  required String title,
  required String buttonText,
  required TextEditingController controller,
  bool isUpdate = false,
  int? index,
}) {
  if (isUpdate) {
    controller.text = hiveHelper.notes[index!];
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          maxLines: null, 
          textAlignVertical: TextAlignVertical.top, 
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your note here',
          ),
        ),
        actions: [
          MaterialButton(
            elevation: 5.0,
            child: Text(buttonText, style: const TextStyle(fontSize: 20)),
            onPressed: () {
              if (isUpdate) {
                cubit.updateNotes(index!, controller.text);
              } else {
                cubit.AddNotes(controller.text);
              }
              controller.clear();
              cubit.getNotes(); // Refresh the list of notes
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

AppBar bar({
  required NoteCubit cubit,
}) {
  return AppBar(
    backgroundColor: Colors.lightBlue,
    title: const Text("Note Application",
        style: TextStyle(fontSize: 20, color: Colors.white)),
    centerTitle: false,
    actions: [
      Container(
        width: 100,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              cubit.ClearNotes();
              cubit.getNotes();
            },
            child: const Text("Clear All",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
      const SizedBox(width: 10),
    ],
  );
}
