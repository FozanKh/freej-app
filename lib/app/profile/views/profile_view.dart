import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User user;

  @override
  void didChangeDependencies() {
    user = context.watch<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
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
                  // height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    shape: BoxShape.circle,
                  ),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kPrimaryColor, width: 2),
                  ),
                  child: const CachedImage(
                    url:
                        'https://firebasestorage.googleapis.com/v0/b/fozan-kh.appspot.com/o/IMG_2873-min.png?alt=media&token=d06c92b2-9028-44d1-821e-826104145b7b',
                    fit: BoxFit.fill,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 15),
                Text(user.name, style: TextStyles.h1.withColor(kPrimaryColor).withWeight(FontWeight.w500)),
                const SizedBox(height: 5),
                Text("${'room'.translate} ${user.room}",
                    style: TextStyles.body3.withColor(kHintFontsColor).withWeight(FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.l),
            child: SeparatedColumn(
              separator: const SizedBox(height: 15),
              contentPadding: const EdgeInsets.symmetric(horizontal: Insets.m * 2),
              children: [
                ProfileOptionCard(
                    icon: PhosphorIcons.user_circle_fill, onTap: () {}, title: 'personal_information'.translate),
                ProfileOptionCard(
                    icon: PhosphorIcons.buildings_fill, onTap: () {}, title: 'building_information'.translate),
                ProfileOptionCard(icon: PhosphorIcons.nut_fill, onTap: () {}, title: 'own_items'.translate),
                ProfileOptionCard(icon: PhosphorIcons.bell_fill, onTap: () {}, title: 'notifications'.translate),
                ProfileOptionCard(icon: PhosphorIcons.moon_fill, onTap: () {}, title: 'display_mode'.translate),
                Divider(),
                ProfileOptionCard(icon: PhosphorIcons.share_network_fill, onTap: () {}, title: 'share'.translate),
                ProfileOptionCard(icon: PhosphorIcons.info_fill, onTap: () {}, title: 'contact_us'.translate),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kPrimaryColor),
        const SizedBox(width: 20),
        Text(
          title,
          style: TextStyles.h1.withColor(kPrimaryColor),
        ),
        const Spacer(),
        const Icon(PhosphorIcons.caret_right, color: kPrimaryColor),
      ],
    );
  }
}