import 'package:get_it/get_it.dart';
import 'package:smart_wear/src/features/devices/data/local/bluetooth_device_local_data.dart';
import 'package:smart_wear/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/connect_device_usecase.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/disconnect_device_usecase.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/read_values_usecase.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/search_device_usecase.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_list_cubit.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_select_cubit.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/read_values_cubit.dart';

final s1 = GetIt.instance;

Future<void> init() async {
  

  s1.registerFactory<DevicelocalDataSource>(
      () => BluetoothDevicelocalDataSourceImpl());

  s1.registerFactory<DeviceRepository>(
      () => DeviceRepositoryImpl(localDataSource: s1()));

  s1.registerFactory<SearchDeviceUsecase>(
      () => SearchDeviceUsecase(deviceRepository: s1()));
   s1.registerFactory<ReadValuesUsecase>(
      () => ReadValuesUsecase(deviceRepository: s1()));

 s1.registerFactory<ConnectDeviceUsecase>(
      () => ConnectDeviceUsecase(deviceRepository: s1()));

  s1.registerFactory<DisconnectDeviceUsecase>(
      () => DisconnectDeviceUsecase(deviceRepository: s1()));

       s1.registerSingleton<DeviceListCubit>(
      DeviceListCubit(searchDeviceUsecase: s1()));

  s1.registerSingleton<DeviceSelectCubit>(DeviceSelectCubit(
      connectDeviceUsecase: s1(), disconnectDeviceUsecase: s1()));

  s1.registerSingleton<ReadValuesCubit>(ReadValuesCubit( readValuesUsecase: s1()));
      
     

}
