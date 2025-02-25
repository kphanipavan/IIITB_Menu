import "package:flutter/material.dart";
import "package:iiitb_menu/constants.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:share_plus/share_plus.dart";

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Share")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
            child: QrImageView(
              data: appURL,
              // eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square),
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              // embeddedImage: AssetImage("assets/plate.png"),
            ),
          ),
          InkWell(
            enableFeedback: true,
            onTap: () {
              var _ = Share.share(
                "Hey, use this to track IIITB's Mess Menu. https://kphanipavan.github.io/IIITB_Menu/",
                // subject: "IIITB Menu App",
              );
              // ret.then((value) {
              //   print(value.status);
              // });
            },
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    appURL,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(Icons.share_rounded, size: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}
