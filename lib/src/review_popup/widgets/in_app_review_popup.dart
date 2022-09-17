import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lottie/lottie.dart';
import 'package:review_popup/src/review_popup/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InAppReviewRequestPopUp extends StatefulWidget {
  const InAppReviewRequestPopUp({
    required this.lottie,
    this.text,
    this.onContinueClicked,
    this.onNotNowClicked,
    Key? key,
  }) : super(key: key);

  final String lottie;
  final String? text;
  final VoidCallback? onContinueClicked;
  final VoidCallback? onNotNowClicked;

  @override
  State<InAppReviewRequestPopUp> createState() =>
      _InAppReviewRequestPopUpState();
}

class _InAppReviewRequestPopUpState extends State<InAppReviewRequestPopUp> {
  // late SharedPreferences _preferences;
  // @override
  // void initState() {
  //   _initPreference();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            widget.lottie,
            height: 210,
            width: 210,
            fit: BoxFit.fill,
            package: 'review_popup',
          ),
          const SizedBox(height: 20),
          Text(
            widget.text ??
                'Would you love to Rate Quote Writer'
                    '\non ${_getPlatfromStoreName()}?',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: widget.onContinueClicked ?? onContinueClicked,
            child: const Text(
              'CONTINUE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          // StadiumButton(
          //   leftPadding: 20,
          //   rightPadding: 20,
          //   color: Colors.black,
          //   onTap: widget.onContinueClicked ?? onContinueClicked,
          //   child: const Text(
          //     'CONTINUE',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.w700,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: widget.onNotNowClicked ?? onNotNowClicked,
            child: const Text(
              'NOT NOW',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          // StadiumButton(
          //   leftPadding: 20,
          //   rightPadding: 20,
          //   color: Colors.white,
          //   onTap: widget.onNotNowClicked ?? onNotNowClicked,
          //   child: const Text(
          //     'NOT NOW',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w700,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void onContinueClicked() async {
    final _preferences = await SharedPreferences.getInstance();

    Navigator.pop(context);
    _openStoreListing();
    _preferences.setBool(Constant.isAppStoreOpened, false);
  }

  void onNotNowClicked() async {
    final _preferences = await SharedPreferences.getInstance();

    Navigator.pop(context);
    _preferences.setBool(Constant.isAppStoreOpened, true);
  }

  String _getPlatfromStoreName() {
    if (Platform.isIOS) {
      return 'AppStore';
    } else {
      return 'PlayStore';
    }
  }

  // Future<void> _initPreference() async {
  //   _preferences = await SharedPreferences.getInstance();
  // }

  Future<void> _openStoreListing() async {
    await InAppReview.instance.openStoreListing(appStoreId: '1636138219');
  }
}
