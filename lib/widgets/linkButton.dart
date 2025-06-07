import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class LinkButton extends StatelessWidget {
  final Uri link;
  final String iconImage;
  final double height;
  const LinkButton(
      {Key? key, required this.link, required this.iconImage, this.height = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(link)) {
          launchUrl(link);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(image: AssetImage(iconImage), height: height),
      ),
    );
  }
}
