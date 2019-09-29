abstract class LocationPermissionService {
  Future<bool> hasLocationPermission();

  Future<bool> requestLocationPermission();
}
