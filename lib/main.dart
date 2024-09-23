import 'package:codelessly_sdk/codelessly_sdk.dart';
import 'package:example/themes/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Codelessly.instance.initialize(
    config: CodelesslyConfig(
      authToken: "cSlMIT93cj1lXkBuYk5QNmImSTUsTHw2MDQ4VkdlOCZFLHc7",
      isPreview: kDebugMode,
      preload: true,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: Center(
          child: CodelesslyWidget(
            layoutID: "0R0yRfzR23SQfDGrbg3h",
            loadingBuilder: (context) {
              return const CupertinoActivityIndicator();
            },
          ),
        ),
      ),
    );
  }
}
