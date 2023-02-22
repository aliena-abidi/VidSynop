import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vidsynop/modules/modules.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/MainScreen-page';
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff010101),
        title: const Text(
          'VidSynop',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Youtube URl',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffA1A8B0).withOpacity(0.2),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        'assets/youtube.svg',
                      ),
                    )),
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
                  child: const Text('Fetch Video'),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffA1A8B0),
              ),
              const SizedBox(height: 30),
              Text(
                'Title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.tempor incididunt ut labore et dolor iqua',
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
                    Navigator.pushNamed(context, SummaryPage.routeName);
                  },
                  child: const Text('Generate Text Summary'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
