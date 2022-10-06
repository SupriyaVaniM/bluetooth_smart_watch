import 'package:dartz/dartz.dart';
import 'package:smart_wear/src/core/failure.dart';
import 'package:smart_wear/src/core/usecases.dart';
import 'package:smart_wear/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/connect_device_usecase.dart';

class DisconnectDeviceUsecase extends UseCase<void, DeviceParams> {
  DisconnectDeviceUsecase({required this.deviceRepository});
  final DeviceRepository deviceRepository;

  @override
  Either<Failure, bool> call(DeviceParams params) {
    return deviceRepository.disConnect(params.device);
  }
}

