import 'package:dartz/dartz.dart';
import 'package:smart_wear/src/core/failure.dart';
import 'package:smart_wear/src/features/devices/data/local/bluetooth_device_local_data.dart';
import 'package:smart_wear/src/features/devices/data/model/device_model.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';

abstract class DeviceRepository {
  //function for searching a device
  Either<Failure, Stream<List<DeviceModel>>> searchDevices(
      List<String> searchNames);

  Either<Failure, bool> connect(DeviceEntity device);

  Either<Failure, bool> disConnect(DeviceEntity device);

Future<Either<Failure, String>> readValues(DeviceEntity device, String field);

 
}

class DeviceRepositoryImpl extends DeviceRepository {
  final DevicelocalDataSource localDataSource;

  DeviceRepositoryImpl({required this.localDataSource});
  @override
  Either<Failure, Stream<List<DeviceModel>>> searchDevices(searchNames) {
    try {
      final result = localDataSource.searchDevices(searchNames);
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, bool> disConnect(DeviceEntity device) {
    try {
      final result = localDataSource.disconnect(device as DeviceModel);
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, bool> connect(DeviceEntity device) {
    try {
      final result = localDataSource.connect(device as DeviceModel);
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Future<Either<Failure, String>> readValues(
      DeviceEntity device, String field) async {
    try {
      final result =
          await localDataSource.readField(device as DeviceModel, field);
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

 
}
