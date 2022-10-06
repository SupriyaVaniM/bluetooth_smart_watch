import 'package:dartz/dartz.dart';
import 'package:smart_wear/src/core/failure.dart';
import 'package:smart_wear/src/core/usecases.dart';
import 'package:smart_wear/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

class ReadValuesUsecase extends FutureUseCase<void, ReadValuesParams> {
  ReadValuesUsecase({required this.deviceRepository});
  final DeviceRepository deviceRepository;

  @override
  Future<Either<Failure,String>> call(ReadValuesParams params) {
    return deviceRepository.readValues(params.device,params.field);
  }
}

class ReadValuesParams {
  final DeviceEntity device;
  final String field;
  ReadValuesParams({
    required this.device,
    required this.field,
  });
}