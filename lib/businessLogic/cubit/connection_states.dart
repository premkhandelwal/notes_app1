part of 'connection_cubit.dart';

@immutable
abstract class ConnectionStates {
  
}

class ConnectionResult extends ConnectionStates {
  final ResultConnection connectionState;
  final int? counterValue;
  ConnectionResult({
    required this.connectionState,
  this.counterValue
  });




}
