import 'package:hive_flutter/hive_flutter.dart';

class hiveHelper{
  // add note
  // get Notes
  // remove note
  // clear All notes
  // update notes
  static const note_box = "NoteBox";
  static List<String> notes = [];

  static void AddNote(var note){
    notes.add(note);
    Hive.box(note_box).put(note_box, notes);
  }

  static void getNotes(){
    var storedNotes = Hive.box(note_box).get(note_box) as List<dynamic>?;
    notes = storedNotes?.cast<String>() ?? [];
  }

  static void removeNote(int index){
    notes.removeAt(index);
    Hive.box(note_box).put(note_box, notes);
  }

  static void ClearNotes(){
    notes.clear();
    Hive.box(note_box).put(note_box, notes);
  }

  static void updateNote(int index, String note){
    notes[index] = note;
    Hive.box(note_box).put(note_box, notes);
  }


}