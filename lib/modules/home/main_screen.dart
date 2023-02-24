import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vidsynop/data/models/youtube_model.dart';
import 'package:http/http.dart' as http;
import 'package:vidsynop/modules/home/summary_screen.dart';
import 'package:youtube_caption_scraper/youtube_caption_scraper.dart';

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

  String caption = '';

  YoutubeModel youtubeModel = YoutubeModel();

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
  }

  Future<bool> generateSubtitle(String videoId) async {
    final captionScraper = YouTubeCaptionScraper();

    try {
      final captionTracks = await captionScraper.getCaptionTracks(videoId);

      final subtitles = await captionScraper.getSubtitles(captionTracks[0]);
      // Use the subtitles however you want.

      if (subtitles.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Caption found'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }

      caption = List<String>.from(subtitles.map((e) => e.text)).join(' ');
      // for (final subtitle in subtitles) {
      //   // print('${subtitle.start} - ${subtitle.duration} - ${subtitle.text}');
      //   caption += subtitle.text;
      // }
      return true;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
      return false;
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
      // urlController.clear();
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
      backgroundColor: const Color(0xff241030),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff241030),
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
                    backgroundColor: const Color(0xff7336F5),
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
                                    color: const Color(0xffFFFFFF),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 44, vertical: 8),
                                ),
                                onPressed: () {
                                  generateSubtitle(urlController.text)
                                      .then((value) {
                                    if (value) {
                                      return Navigator.pushNamed(
                                          context, SummaryPage.routeName,
                                          arguments: caption);
                                    }
                                  });
                                },
                                child: const Text('Generate Text Summary'),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
