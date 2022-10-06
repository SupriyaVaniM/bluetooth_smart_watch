import 'package:dartz/dartz.dart';
import 'package:smart_wear/src/core/failure.dart';
import 'package:smart_wear/src/core/usecases.dart';
import 'package:smart_wear/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

class SearchDeviceUsecase extends UseCase<void, SearchParams> {
  SearchDeviceUsecase({required this.deviceRepository});
  final DeviceRepository deviceRepository;

  @override
  Either<Failure, Stream<List<DeviceEntity>>> call(SearchParams params) {
    return deviceRepository.searchDevices(params.searchNames);
  }
}

class SearchParams {
  final List<String> searchNames;
  SearchParams({
    required this.searchNames,
  });
}
