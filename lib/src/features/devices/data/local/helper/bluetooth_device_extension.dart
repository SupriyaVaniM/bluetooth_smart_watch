import 'package:flutter_blue/flutter_blue.dart';
import 'package:smart_wear/src/features/devices/data/model/device_model.dart';
import 'package:flutter_blue/gen/flutterblue.pb.dart' as proto;
extension BluetoothDeviceExtension on DeviceModel {
  BluetoothDevice toBluetoothDevice() {
    proto.BluetoothDevice p = proto.BluetoothDevice.create();
    p.name = name;
    p.type = proto.BluetoothDevice_Type.LE;
    p.remoteId = id;
    return BluetoothDevice.fromProto(p);
  }
}
