import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_sensors/providers/connected_devices.dart';

class DeviceListScreen extends ConsumerWidget {
  DeviceListScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Bluetooth Devices')),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index].name),
            onTap: () {
              ref.read(connectedDeviceProvider.notifier).state = devices[index];
              ref.read(bleProvider).connectToDevice(
                  id: devices[index].id); // Initiate connection
            },
          );
        },
      ),
    );
  }
}
