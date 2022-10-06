import 'package:dartz/dartz.dart';
import 'package:smart_wear/src/core/failure.dart';
import 'package:smart_wear/src/core/usecases.dart';
import 'package:smart_wear/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

class ConnectDeviceUsecase extends UseCase<void, DeviceParams> {
  ConnectDeviceUsecase({required this.deviceRepository});
  final DeviceRepository deviceRepository;

  @override
  Either<Failure, bool> call(DeviceParams params) {
    return deviceRepository.connect(params.device);
  }
}

class DeviceParams {
  final DeviceEntity device;
  DeviceParams({
    required this.device,
  });
}
