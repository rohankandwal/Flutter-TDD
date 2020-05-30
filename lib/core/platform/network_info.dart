
// Abstract class used for checking if we have internet connection or not
abstract class NetworkInfo {
  Future<bool> get isConnected;
}