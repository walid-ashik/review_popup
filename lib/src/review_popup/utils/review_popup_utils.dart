import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:review_popup/src/review_popup/constant/constant.dart';
import 'package:review_popup/src/review_popup/widgets/in_app_review_popup.dart';
import 'package:review_popup/src/review_popup/widgets/review_popup_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPopUpUtils {
  ReviewPopUpUtils({
    required this.appId,
    required this.appName,
  });

  late String appName;
  late String appId;
  late bool _isAppStoreOpened;
  int _totalQuoteSaveSharedCount = 0;

  Future<void> increaseTotalQuoteSaveSharedCount() async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.setInt(
      Constant.totalQuoteSaveSharedCount,
      _totalQuoteSaveSharedCount++,
    );
  }

  Future<void> loadTotalQuoteSaveSharedCount() async {
    final _preferences = await SharedPreferences.getInstance();

    _totalQuoteSaveSharedCount =
        _preferences.getInt(Constant.totalQuoteSaveSharedCount) ?? 0;
  }

  Future<void> showReviewPopUp(BuildContext context) async {
    if (_totalQuoteSaveSharedCount == 4) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ReviewPopUp(
            appName: appName,
            appId: appId,
          );
        },
      );
    }
  }

  Future<void> buildInAppReviewRequestPopUp(BuildContext context) async {
    final _preferences = await SharedPreferences.getInstance();
    _isAppStoreOpened =
        _preferences.getBool(Constant.isAppStoreOpened) ?? false;
    if (_isAppStoreOpened) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InAppReviewRequestPopUp(
            lottie: 'assets/lottie/hello_expert.json',
            text: 'Would you love to Rate $appName'
                '\non ${_getPlatfromStoreName()}?',
            onContinueClicked: () {
              onContinueClicked(context);
              Navigator.pop(context);
            },
            onNotNowClicked: () {
              onNotNowClicked(context);
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  void onContinueClicked(BuildContext context) async {
    _openStoreListing();
    final _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(Constant.isAppStoreOpened, false);
  }

  void onNotNowClicked(BuildContext context) async {
    final _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(Constant.isAppStoreOpened, true);
  }

  Future<void> _openStoreListing() async {
    await InAppReview.instance.openStoreListing(appStoreId: appId);
  }

  String _getPlatfromStoreName() {
    if (Platform.isIOS) {
      return 'AppStore';
    } else {
      return 'PlayStore';
    }
  }
}
