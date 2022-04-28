import 'package:freej/app/profile/views/building_view.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../../core/services/local/shared_pref.dart';
import '../../auth/models/user.dart';
import '../../auth/services/auth_services.dart';
import 'edit_profile_view.dart';
import 'personal_posts_view.dart';

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
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    shape: BoxShape.circle,
                  ),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kPrimaryColor, width: 2),
                  ),
                  child: CachedImage(
                    url: user.photo,
                    fit: BoxFit.cover,
                    shape: BoxShape.circle,
                    errorWidget: const Icon(PhosphorIcons.user, size: 100, color: kPrimaryColor),
                    size: Size(MediaQuery.of(context).size.width / 3, MediaQuery.of(context).size.width / 3),
                  ),
                ),
                const SizedBox(height: 15),
                Text(user.name, style: TextStyles.h1.withColor(kPrimaryColor).withWeight(FontWeight.w500)),
                const SizedBox(height: 5),
                Text("${'building'.translate} ${user.campusDetails?.building.name}",
                    style: TextStyles.body3.withColor(kHintFontsColor).withWeight(FontWeight.bold)),
                const SizedBox(height: 5),
                Text("${'room'.translate} ${user.campusDetails?.building.room.name}",
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
                  icon: PhosphorIcons.user_circle_fill,
                  onTap: () => Nav.openPage(context: context, page: const EditProfileView()),
                  title: 'personal_information'.translate,
                ),
                ProfileOptionCard(
                  icon: PhosphorIcons.nut_fill,
                  onTap: () => Nav.openPage(context: context, page: const MyPostsView()),
                  title: translateText('my_posts', context: context),
                ),
                ProfileOptionCard(
                  icon: PhosphorIcons.buildings_fill,
                  onTap: () => Nav.openPage(context: context, page: const BuildingView()),
                  title: 'building_information'.translate,
                ),
                ProfileOptionCard(icon: PhosphorIcons.bell_fill, onTap: () {}, title: 'notifications'.translate),
                ProfileOptionCard(icon: PhosphorIcons.moon_fill, onTap: () {}, title: 'display_mode'.translate),
                const Divider(),
                ProfileOptionCard(icon: PhosphorIcons.share_network_fill, onTap: () {}, title: 'share'.translate),
                ProfileOptionCard(icon: PhosphorIcons.info_fill, onTap: () {}, title: 'contact_us'.translate),
                ProfileOptionCard(
                  icon: PhosphorIcons.translate,
                  title: isArabic() ? 'إنجليزي - English' : 'Arabic - عربي',
                  onTap: () async {
                    await SharedPreference.instance.switchLocale(context);
                  },
                ),
                const Divider(),
                ProfileOptionCard(
                  icon: PhosphorIcons.sign_out,
                  onTap: () => AuthServices.logout(context),
                  title: 'logout'.translate,
                  color: kRed2,
                ),
                // ProfileOptionCard(
                //   icon: PhosphorIcons.intersect,
                //   onTap: () async {
                //     await FirebaseFirestore.instance.collection('test').doc("test1").set({"data": "test"});
                //   },
                //   title: 'test',
                // ),
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
  final Color? color;

  const ProfileOptionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kTransparent,
        child: Row(
          children: [
            Icon(icon, color: color ?? kPrimaryColor),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyles.h1.withColor(color ?? kPrimaryColor),
            ),
            const Spacer(),
            Icon(PhosphorIcons.caret_right, color: color ?? kPrimaryColor),
          ],
        ),
      ),
    );
  }
}
