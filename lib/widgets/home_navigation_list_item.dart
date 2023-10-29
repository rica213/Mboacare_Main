import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/sign_up/sign_up_page.dart';

class HomeNavigationItems extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconImage;
  final GestureTapCallback onTap;

  const HomeNavigationItems({
    super.key,
    required this.subtitle,
    required this.title,
    required this.iconImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: AppColors.primaryColor,
        // backgroundBlendMode: BlendMode.color,
        image: const DecorationImage(
          fit: BoxFit
              .cover, //I assumed you want to occupy the entire space of the card
          image: AssetImage(
            'lib/assests/images/homepage-tile-background2.jpg',
          ),
          colorFilter: ColorFilter.mode(
            // AppColors.primaryColor,
            Colors.green,
            BlendMode.color,
          ),
        ),
      ),
      child: ListTile(
        // tileColor: AppColors.primaryColor,
        minVerticalPadding: 16.0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.white,
          ),
        ),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            iconImage,
            // 'lib/assests/icons/hospital.svg',
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
