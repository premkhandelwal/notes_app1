part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}


class NotesLoadInProgress extends NotesState {}

class NotesLoadSuccess extends NotesState {
   NotesLoadSuccess({this.notes, this.activeNote});

  final List<Notes?>? notes;
  final Notes? activeNote;

  NotesLoadSuccess copyWith({
    List<Notes?>? notes,
  }) {
    return NotesLoadSuccess(
      notes:  this.notes,
      activeNote: activeNote ?? this.activeNote,
    );
  }

}

class NotesLoadFailure extends NotesState {}