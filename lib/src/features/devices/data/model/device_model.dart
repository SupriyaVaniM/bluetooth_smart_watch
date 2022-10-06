import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

class DeviceModel extends DeviceEntity {
  
  DeviceModel({
    required String name,
    required String id,
    required int strength,
    required DeviceKind kind,
  }) : super(name : name, id: id,strength: strength,kind: kind);
}