import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_sensors/providers/connected_devices.dart';
import 'package:mi_sensors/widgets/device_list_screen.dart';
import 'package:mi_sensors/widgets/device_screen.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectedDevice = ref.watch(connectedDeviceProvider);

    return MaterialApp(
      home: connectedDevice != null
          ? DeviceScreen(connectedDevice)
          : DeviceListScreen(),
    );
  }
}
