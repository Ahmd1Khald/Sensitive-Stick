import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../Core/constance/assets_manager.dart';
import '../../../../Core/constance/my_colors.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  late Position _currentPosition;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
      });

      print(
          'Current Location: ${_currentPosition.latitude}, ${_currentPosition.longitude}');

      print(_currentPosition.latitude);
      print(_currentPosition.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

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
      getCurrentLocation();
    } else {
      print('Location permission denied');
    }
  }

  @override
  void initState() {
    getLocationPermission();
    playAlert();
    super.initState();
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  Color ballEffectColor = Colors.blue;

  Future<void> playAlert() async {
    try {
      // Load the audio file from assets
      await assetsAudioPlayer
          .open(
            Audio("assets/audios/security-alarm-80493.mp3"),
          )
          .then((value) {});
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pauseAlert() async {
    try {
      // Load the audio file from assets
      await assetsAudioPlayer.stop();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
