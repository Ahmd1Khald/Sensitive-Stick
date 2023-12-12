import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../Core/constance/assets_manager.dart';
import '../../../../Core/constance/my_colors.dart';
import '../../../../Core/servises/firebase_servise.dart';
import '../../../../Core/widgets/loading_screen.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final databaseReferenceButton =
      FirebaseDatabase.instance.ref('StickData/ButtonState/value');

  final databaseReferenceLat =
      FirebaseDatabase.instance.ref('StickData/CurrentLocation/Lat');
  final databaseReferenceLong =
      FirebaseDatabase.instance.ref('StickData/CurrentLocation/Long');

  Position? _currentPosition;

  Future<bool> requestLocationPermission() async {
    try {
      final LocationPermission permission =
          await Geolocator.requestPermission();
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      return false;
    }
  }

  Future<void> getLocationPermission() async {
    final bool locationPermissionGranted = await requestLocationPermission();
    if (locationPermissionGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition = position;

      print(
          'Current Location: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');

      print(_currentPosition?.latitude);
      print(_currentPosition?.longitude);
    } else {
      print('Location permission denied');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  Color ballEffectColor = Colors.blue;

  Future<void> playFrontAlert() async {
    try {
      // Load the audio file from assets
      await assetsAudioPlayer.open(
        Audio("assets/audios/front.mp3"),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> playRightAlert() async {
    try {
      await assetsAudioPlayer.open(Audio("assets/audios/right.mp3"));

      assetsAudioPlayer.play();

      // Listen for playback completion and play again

      // Load the audio file from assets
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> playLeftAlert() async {
    try {
      // Load the audio file from assets

      await assetsAudioPlayer.open(
        Audio("assets/audios/left.mp3"),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pauseAlert() async {
    try {
      print("Stop");
      // Load the audio file from assets
      await assetsAudioPlayer.stop();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataSnapshot>(
      stream: FirebaseDataService().dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DataSnapshot? data = snapshot.data;
          if (data!.value != null) {
            Object? state =
                snapshot.data!.child('CurrentState').child('state').value;
            Object? front =
                snapshot.data!.child('CurrentState').child('distance').value;
            Object? right =
                snapshot.data!.child('CurrentState').child('distance2').value;
            Object? left =
                snapshot.data!.child('CurrentState').child('distance3').value;
            Object? getLocation =
                snapshot.data!.child('ButtonState').child('value').value;
            print(state);

            if (getLocation == true) {
              databaseReferenceButton.set(false).then((value) {
                getLocationPermission().then((value) {
                  databaseReferenceLat.set(_currentPosition!.latitude);
                  databaseReferenceLong.set(_currentPosition!.longitude);
                });
              });
            }

            if (front is int && front < 50) {
              print("front");
              //pauseAlert();
              playFrontAlert();
              ballEffectColor = Colors.red;
            } else if (right is int && right < 50) {
              print("right");
              //pauseAlert();
              playRightAlert();
              ballEffectColor = Colors.red;
            } else if (left is int && left < 50) {
              print("left");
              //pauseAlert();
              playLeftAlert();
              ballEffectColor = Colors.red;
            } else {
              ballEffectColor = Colors.blue;
              pauseAlert();
            }
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
                      'Patient',
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
                    image: AssetImage(AssetsManager.patientBackgroundImage),
                    opacity: 0.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitPulse(
                      size: 300,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ballEffectColor,
                          ),
                        );
                      },
                    ),
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
