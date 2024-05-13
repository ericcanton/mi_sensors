# mi_sensors

Uses BLE to scan for and connect to MiBand devices. Tested with MiBand 5.

The devices it connects do can be browsed for data. As a first aim, we want to collect raw gyroscope or accelerometer data and save to CSV.

TODO: 
1. Scan for and connect to devices.
2. Implement auth flow with device and start reading raw bytes.
3. Parse gyroscope data into timestamped triples
4. Save to CSV.