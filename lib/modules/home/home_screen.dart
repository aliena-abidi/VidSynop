import 'package:flutter/material.dart';
import 'package:vidsynop/modules/modules.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/HomePage-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff010101),
        toolbarHeight: 70,
        title: const Text(
          'Find your desire\nyoutube summary',
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Center(
                child: Image.asset(
                  "assets/logo.gif",
                  width: 300,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'About',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam. Ut enim ad minim veniam.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: const Color(0xff3683F5),
                      height: 1.3,
                    ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3683F5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MainScreen.routeName);
                  },
                  child: const Text('Initiate'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
