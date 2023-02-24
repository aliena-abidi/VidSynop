import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vidsynop/modules/modules.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/SplashPage-page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void navigate() {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false),
    );
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/youtube_blue.svg',
              color: const Color(0xffF53636),
            ),
            const SizedBox(height: 20),
            Text(
              'VidSynop',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
