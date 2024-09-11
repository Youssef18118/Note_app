import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Hive/hive_helper.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  final addController = TextEditingController();
  final editController = TextEditingController();
  late List<String> myNotes = [];
  final bool isFirst = true;

  void loadNotes() async{
    emit(NoteLoadingState());
    await Future.delayed(const Duration(seconds: 3));

    try{
      hiveHelper.getNotes();
      myNotes = hiveHelper.notes;
      emit(NoteSuccessState());
    }catch(e){
      emit(NoteErrorState());

    }
    
    
  }

  void getNotes(){
    hiveHelper.getNotes();
    myNotes = hiveHelper.notes;
    emit(NoteGetState());


  }

  void updateNotes(int index, String text) {
    hiveHelper.updateNote(index!, text);
    emit(NoteUpdateState());
  }

  void AddNotes(String text) {
    hiveHelper.AddNote(text);
    emit(NoteAddState());
  }
  
  void ClearNotes() {
    hiveHelper.ClearNotes();
    emit(NoteremoveAllState());
  }

  void ClearNote(int i) {
    hiveHelper.removeNote(i);
    emit(NoteremoveState());
  }


}
