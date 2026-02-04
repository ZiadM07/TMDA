// ignore_for_file: library_prefixes

import 'package:location/location.dart' as O;
import 'package:permission_handler/permission_handler.dart';

import '../constants/exports.dart';

abstract class Permissions {
  Future<void> getAllPermissions();
  Future<void> requestLocationPermission();
  Future<void> requestStoragePermission();
  Future<void> requestAudioPermission();
  Future<void> requestPhotosPermission();
  Future<void> requestCameraPermission();
  O.Location get location;
}

@LazySingleton(as: Permissions)
class PermissionsInfo implements Permissions {
  @override
  final O.Location location;
  PermissionsInfo({required this.location});

  @override
  Future<void> requestLocationPermission() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      await location.requestService();
    }
    final permissionGranted = await location.hasPermission();
    if (permissionGranted == O.PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  @override
  Future<void> requestStoragePermission() async {
    await Permission.storage.request();
  }

  @override
  Future<void> requestCameraPermission() async {
    await Permission.camera.request();
  }

  @override
  Future<void> requestPhotosPermission() async {
    await Permission.photos.request();
  }

  @override
  Future<void> requestAudioPermission() async {
    await Permission.audio.request();
  }

  @override
  Future<void> getAllPermissions() async {
    await requestStoragePermission();
    await requestLocationPermission();
    await requestAudioPermission();
    await requestPhotosPermission();
    await requestCameraPermission();
  }
}
