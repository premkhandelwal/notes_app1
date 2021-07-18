part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {
}

class AddNotes extends NotesEvent{
   AddNotes(this.note);

  final Notes note;
}

class FetchNotes extends NotesEvent{
  
}
