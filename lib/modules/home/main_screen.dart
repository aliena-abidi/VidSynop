import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vidsynop/data/models/youtube_model.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:googleapis/youtube/v3.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/MainScreen-page';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController urlController;
  bool isVideoDetailFetched = false;
  bool isLoading = false;

  YoutubeModel youtubeModel = YoutubeModel();

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
  }

  void generateSubtitle(String videoId, String apiKey) async {
    log(videoId);
    final captionUrl =
        'https://www.googleapis.com/youtube/v3/captions/$videoId?tfmt=srt&key=$apiKey';
    final captionResponse = await http.get(Uri.parse(captionUrl));

    if (captionResponse.statusCode == 200) {
      log(captionResponse.body.toString());
    } else {
      throw Exception(
          'Failed to retrieve captions: ${captionResponse.statusCode}');
    }
  }

  void fetchVideoinfo(String videoId, String apiKey) async {
    log(videoId);
    var url =
        'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey';

    setState(() => isLoading = true);
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        isLoading = false;
        isVideoDetailFetched = true;
        youtubeModel = YoutubeModel(
            id: videoId,
            title: jsonResponse['items'][0]['snippet']['title'],
            description: jsonResponse['items'][0]['snippet']['description'],
            thumbnail: jsonResponse['items'][0]['snippet']['thumbnails']
                    ['maxres']['url']
                .toString());
      });
      urlController.clear();
      // ignore: use_build_context_synchronously
      FocusScope.of(context).unfocus();
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load video summary');
    }
  }

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
                controller: urlController,
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
                    fetchVideoinfo(urlController.text.split('v=')[1],
                        'AIzaSyB84GDJfIrxLHyt5FnxyORhcReBQhAy6co');
                    // Navigator.pushNamed(context, MainScreen.routeName);
                  },
                  child: const Text('Fetch Video'),
                ),
              ),
              const SizedBox(height: 50),
              isLoading
                  ? SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : !isVideoDetailFetched
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              // color: const Color(0xffA1A8B0),
                              child: Image.network(youtubeModel.thumbnail!),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              youtubeModel.title!,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              youtubeModel.description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 44, vertical: 8),
                                ),
                                onPressed: () {
                                  generateSubtitle(youtubeModel.id!,
                                      'nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCvBdOriyS9oJav\n06kaTN88VUxRvAbEDJ6CY6oT0b8648X9cerLWLC0Mdqs7PcEWWjbdqpKwvcH+XsX\nP5/7SCqggFEscWzBTf9KsA7k1/5/RZuN8sB0pNwAAQvo4O9msiV/eJ3N+CrPTBmf\njmHBQEJVugaKfqMSzfdJhtXSetfYAlkIxUhGTp1wBzFn7XBkBZJKTBKHqacTatBJ\nMCWaVxHItx5m2+uY4TCxmNJPkVT/uBX5bAFy2vvSj/q2q+7sL1mKGZRuGCRMwCyv\nTMrRsNoObUeEM/po7WxQW7SOT0anWBT07qiA31pRsv5TIBPbhJ0ov7hdrPSTULWn\nGN56INV7AgMBAAECggEAIKigr8DeEThXBeYkBtFTUonEHPhN9uU36rK4OMyJt25r\nMnjATEN3bZhj6qKpETmx1EnXSu4IdId8DYGE07nKonpvKzDbD1MDkSc7ED6xsYQG\nm70xZlKg7qtDUqguY+ZYEuop4BYvvtC/c0N5QDtCZYa507v/p/Gg9Cph2c2sWxT9\nrdW8FKO9S7eMkH5g9Xl7mwU+aInColZkabgKL3B7vVtWC3e5179UKXAie8NIs7n6\n8CiUatGnAW1IIoJ9IZvksnoouG5DAUVkzVigjE+EZTHXLmLOMm5kAJuDyxBk7j+5\nk6ry817ZfdasxUYGi0B/WOIUO0CHgfhKDf2jPxOj+QKBgQDp7tw5or55Q7ayqni8\ndsmiGZkJm8p69eq61XWfGOq1FDP09HAyi//ZDSbMH94WMr5ClwMXAoLjMczB9gqE\nzwKfiCU6RRs0yos6+TOEmv7Y7HMCzPhpmydeCp6X0N+cOA48RxTosCEdtALYG09X\nlECn3G7aUcRBCBXuD7umQqgzDwKBgQC/iF6fmRQ224NWZk84xqTQrJwlKmsnQaxn\n7djhqZTS0TYIgE4C38Ojnb2IwLwXMZHVWWsaDhRGMwV3Lnpxda64KF8BiOhDxvH5\nq+/T1RmyJ8V3JAFWHwwndLQU1fd8Et9sIP8lJkMV+oa1XV/9VcA1fob6nUH34eZl\nEhsQTUQG1QKBgQCfWxuiF37xVHNMWlxM5g6M4isiJIJWKNdx1p99dZfNKqoKH8me\nZUgwL4lSXBMJxB9fdUehkRBgfDgjmNuphOsgibnya8kQuTkHP2Mc3gjk9I2URtSh\n/BNhOJK4kI0C+hyYa0OPDwxAE7QsSs5NtqwkrUDGcBTkyAFIXmdR5u51eQKBgBCm\nSRt0kiZGpL8g+6gC1JbzOkucyV3LPrJ2IZFUTYSZ/Sl2BdIII5iYgL5firo1a+jw\n8fd829RSYRpAJxKv2TVXBRM8FHy30ZcTlDCE6Mvs2ySFM7yJzGOtqG3bP71AYr2i\njKttDQ3fDlC7wjlid+fujMtCWlazA3UrwsCDBvPVAoGAMFVel0xdANJy6cJJjvui\njTC6XgWxhVu6IELeatevD7s9aLjfaIX47zoA0jQU2yB9UEQx04OqbdtudnfkLqD0\n8Qeb+QTsI6DUJfdzqVauuvwRW4OxtOswJQHxZd9AfHiuUzvoq5s5ODruPX+JvhL8\n4cHofINzf888ZHCS+AHNwns=');

                                  // Navigator.pushNamed(
                                  //     context, SummaryPage.routeName);
                                },
                                child: const Text('Generate Text Summary'),
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
