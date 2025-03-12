Uri getImageSearchEncodedURL(String item) {
  // String url = "https://www.google.com/search?q=$item&sclient=img&udm=2";
  String url = "https://duckduckgo.com/?q=$item&iax=images&ia=web";
  return Uri.parse(Uri.encodeFull(url));
}
