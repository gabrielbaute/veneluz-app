import 'package:geolocator/geolocator.dart';

/// Servicio encargado del manejo de permisos y captura puntual de geolocalización.
class LocationService {
  /// Obtiene la posición GPS actual del dispositivo en un único llamado.
  ///
  /// Returns:
  /// - `Position` (Position): un objeto [Position] si el permiso fue concedido y el GPS está activo.
  /// Retorna `null` si la ubicación está desactivada o el usuario deniega los permisos.
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
