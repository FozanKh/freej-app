import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

import '../models/maintenance_issue.dart';

class MaintenanceIssueCard extends StatelessWidget {
  final MaintenanceIssue maintenanceIssue;
  final VoidCallback onTap;
  const MaintenanceIssueCard({Key? key, required this.maintenanceIssue, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.xxlCardHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maintenanceIssue.createdAt.dMMM,
                style: TextStyles.body2.withColor(kPrimaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                maintenanceIssue.createdAt.dayTime12,
                style: TextStyles.body3.withColor(kPrimaryColor),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                height: 7.5,
                width: 7.5,
                decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              ),
              Container(
                height: Sizes.xxlCardHeight - 7.5,
                width: 1.5,
                color: kPrimaryColor,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maintenanceIssue.type.toString().translate,
                  style: TextStyles.h2.withColor(kPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10).relative(),
                  child: Text(
                    maintenanceIssue.description,
                    style: TextStyles.body2.withColor(kHintFontsColor),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounce(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10).relative(),
                        child: Text(
                          'is_the_problem_solved'.translate,
                          style: TextStyles.body2
                              .copyWith(
                                color: kHintFontsColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              )
                              .withColor(kHintFontsColor)
                              .withWeight(FontWeight.bold),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (maintenanceIssue.reportedFixed > 0)
                      Container(
                        height: 27.5,
                        width: 27.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kLight3,
                          boxShadow: Styles.boxShadow,
                          border: Border.all(color: kGreen, width: 2),
                        ),
                        child: Text(
                          maintenanceIssue.reportedFixed.toString(),
                          style: TextStyles.body2.withColor(kFontsColor).withWeight(FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
