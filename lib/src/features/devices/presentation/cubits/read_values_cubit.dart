import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_wear/src/features/devices/domain/entity/device_entity.dart';
import 'package:smart_wear/src/features/devices/domain/usecases/read_values_usecase.dart';

class ReadValuesCubit extends Cubit<ReadValueItem> {
  ReadValuesCubit({
    required this.readValuesUsecase,
  }) : super(const ReadValueItem(field: "", value: ""));

  final ReadValuesUsecase readValuesUsecase;

  void readValue(DeviceEntity device, String field) async {
    final result = await readValuesUsecase
        .call(ReadValuesParams(device: device, field: field));
    result.fold((l) => emit(const ReadValueItem(field: "", value: "")), (r) => emit(const ReadValueItem(field: "", value: "")));
  }
}

class ReadValueItem extends Equatable{
  final String field;
  final String value;
  const ReadValueItem({
    required this.field,
    required this.value,
  });

  @override
 
  List<Object?> get props =>[field,value];
}
