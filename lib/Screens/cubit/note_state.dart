part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}
final class NoteAddState extends NoteState {}
final class NoteremoveState extends NoteState {}
final class NoteremoveAllState extends NoteState {}
final class NoteGetState extends NoteState {}
final class NoteUpdateState extends NoteState {}
final class NoteLoadingState extends NoteState {}
final class NoteSuccessState extends NoteState {}
final class NoteErrorState extends NoteState {}

