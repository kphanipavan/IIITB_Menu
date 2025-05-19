import "package:flutter/material.dart";
import "package:iiitb_menu/constants.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:share_plus/share_plus.dart";

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.sizeOf(context).width >=
        MediaQuery.sizeOf(context).height * 1.5;
    return Scaffold(
      appBar: AppBar(title: const Text("Share")),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        child: Flex(
          direction: isScreenWide ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
              child: QrImageView(
                data: appURL,
                // eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square),
                // embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                size: 320,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      appURL,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD1C4E9),
                        // color: Colors.deepPurpleAccent[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.share_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
