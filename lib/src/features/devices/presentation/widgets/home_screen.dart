import 'package:flutter/material.dart';
import 'package:smart_wear/src/core/injection_conatiner.dart';
import 'package:smart_wear/src/features/devices/presentation/cubits/device_list_cubit.dart';
import 'package:smart_wear/src/features/devices/presentation/widgets/bluetooth_listing_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(5),
        decoration:  const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(242, 187, 165, 1),
          Color.fromRGBO(245, 178, 152, 1),
          Color.fromRGBO(117, 92, 82, 1),
        ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
           
            children: [
            
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   buildText(),
                   buildTagLine(),
                   buildButton(),
                    
                    
         
                  ],
                ),
              ),
              buildImage()
               
             
             
            ],
          ),
        ),
      ),
    );
  }
   Widget buildButton() =>  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                      onPressed: () {
                        s1<DeviceListCubit>().startSearching();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const BluetoothListingScreen()));
                      },
                      child: Text(
                        "     Start  Pairing     ",
                        style: TextStyle(
                            color: Colors.red[200],
                            fontWeight: FontWeight.bold),
                      ));

  Widget buildText() => const  Text("Syntiant       \n\n",style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),);

  Widget buildTagLine() =>    const Text(
                        "\n\nThe \n Next \n Generation \n Smart \n Watch\n\n\n",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      );  

  Widget buildImage() =>   SizedBox(
    height: 500,
    child: Image.asset("assets/watch.png"));                                   
                      
}
