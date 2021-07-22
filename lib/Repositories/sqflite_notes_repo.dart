import 'package:notes_app1/repositories/video_repo.dart';

class SqfLiteRepo implements VideoRepository {
  @override
  bool isVideoAdded(bool val) {
    return true;
  }
}
