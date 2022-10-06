import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/search_device_usecase.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_list_state.dart';

class DeviceListCubit extends Cubit<DeviceListState> {
  DeviceListCubit({required this.searchDeviceUsecase})
      : super(const DeviceListState.initial());

  final SearchDeviceUsecase searchDeviceUsecase;
  void startSearching([List<String> searchPrefix = const <String>[]]) {
    emit(const DeviceListState.searching());
    final result = searchDeviceUsecase.call(SearchParams(searchNames: searchPrefix));
    result.fold((l) => emit(const DeviceListState.error("Bluetooth could not be enabled")), 
    (stream) => stream.forEach((element) {emit(DeviceListState.done(element));}));
  }
}
