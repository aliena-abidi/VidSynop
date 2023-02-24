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
    const String apiKey = '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';
    const String apiUrl =
        'https://api.openai.com/v1/engines/davinci-codex/completions';

    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(
          {'prompt': widget.caption, 'max_tokens': 4096, 'n': 1, 'stop': '\n'}),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      setState(() => summary = result['choices'][0]['text']);

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff010101),
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
                      widget.caption,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: const Color(0xff3683F5),
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
