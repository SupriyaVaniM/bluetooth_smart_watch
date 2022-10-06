import 'package:flutter_blue/flutter_blue.dart';
import 'package:smart_wear/src/core/failure.dart';
import 'package:smart_wear/src/features/devices/data/local/helper/bluetooth_device_extension.dart';
import 'package:smart_wear/src/features/devices/data/model/device_model.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

abstract class DevicelocalDataSource {
  Stream<List<DeviceModel>> searchDevices(List<String> searchNames);

  bool connect(DeviceModel device);

  bool disconnect(DeviceModel device);
  
  Future<String> readField(DeviceModel device, String field);

 
}

class BluetoothDevicelocalDataSourceImpl extends DevicelocalDataSource {
  @override
  Stream<List<DeviceModel>> searchDevices(List<String> searchNames) {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    return flutterBlue.scanResults.map((event) => event
            .map((e) => DeviceModel(
                name: e.device.name,
                strength: e.rssi,
                id: e.device.id.id,
                kind: DeviceKind.ble))
            .where((deviceModel) {
          if (searchNames.isNotEmpty) {
            final regex = r'(' +
                searchNames.reduce((value, element) => '$value|$element') +
                ')';
            //used for pattern matching to find the device with the same name
            return deviceModel.name.contains(RegExp(regex));
          }
          return true;
        }).toList());
  }

  @override
  bool connect(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    bluetoothDevice
        .connect()
        .onError((error, stackTrace) => throw UnableToConnectDeviceFailure());
    return true;
  }

  @override
  bool disconnect(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    bluetoothDevice
        .disconnect()
        .onError((error, stackTrace) => throw UnableToConnectDeviceFailure());
    return false;
  }

  @override
  Future<String> readField(DeviceModel device, String field) async {
    final BluetoothDevice ble = device.toBluetoothDevice();
    final services = await ble.discoverServices();
    if (serviceMaps.containsKey(field)) {
      for (BluetoothService service in services) {
        if (service.uuid.toString() == serviceMaps[field]["serviceUUID"]) {
          final characteristics = service.characteristics;
          for (BluetoothCharacteristic characteristic in characteristics) {
            if (characteristic.uuid.toString() ==
                serviceMaps[field]["characteristicsUUID"]) {
              return (await characteristic.read()).toString();
              
            }
          }
        }
      }
    }
     return "";
  }
 
}

final Map serviceMaps = {
  "Battery": {
    "serviceUUID": "000180f-0000-1000-8000-00805f9b34fb",
    "characteristicsUUID": "00002a19-0000-1000-8000-00805f9b34fb",
  },
  "Manufacturer": {
    "serviceUUID": "0000180a-0000-1000-8000-00805f9b34fb",
    "characteristicUUID": "00002a29-0000-1000-8000-00805f9b34fb"
  },
  "Name": {
    "serviceUUID": "0000180a-0000-1000-8000-00805f9b34fb",
    "characteristicUUID": "00002a24-0000-1000-8000-00805f9b34fb"
  },
  "SerialNumber": {
    "serviceUUID": "0000180a-0000-1000-8000-00805f9b34fb",
    "characteristicUUID": "00002a29-0000-1000-8000-00805f9b34fb"
  },
   "HWVersionName": {
    "serviceUUID": "0000180a-0000-1000-8000-00805f9b34fb",
    "characteristicUUID": "00002a24-0000-1000-8000-00805f9b34fb"
  },
};
