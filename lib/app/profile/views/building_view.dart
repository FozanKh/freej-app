import 'package:flutter/material.dart';
import 'package:freej/app/building/controllers/building_view_controller.dart';
import 'package:freej/app/building/views/create_maintenance_issue_view.dart';
import 'package:freej/core/components/bottom_sheet.dart';
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(PhosphorIcons.wrench),
        onPressed: () => showCustomBottomSheet(
          context,
          child: CreateMaintenanceIssueView(callback: controller.createMaintenanceIssue),
          title: 'create_issue'.translate,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                Bounce(
                  onTap: () =>
                      (user.isSupervisor ?? false) ? controller.editWhatsappGroup() : controller.openWhatsappGroup(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        PhosphorIcons.whatsapp_logo,
                        color: kPrimaryColor,
                      ),
                      const Text(" - ", style: TextStyle(color: kPrimaryColor)),
                      if (user.isSupervisor ?? false)
                        Text(
                          "manage_building_whatsapp_group".translate,
                          style: const TextStyle(color: kPrimaryColor),
                        )
                      else
                        Text(
                          "join_building_whatsapp_group".translate,
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                if (user.isSupervisor ?? false)
                  RoundedButton(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('statistics'.translate, style: TextStyles.h2.withColor(kWhite)),
                        RotatedBox(
                          quarterTurns: controller.showStats ? 2 : 0,
                          child: const Icon(Icons.arrow_drop_down, color: kWhite),
                        ),
                      ],
                    ),
                    onTap: () => setState(() => controller.showStats = !controller.showStats),
                  ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    maxHeight: controller.showStats ? 1000 : 0,
                  ),
                  child: SeparatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    contentPadding: const EdgeInsets.symmetric(horizontal: Insets.l),
                    separator: const Divider(height: 2),
                    children: user.building.statistics!.keys
                        .map(
                          (key) => Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            child: Text("${key.translate}: ${user.building.statistics![key]}"),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<List<MaintenanceIssue>>(
            future: controller.getAllMaintenanceIssues(),
            builder: (context, issues) {
              if (!issues.hasData) return const Center(child: CircularProgressIndicator());
              return Expanded(
                child: RefreshIndicator(
                  key: controller.maintenanceIssuesRefreshKey,
                  onRefresh: () => controller.getAllMaintenanceIssues(refresh: true).then((value) => setState(() {})),
                  child: SizedBox.expand(
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
                                .then((value) => controller.maintenanceIssuesRefreshKey.currentState?.show()),
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
