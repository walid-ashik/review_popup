import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:review_popup/src/review_popup/constant/constant.dart';
import 'package:review_popup/src/review_popup/icons/review_popup_icons.dart';
import 'package:review_popup/src/review_popup/widgets/in_app_review_popup.dart';
import 'package:review_popup/src/review_popup/widgets/review_popup_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewPopUp extends StatefulWidget {
  const ReviewPopUp({Key? key}) : super(key: key);

  @override
  State<ReviewPopUp> createState() => _ReviewPopUpState();
}

class _ReviewPopUpState extends State<ReviewPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'How much are you\nenjoying QuoteWriter?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      content: const Text(
        'Your feedback matters! Tap a face to let us know',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(top: 23, bottom: 17),
          color: const Color(0xFFF3F3F3),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ReviewPopupEmojiAndText(
                text: 'Not at all',
                icon: ReviewPopupIcons.sad_emoji,
                color: const Color(0xFFC3C3C3),
                onTap: () {
                  Navigator.pop(context);
                  _onFeedUsClicked();
                },
              ),
              ReviewPopupEmojiAndText(
                text: 'It’s ok',
                icon: ReviewPopupIcons.ok_emoji,
                color: const Color(0xFF929090),
                onTap: () {
                  Navigator.pop(context);
                  _onReviewPopupEmojiAndTextClicked();
                },
              ),
              ReviewPopupEmojiAndText(
                text: 'A lot!',
                icon: ReviewPopupIcons.a_lot_emoji,
                color: const Color(0xFF7B7B7B),
                onTap: () {
                  Navigator.pop(context);
                  _onReviewPopupEmojiAndTextClicked();
                },
              ),
              ReviewPopupEmojiAndText(
                text: 'Love it!',
                icon: ReviewPopupIcons.love_emoji,
                color: const Color(0xFF4B4B4B),
                onTap: () {
                  Navigator.pop(context);
                  _onReviewPopupEmojiAndTextClicked();
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  void _onReviewPopupEmojiAndTextClicked() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InAppReviewRequestPopUp(
          lottie: 'assets/lottie/hello_expert.json',
          text: 'Would you love to Rate Quote Writer'
              '\non ${_getPlatfromStoreName()}?',
          onContinueClicked: () {
            onContinueClicked();
            Navigator.pop(context);
          },
          onNotNowClicked: () {
            onNotNowClicked();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void onContinueClicked() async {
    _openStoreListing();
    final _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(Constant.isAppStoreOpened, false);
  }

  void onNotNowClicked() async {
    final _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(Constant.isAppStoreOpened, true);
  }

  Future<void> _openStoreListing() async {
    await InAppReview.instance.openStoreListing(appStoreId: '1636138219');
  }

  String _getPlatfromStoreName() {
    if (Platform.isIOS) {
      return 'AppStore';
    } else {
      return 'PlayStore';
    }
  }

  void _onFeedUsClicked() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InAppReviewRequestPopUp(
          lottie: 'assets/lottie/sad_emoji.json',
          text: 'Can you please share your\nfeedback?',
          onContinueClicked: () {
            Navigator.pop(context);
            _onMailUsClicked();
          },
          onNotNowClicked: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _onMailUsClicked() async {
    final canSend = await FlutterMailer.canSendMail();

    final _mailOptions = MailOptions(
      subject: 'QuoteWriter : Feedback',
      recipients: ['invalidco.bin@gmail.com'],
      ccRecipients: ['invalidco.bin@gmail.com'],
    );

    if (canSend) {
      await FlutterMailer.send(_mailOptions);
    } else {
      const recipient = 'invalidco.bin@gmail.com';
      const url = 'mailto:$recipient?body= &subject=QuoteWriter : Feedback';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    }
  }
}
