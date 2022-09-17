import 'package:flutter/material.dart';
import 'package:review_popup/src/review_popup/constant/constant.dart';
import 'package:review_popup/src/review_popup/widgets/in_app_review_popup.dart';
import 'package:review_popup/src/review_popup/widgets/review_popup_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPopUpUtils {
  int _totalQuoteSaveSharedCount = 0;
  late bool _isAppStoreOpened;

  Future<void> increaseTotalQuoteSaveSharedCount() async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.setInt(
      Constant.totalQuoteSaveSharedCount,
      _totalQuoteSaveSharedCount++,
    );
    print(_totalQuoteSaveSharedCount);
  }

  Future<void> loadTotalQuoteSaveSharedCount() async {
    final _preferences = await SharedPreferences.getInstance();

    _totalQuoteSaveSharedCount =
        _preferences.getInt(Constant.totalQuoteSaveSharedCount) ?? 0;
  }

  Future<void> showReviewPopUp(BuildContext context) async {
    print(_totalQuoteSaveSharedCount);
    if (_totalQuoteSaveSharedCount == 4) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const ReviewPopUp();
        },
      );
    }
  }

  Future<void> buildInAppReviewRequestPopUp(BuildContext context) async {
    final _preferences = await SharedPreferences.getInstance();
    _isAppStoreOpened =
        _preferences.getBool(Constant.isAppStoreOpened) ?? false;
    print(_isAppStoreOpened);
    if (_isAppStoreOpened) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InAppReviewRequestPopUp(
            lottie: 'assets/lottie/hello_expert.json',
          );
        },
      );
    }
  }
}
