import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/Screens/Note.dart';
import 'package:note_app/Screens/cubit/note_cubit.dart';
import 'package:note_app/Hive/hive_helper.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveHelper.note_box);

  runApp(

    MyApp()
    // DevicePreview(
    //  builder: (context) => MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit()..loadNotes(),
      child: GetMaterialApp(
        // builder: DevicePreview.appBuilder,
        // locale: DevicePreview.locale(context),
        home: Note(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
