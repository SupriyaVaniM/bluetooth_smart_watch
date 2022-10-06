import 'package:equatable/equatable.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

enum DeviceStatus { initial, connected, error }

class DeviceState extends Equatable {
   DeviceState.initial()
      : devices = DeviceEntity.empty(),
        message = null,
        connected = false,
        status = DeviceStatus.initial;

   const DeviceState.connected(this.devices,this.connected)
      : message = null,
        status = DeviceStatus.connected;

  
   DeviceState.error(this.message)
      : devices =  DeviceEntity.empty(),
        connected = false,
        status = DeviceStatus.error;

  final DeviceStatus status;
  final String? message;
  final DeviceEntity devices;
  final bool connected;
  @override
  List<Object?> get props => [message, devices, status,connected];
}
