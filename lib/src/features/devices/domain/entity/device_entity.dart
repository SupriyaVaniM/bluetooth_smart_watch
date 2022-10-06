class DeviceEntity {
  final String name;
  final String id;
  final int strength;
  final DeviceKind kind;

  DeviceEntity({
    required this.name,
    required this.id,
    required this.strength,
    required this.kind,
  });

  factory DeviceEntity.empty() {
    return DeviceEntity(name: " ", id: " ", strength: 0, kind:DeviceKind.none);
  }
}

enum DeviceKind { ble, wifi, classicBluetooth, usb, none, unknown }