// ignore_for_file: file_names

int getInitialPageIndex() {
  final DateTime currentDate = DateTime.now();
  final int time = currentDate.hour * 60 + currentDate.minute;
  late final int initPage;
  if (time < 600) {
    initPage = 0;
  } else if (time >= 600 && time < 860) {
    initPage = 1;
  } else if (time >= 860 && time < 1080) {
    initPage = 2;
  } else {
    initPage = 3;
  }
  // print(initPage);
  return initPage;
}
