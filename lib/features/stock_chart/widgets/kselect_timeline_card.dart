import 'package:flutter/material.dart';
import 'package:stock_market/core/helpers/exports.dart';

class KSelectTImeLineCardWIdget extends StatelessWidget {
  final Function()? onTap;
  final String timeLineLabel;
  final Color backgroundColor;

  const KSelectTImeLineCardWIdget({
    super.key,
    this.onTap,
    required this.timeLineLabel,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
            child: Text(
          timeLineLabel,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        )),
      ),
    );
  }
}
