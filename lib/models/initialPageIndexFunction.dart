// ignore_for_file: file_names

int getInitialPageIndex() {
  DateTime currentDate = DateTime.now();
  late final int initPage;
  if (currentDate.hour < 10) {
    initPage = 0;
  } else if (currentDate.hour >= 10 && currentDate.hour < 15) {
    initPage = 1;
  } else if (currentDate.hour >= 15 && currentDate.hour < 18) {
    initPage = 2;
  } else {
    initPage = 3;
  }
  print(initPage);
  return initPage;
}
