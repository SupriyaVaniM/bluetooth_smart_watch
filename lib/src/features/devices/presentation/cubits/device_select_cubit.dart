import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/connect_device_usecase.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/disconnect_device_usecase.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/devices_connected_state.dart';

class DeviceSelectCubit extends Cubit<DeviceState> {
  DeviceSelectCubit({
    required this.connectDeviceUsecase,
    required this.disconnectDeviceUsecase,
  }) : super(DeviceState.initial());
  final ConnectDeviceUsecase connectDeviceUsecase;
  final DisconnectDeviceUsecase disconnectDeviceUsecase;

  void connect(DeviceEntity device) {
    final result = connectDeviceUsecase.call(DeviceParams(device: device));
    result.fold((l) => emit(DeviceState.error("No device connected")),
        (r) => emit(DeviceState.connected(device, true)));
  }

  void disConnect(DeviceEntity device) {
    final result = disconnectDeviceUsecase.call(DeviceParams(device: device));
    result.fold((l) => emit(DeviceState.error("No device connected")),
        (r) => emit(DeviceState.connected(device, false)));
  }
}
