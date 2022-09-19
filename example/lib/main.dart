import 'package:flutter/material.dart';
import 'package:review_popup/review_popup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final reviewPopUp = ReviewPopUpUtils(
    appName: 'Appuly',
    appId: '1636138219',
    tapCount: 7,
  );

  @override
  void initState() {
    super.initState();
    reviewPopUp.loadTotalQuoteSaveSharedCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Pop up will show after few tap',
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                reviewPopUp.increaseTotalQuoteSaveSharedCount();
                reviewPopUp.showReviewPopUp(context);
                reviewPopUp.buildInAppReviewRequestPopUp(context);
              },
              child: const Text('Press Here'),
            )
          ],
        ),
      ),
    );
  }
}
