import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app1/data/result_connection.dart';

part 'connection_states.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  ConnectionCubit()
      : super(ConnectionResult(connectionState: ResultConnection.Fetching));
  void changeStatetoLoading() =>
      emit(ConnectionResult(connectionState: ResultConnection.Fetching));
}
