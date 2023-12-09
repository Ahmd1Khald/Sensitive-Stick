import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../../../../Core/constance/assets_manager.dart';
import '../../../../Core/constance/my_colors.dart';
import '../../../../Core/servises/firebase_servise.dart';
import '../../../../Core/widgets/loading_screen.dart';

class GardianScreen extends StatefulWidget {
  const GardianScreen({Key? key}) : super(key: key);

  @override
  State<GardianScreen> createState() => _GardianScreenState();
}

class _GardianScreenState extends State<GardianScreen> {
  // final databaseReference =
  //     FirebaseDatabase.instance.ref('Embedded/Action needed/value');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataSnapshot>(
      stream: FirebaseDataService().dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DataSnapshot? data = snapshot.data;
          if (data!.value != null) {
            Object? lat =
                snapshot.data!.child('CurrentLocation').child('Lat').value;
            Object? long =
                snapshot.data!.child('CurrentLocation').child('Long').value;
            print(lat);
            print(long);

            return Scaffold(
              backgroundColor: MyColors.backGroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Gardian',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                backgroundColor: MyColors.backGroundColor,
                elevation: 0,
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.backgroundImage),
                    opacity: 0.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (lat != 0 && long != 0) ...[
                      Expanded(
                        child: OpenStreetMapSearchAndPick(
                            buttonHeight: 1,
                            center: LatLong(lat as double, long as double),
                            buttonColor: Colors.blue,
                            locationPinText: 'Patient location',
                            buttonText: 'Set Current Location',
                            onPicked: (pickedData) {}),
                      )
                    ] else ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Waiting for the location of patient.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
