import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus {
  online,
  offline,
  unknown,
}

ConnectivityStatus _mapResult(dynamic result) {
  if (result is List) {
    if (result.isEmpty ||
        (result.length == 1 && result.contains(ConnectivityResult.none))) {
      return ConnectivityStatus.offline;
    }
    return ConnectivityStatus.online;
  }
  if (result == ConnectivityResult.none) {
    return ConnectivityStatus.offline;
  }
  return ConnectivityStatus.online;
}

final connectivityProvider = StreamProvider<ConnectivityStatus>((ref) async* {
  final connectivity = Connectivity();
  yield _mapResult(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(_mapResult);
});
