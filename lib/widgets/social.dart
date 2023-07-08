import 'package:flutter/material.dart';
import 'package:zena_foru/widgets/social_btn.dart';
import 'package:share_plus/share_plus.dart';

class Social extends StatelessWidget {
  Social({super.key});

  final socials = [
    {
      'iconPath': 'assets\\icons\\icon_linkedin.png',
      'link': 'https://linkedin.com/in/dawit-tesfamariam-ab1450220',
    },
    {
      'iconPath': 'assets\\icons\\icon_twitter.png',
      'link': 'https://twitter.com/davortes',
    },
  ];

  _onShareTap() {
    Share.share(
        'Check out my app https://play.google.com/store/apps/details?id=studio.app.davortes.keepnote');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.2)),
                  top: BorderSide(
                      width: 0.5,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.2))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...socials.map(
                  (social) => SocialButton(
                    url: social['link'] as String,
                    iconPath: social['iconPath'] as String,
                  ),
                ),
                InkWell(
                  onTap: _onShareTap,
                  child: Image.asset(
                    'assets\\icons\\icon_share.png',
                    width: 36,
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          ),
          Text('2023 \u00a9 Dawit T.'),
        ],
      ),
    );
  }
}
