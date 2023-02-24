import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SummaryPage extends StatefulWidget {
  static const String routeName = '/SummaryPage-page';
  const SummaryPage({Key? key, required this.caption}) : super(key: key);

  final String caption;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String summary = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    generateText();
  }

  Future<void> generateText() async {
    const String apiKey = 'wK9UNvLbzQBGs1hH9AFE8zBY4njJdyzfSvCUO7S2';
    const String apiUrl = 'https://api.cohere.ai/generate';

    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cohere-Version': '2022-12-06',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(
        {
          'model': 'xlarge',
          'truncate': 'END',
          'prompt': widget.caption,
          'max_tokens': 100,
          'temperature': 0.8,
          'k': 0,
          'p': 0.75
        },
      ),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      log(result.toString());
      setState(() => summary = result['generations'][0]['text']);

      // return
      // result['choices'][0]['text'];
    } else {
      log(result.toString());
      setState(() => isLoading = false);
      throw Exception('Failed to generate text');
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
          'Summary',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      summary,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: const Color(0xffFFFFFF),
                            height: 1.3,
                            fontSize: 20,
                          ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
