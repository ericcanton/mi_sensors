import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

// Provider for FlutterReactiveBle instance
final bleProvider = Provider((ref) => FlutterReactiveBle());

// StateNotifierProvider for managing discovered devices
final devicesProvider =
    StateNotifierProvider<DeviceListNotifier, List<DiscoveredDevice>>((ref) {
  return DeviceListNotifier(ref.read(bleProvider));
});

class DeviceListNotifier extends StateNotifier<List<DiscoveredDevice>> {
  DeviceListNotifier(this._ble) : super([]) {
    _ble.statusStream.listen((status) {
      print(status);
      if (status == BleStatus.ready) {
        _startScan();
      }
    });
  }

  final FlutterReactiveBle _ble;

  void _startScan() async {
    // Request Bluetooth permissions
    final permission = await Permission.bluetoothScan.request();
    if (permission.isGranted) {
      _ble.scanForDevices(withServices: []).listen((device) {
        if (device.name.isNotEmpty && !state.contains(device)) {
          state = [...state, device];
        }
      });
    } else {
      // Handle permission denied case (e.g., show a message to the user)
    }
  }
}

// StateProvider for the currently connected device
final connectedDeviceProvider = StateProvider<DiscoveredDevice?>((ref) => null);
