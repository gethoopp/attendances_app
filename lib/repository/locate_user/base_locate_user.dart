import 'package:geolocator/geolocator.dart';

abstract class BaseLocationUser {
  Future<String> getLocationUser();
  Future<Position> getLocationUserPosition();
  Future<bool> getPermisionLocation();
}
