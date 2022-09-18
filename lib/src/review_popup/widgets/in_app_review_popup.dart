import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InAppReviewRequestPopUp extends StatefulWidget {
  const InAppReviewRequestPopUp({
    required this.lottie,
    required this.text,
    this.onContinueClicked,
    this.onNotNowClicked,
    Key? key,
  }) : super(key: key);

  final String lottie;
  final String text;
  final VoidCallback? onContinueClicked;
  final VoidCallback? onNotNowClicked;

  @override
  State<InAppReviewRequestPopUp> createState() =>
      _InAppReviewRequestPopUpState();
}

class _InAppReviewRequestPopUpState extends State<InAppReviewRequestPopUp> {
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
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                elevation: 0,
                fixedSize: const Size(
                  double.maxFinite,
                  45,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: widget.onContinueClicked,
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
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
                fixedSize: const Size(
                  double.maxFinite,
                  45,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: widget.onNotNowClicked,
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
