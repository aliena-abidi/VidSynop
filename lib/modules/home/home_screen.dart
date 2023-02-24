import 'package:flutter/material.dart';
import 'package:vidsynop/modules/modules.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/HomePage-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff241030),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff241030),
        toolbarHeight: 90,
        centerTitle: true,
        title: const Text(
          'Get your desired\nVideo summary!',
          style: TextStyle(
            height: 1.3,
          ),
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
                  width: 400,
                  height: 250,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'About',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to VidSynop! This is a platform where we provide you with the best Youtube Transcript Summarizer with a focus on accuracy and dependability. Generate a written summary of any YouTube Video of your choice.\n\nEnjoy working with VidSynop!',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      height: 1.3,
                    ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7336F5),
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
