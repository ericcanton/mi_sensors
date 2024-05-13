import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_sensors/providers/connected_devices.dart';

class DeviceScreen extends ConsumerWidget {
  final DiscoveredDevice device;

  DeviceScreen(this.device);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ble = ref.read(bleProvider); // Access the ble instance

    return Scaffold(
      appBar: AppBar(title: Text(device.name)),
      body: FutureBuilder<List<Service>>(
        future: _discoverServices(ble),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No services found.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].id.toString()),
                  // onTap: () {
                  // Navigate to the characteristics screen
                  // },
                );
              },
            );
          }
          // ... (Use snapshot.data to display services and characteristics)
        },
      ),
    );
  }

  Future<List<Service>> _discoverServices(FlutterReactiveBle ble) async {
    ble.discoverAllServices(device.id);
    return ble.getDiscoveredServices(device.id);
  }
}
