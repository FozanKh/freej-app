import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

class FullScreenBanner extends StatelessWidget {
  final bool loading;
  final String message;
  const FullScreenBanner(this.message, {Key? key, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) const CircularProgressIndicator(),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.t2.withColor(kGrey.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }
}
