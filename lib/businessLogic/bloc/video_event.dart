part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class AddCheckBoxValChanged extends VideoEvent {
  final bool? val;
  AddCheckBoxValChanged({
    required this.val,
  });
}
class FetchCheckBoxVal extends VideoEvent {}

