import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:note_app/Screens/cubit/note_cubit.dart';
import 'package:note_app/Screens/reusable_widgets.dart';
import 'package:note_app/const.dart';

class Note extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final cubit = context.read<NoteCubit>();

    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if(state is NoteSuccessState){
          Get.snackbar("Success", "Data Loaded successfully", backgroundColor: Colors.green, colorText: Colors.white);
        }
        if(state is NoteErrorState){
          Get.snackbar("Error", "Error while Loading", backgroundColor: Colors.red, colorText: Colors.black);
        }
      },
      child: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            appBar: bar(cubit: cubit),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.myNotes.length,
                    itemBuilder: (c, i) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          showDialogFun(
                            context: context,
                            cubit: cubit,
                            title: "Edit Note",
                            buttonText: "Update",
                            controller: cubit.editController,
                            isUpdate: true,
                            index: i,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: (i % 2 == 0)
                                    ? const Color(color1)
                                    : const Color(color2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minHeight: height * 0.14, 
                              ),
                              padding: EdgeInsets.all(width * 0.06),
                              child: Center(
                                child: Text(
                                  cubit.myNotes[i],
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.visible, 
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  cubit.ClearNote(i);
                                  cubit.getNotes(); 
                                },
                                child: const Icon(CupertinoIcons.delete, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialogFun(
                  context: context,
                  cubit: cubit,
                  title: "Enter Note",
                  buttonText: "Add",
                  controller: cubit.addController,
                );
              },
              child: const Icon(CupertinoIcons.add),
            ),
          );
        },
      ),
    );
  }
}
