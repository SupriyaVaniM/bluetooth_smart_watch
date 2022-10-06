import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_wear/src/core/injection_conatiner.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_list_cubit.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_list_state.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_select_cubit.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/read_values_cubit.dart';

class BluetoothListingScreen extends StatefulWidget {
  const BluetoothListingScreen({Key? key}) : super(key: key);

  @override
  BluetoothListingScreenState createState() => BluetoothListingScreenState();
}

class BluetoothListingScreenState extends State<BluetoothListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(backgroundColor: Colors.transparent, leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);} ,),),
      body: Container(
        decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(242, 187, 165, 1),
            Color.fromRGBO(245, 178, 152, 1),
            Color.fromRGBO(117, 92, 82, 1),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              BlocBuilder<DeviceListCubit, DeviceListState>(
                  bloc: s1<DeviceListCubit>(),
                  builder: (context, state) {
                    switch (state.status) {
                      case DeviceListStatus.initial:
                        return const Text("Please click on the search button");
    
                      case DeviceListStatus.searching:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
    
                      case DeviceListStatus.done:
                        final items = state.devices;
                        return Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return ListTile(
                                title: Text(item.strength.toString()),
                                  subtitle: Text(item.id),
                                  trailing: ElevatedButton( style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                                    
                                    onPressed: () {
                                    if(s1<DeviceSelectCubit>().state.connected)   { 
                                  
                                   s1<DeviceSelectCubit>().disConnect(item);
                                    SnackBar snackBar = SnackBar(content: Text( "${item.name} device has been disconnected  "),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                   }
                                   else{
                                     s1<DeviceSelectCubit>().connect(item);
                                      SnackBar snackBar = SnackBar( content : Text ("${item.name} device has been connected automatically "),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                     }
                                   s1<ReadValuesCubit>().readValue(
                                          s1<DeviceSelectCubit>().state.devices,"Battery");
                                         s1<ReadValuesCubit>().readValue(
                                          s1<DeviceSelectCubit>().state.devices,"Manufacturer");
                                    }, child:  Text(s1<DeviceSelectCubit>().state.connected ? "Disconnect" : "Connect",style: TextStyle(
                            color: Colors.red[200],
                            fontWeight: FontWeight.bold),)),
                                  leading: Text(item.name),
                                  
                                );
                              }),
                        );
                      case DeviceListStatus.error:
                        return Text(
                          state.message ?? " ",
                          style: const TextStyle(color: Colors.red),
                        );
                    }
                  }),
                   
                BlocBuilder<ReadValuesCubit, ReadValueItem>(
                  bloc: s1<ReadValuesCubit>(),
                  builder: (context, state) {
                    return Card(
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20),
                               ),
                      child: Container(
                        height: 100,
                        width:150,
                        decoration :   const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color.fromRGBO(242, 187, 165, 1),
                                Color.fromRGBO(245, 178, 152, 1),
                                Color.fromRGBO(117, 92, 82, 1),
                              ], begin: Alignment.bottomLeft, end: Alignment.topRight), borderRadius: BorderRadius.all(Radius.circular(20)) ),
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Center(child: Text('${state.field}: no characteristics yet ${state.value}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { 
        s1<DeviceListCubit>().startSearching();
       },
       backgroundColor: Colors.transparent,child: const Icon(Icons.search),),
    );
  }
  
}
