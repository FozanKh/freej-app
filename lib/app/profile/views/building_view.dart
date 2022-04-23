import 'package:flutter/material.dart';
import 'package:freej/app/building/controllers/building_view_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../../building/components/maintenance_issue_card.dart';
import '../../building/models/maintenance_issue.dart';

class BuildingView extends StatefulWidget {
  const BuildingView({Key? key}) : super(key: key);

  @override
  State<BuildingView> createState() => _BuildingViewState();
}

class _BuildingViewState extends State<BuildingView> {
  late User user;
  late BuildingViewController controller;

  @override
  void initState() {
    controller = BuildingViewController(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    user = context.watch<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              boxShadow: Styles.boxShadow,
              color: kWhite,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    shape: BoxShape.circle,
                  ),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kPrimaryColor, width: 2),
                  ),
                  child: Image.asset(
                    Assets.kKfupmCampusAsset,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 15),
                Text("${"building".translate} ${user.building.name}",
                    style: TextStyles.h1.withColor(kPrimaryColor).withWeight(FontWeight.bold)),
                const SizedBox(height: 5),
                const Spacer(),
                Bounce(
                  onTap: () => controller.openWhatsappGroup(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        PhosphorIcons.whatsapp_logo,
                        color: kPrimaryColor,
                      ),
                      const Text(" - ", style: TextStyle(color: kPrimaryColor)),
                      Text("join_building_whatsapp_group".translate, style: const TextStyle(color: kPrimaryColor)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          FutureBuilder<List<MaintenanceIssue>>(
            future: controller.getAllMaintenanceIssues(),
            builder: (context, issues) {
              if (!issues.hasData) return const Center(child: CircularProgressIndicator());
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.getAllMaintenanceIssues(refresh: true).then((value) => setState(() {})),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: List.generate(
                        controller.maintenanceIssues.length,
                        (index) => MaintenanceIssueCard(
                          maintenanceIssue: controller.maintenanceIssues[index],
                          onTap: () => controller
                              .fixMaintenanceIssue(controller.maintenanceIssues[index])
                              .then((value) => setState(() {})),
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
