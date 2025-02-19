Uri getGoogleImageEncodedURL(String item) {
  String url = "https://www.google.com/search?q=$item&sclient=img&udm=2";
  return Uri.parse(Uri.encodeFull(url));
}
