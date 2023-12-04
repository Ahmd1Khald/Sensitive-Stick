import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Core/constance/assets_manager.dart';
import '../../../../Core/constance/my_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final databaseReference =
  //     FirebaseDatabase.instance.ref('Embedded/Action needed/value');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backGroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: MyColors.buttonsColor!,
              highlightColor: Colors.white,
              child: Text(
                "Sensitive Stick",
                style: TextStyle(
                  color: MyColors.buttonsColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              AssetsManager.appImage,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.13,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    MyColors.buttonsColor!.withOpacity(0.35),
                  )),
                  child: const Text(
                    'Patient',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.13,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    MyColors.buttonsColor!.withOpacity(0.35),
                  )),
                  child: const Text(
                    'Gardian',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
