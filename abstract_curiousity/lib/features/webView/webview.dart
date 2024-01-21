import 'package:abstract_curiousity/Features/webView/_components/navigationbar.dart';
import 'package:abstract_curiousity/Features/webView/fluttertts.dart';
import 'package:abstract_curiousity/Features/webView/services/webview_repository.dart';
import 'package:abstract_curiousity/Features/webView/summary.dart';
import 'package:abstract_curiousity/globalvariables.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:abstract_curiousity/openai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  final CustomArticle article;
  const WebViewApp({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  var loadingPercentage = 0;
  final flutterTts = FlutterTts();
  String words = '';
  WebViewRepository webViewRepository = WebViewRepository();
  final firestore = FirebaseFirestore.instance;
  final OpenAIService openAIService = OpenAIService();
  late final WebViewController controller;
  late String _extractedContent;
  late String _summary = "";

  Future<void> extractContent() async {
    try {
      final temp = await webViewRepository
          .extractContentFromFirestore(widget.article.url);

      if (temp.isEmpty) {
        setState(() {
          _extractedContent = "No content available";
          _summary = "";
        });
        return;
      } else {
        setState(() {
          _extractedContent = temp[0];
          _summary = temp[1];
        });
        return;
      }
    } catch (e) {
      setState(() {
        _extractedContent = "Failed to extract content from Firestore: $e";
      });
    }
  }

  Future<void> summariseText() async {
    try {
      if (_summary.isNotEmpty || _summary == "Failed to summarise text") {
        await webViewRepository.saveSummaryToFirebase(
            _summary, widget.article.url);
        return;
      } else if (_extractedContent.isNotEmpty) {
        final String summary =
            await openAIService.chatGPTAPI(_extractedContent);
        // print("The summary is $summary");
        setState(() {
          _summary = summary;
        });
        await webViewRepository.saveSummaryToFirebase(
            _summary, widget.article.url);
      } else {
        setState(() {
          _summary = "No matching article found in Firestore";
        });
      }
    } catch (e) {
      setState(() {
        _summary = "Failed to extract content from Firestore: $e";
      });
    }
  }

  Future<void> systemSpeak(String content) async {
    print("SYSTEM SPEAKING");
    await flutterTts.speak(content);
  }

  Future<void> setSharedInstance() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);
  }

  @override
  void initState() {
    super.initState();
    setSharedInstance();
    extractContent();
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onNavigationRequest: (navigation) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..loadRequest(
        Uri.parse(widget.article.url),
      );
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    print("IN WEBVIEW");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          NavigationControls(controller: controller, article: widget.article),
        ],
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.black87,
        backgroundColor: Colors.black,
        onPressed: () async {
          showModalBottomSheet(
            enableDrag: true,
            useSafeArea: true,
            isScrollControlled: true,
            backgroundColor: Colors.black87,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Power your Reading with Ai, \nSummarise or Listen to the Article",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            printError(widget.article.url);
                            await extractContent();
                            await summariseText();
                            if (_summary.isNotEmpty) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SummaryPage(summary: _summary),
                                ),
                              );
                            }
                          },
                          child: const Text("Summarise"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_summary != "") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyApp(content: _summary),
                                ),
                              );
                              // await systemSpeak(_summary);
                            }
                          },
                          onLongPress: () => flutterTts.stop(),
                          child: const Text("Listen with Ai"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.webhook_sharp,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
