import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool get isPortrait => Get.mediaQuery.size.height > Get.mediaQuery.size.width;

bool get isTablet =>
    math.sqrt((Get.size.width * Get.size.width) +
        (Get.size.height * Get.size.height)) >
    1100;
// FIELDS
// Text Field

looseFocus(BuildContext context) {
  final FocusScopeNode currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus.unfocus();
  }
}

String timeFormat(DateTime time, int format) {
  if (time == null) return '';
  var hour = format == 12 && time.hour > 12 ? time.hour - 12 : time.hour;
  var minute = time.minute;
  String ampm = time.hour >= 12 ? 'PM' : 'AM';
  String h = hour >= 10 ? '$hour' : '0$hour';
  String m = minute >= 10 ? '$minute' : '0$minute';
  return '$h : $m ${format == 12 ? ampm : ''}';
}

getOrdinalWeek(DateTime date) {
  var a = date.day ~/ 7;
  var b = date.day / 7;
  int res;
  if (b > a)
    res = a + 1;
  else
    res = a;
  switch (res) {
    case 1:
      return 'first';
      break;
    case 2:
      return 'second';
      break;
    case 3:
      return 'third';
      break;
    case 4:
      return 'fourth';
      break;
    case 5:
      return 'last';
      break;

    default:
      break;
  }
}

String monthName(DateTime date) {
  if (date == null) return '';
  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return '${month[date.month - 1]}, ${date.year}';
}

// String dateFormat(DateTime dateTime, bool short, {bool symbol = true}) {
//   var monthToString = [
//     'January',
//     'February',
//     'March',
//     'April',
//     'May',
//     'June',
//     'July',
//     'August',
//     'September',
//     'October',
//     'November',
//     'December',
//   ];

//   return short
//       ? '${weekName[dateTime.weekday].substring(0, 3)}, ${monthToString[dateTime.month - 1].substring(0, 3)} ${dateTime.day}${getDaySymbol(dateTime.day)}'
//       : '${monthToString[dateTime.month - 1]} ${dateTime.day}${symbol ? getDaySymbol(dateTime.day) : ""}, ${dateTime.year}';
// }

String getDaySymbol(int day) {
  if (day == 11) return 'th';
  if (day == 12) return 'th';
  if (day == 13) return 'th';
  if (day.toString().endsWith('1')) return 'st';
  if (day.toString().endsWith('2')) return 'nd';
  if (day.toString().endsWith('3'))
    return 'rd';
  else
    return 'th';
}

// List<String> get weekName => LocaleKeys.locale.tr == 'vi'
//     ? [
//         '',
//         'Th??? 2',
//         'Th??? 3',
//         'Th??? 4',
//         'Th??? 5',
//         'Th??? 6',
//         'Th??? 7',
//         'Ch??? nh???t',
//       ]
//     : [
//         '',
//         'Monday',
//         'Tuesday',
//         'Wednesday',
//         'Thursday',
//         'Friday',
//         'Saturday',
//         'Sunday',
//       ];

weekDayToInt(String day) {
  if (day.toLowerCase() == 'monday') return 1;
  if (day.toLowerCase() == 'tuesday') return 2;
  if (day.toLowerCase() == 'wednesday') return 3;
  if (day.toLowerCase() == 'thursday') return 4;
  if (day.toLowerCase() == 'friday') return 5;
  if (day.toLowerCase() == 'saturday') return 6;
  if (day.toLowerCase() == 'sunday') return 7;
}

String htmlEncode(String text) {
  List lines = text.split('\n');
  List htmlLines = [];
  lines.forEach((element) {
    htmlLines.add('<p>$element</p>');
  });
  return htmlLines.join();
}

DateTime dateTimeEnCodeForMail(String string) {
  if (string != null) {
    List date;
    List time;
    List<dynamic> extract = string.split('T');
    date = extract[0].split('-');
    time = extract[1].split(':');
    return string.endsWith('Z')
        ? DateTime.utc(
            int.parse(date[0]),
            int.parse(date[1]),
            int.parse(date[2]),
            int.parse(time[0]),
            int.parse(time[1]),
          )
        : DateTime(
            int.parse(date[0]),
            int.parse(date[1]),
            int.parse(date[2]),
            int.parse(time[0]),
            int.parse(time[1]),
          ).toUtc();
  } else {
    return null;
  }
}

DateTime dateTimeEncode(String string) {
  List date;
  List time;
  List last;
  List<dynamic> extract = string.split('T');
  date = extract[0].split('-');
  time = extract[1].split(':');
  last = time[2].split('.');
  return DateTime.utc(
    int.parse(date[0]),
    int.parse(date[1]),
    int.parse(date[2]),
    int.parse(time[0]),
    int.parse(time[1]),
    int.parse(last[0]),
  );
}

checkLastDownloadTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return DateTime.now()
          .toUtc()
          .compareTo(dateTimeEncode(prefs.getString('lastDownloadTime'))) >
      0;
}

List<List> partition(List list, int number) {
  List<List> res = [];
  int count = 0;
  list.forEach((element) {
    count == 0 ? res.add([element]) : res.last.add(element);
    count++;
    if (count == number) count = 0;
  });
  return res;
}

String byteConverter(int byte) {
  double size = byte.toDouble();
  if (size < 1024) return '${size.toStringAsFixed(1)} byte';
  size = size / 1024;
  if (size < 1024) return '${size.toStringAsFixed(1)} kb';
  size = size / 1024;
  if (size < 1024) return '${size.toStringAsFixed(1)} mb';
  size = size / 1024;
  if (size < 1024) return '${size.toStringAsFixed(1)} gb';
  return '';
}

String thousandSeparator(int input) {
  bool negative = input < 0;
  if (negative) input *= -1;
  String t = input.toString();
  int a = t.length;
  List<String> f = t.split('');
  if (t.length % 3 == 0) {
    for (int i = 1; i < t.length ~/ 3; i++) {
      a = a - 3;
      f.insert(a, ',');
    }
  } else {
    for (int j = 0; j < t.length ~/ 3; j++) {
      a = a - 3;
      f.insert(a, ',');
    }
  }
  if (negative) f.insert(0, '-');
  return f.join();
}

// loadingDialog() async {
//   // await Get.dialog(Dialog(
//   //   child: Container(
//   //     padding: EdgeInsets.all(10),
//   //     child: Lottie.asset('images/bamboo_loading.zip', height: 300),
//   //   ),
//   // ));
//   await Get.dialog(
//     Stack(
//       children: [
//         Container(
//           height: Get.mediaQuery.size.height,
//           width: Get.mediaQuery.size.width,
//           color: Colors.white.withOpacity(0.5),
//         ),
//         Container(
//           alignment: Alignment.topCenter,
//           padding: EdgeInsets.symmetric(vertical: 70),
//           child: AnimatedOpacity(
//             opacity: 1,
//             duration: Duration(seconds: 2),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(
//                 sigmaX: 20,
//                 sigmaY: 20,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
//               ),
//             ),
//           ),
//           height: Get.mediaQuery.size.height,
//           width: Get.mediaQuery.size.width,
//         ),
//         Dialog(
//           elevation: 0,
//           insetPadding: EdgeInsets.zero,
//           backgroundColor: Colors.transparent,
//           child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 30),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Lottie.asset('images/bamboo_loading.zip', height: 200),
//                   SizedBox(height: 10),
//                   // Text(text),
//                 ],
//               )),
//         ),
//       ],
//     ),
//     useSafeArea: false,
//     barrierDismissible: false,
//   );
// }

bool loadMoreArea(
  double maxOffset,
  double position,
  int length, {
  int triggerPoint = 100,
}) {
  if (length > triggerPoint) {
    double trigger = maxOffset - (maxOffset * (triggerPoint / length));
    return position > trigger;
  }
  return true;
}

String boDau(String vietChars) {
  final charSet = [
    "aAeEoOuUiIdDyY",
    "??????????????????????????????????????????????",
    "??????????????????????????????????????????????",
    "??????????????????????????????",
    "??????????????????????????????",
    "??????????????????????????????????????????????",
    "??????????????????????????????????????????????",
    "?????????????????????????????",
    "?????????????????????????????",
    "????????????",
    "????????????",
    "??",
    "??",
    "??????????????",
    "??????????????"
  ];

  for (int i = 1; i < charSet.length; i++) {
    for (int j = 0; j < charSet[i].length; j++)
      vietChars = vietChars.replaceAll(charSet[i][j], charSet[0][i - 1]);
  }
  return vietChars;
}

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  MarqueeWidget({
    @required this.child,
    this.direction: Axis.horizontal,
    this.animationDuration: const Duration(milliseconds: 3000),
    this.backDuration: const Duration(milliseconds: 800),
    this.pauseDuration: const Duration(milliseconds: 800),
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.ease);
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(0.0,
            duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}

String compoundUnicode(String unicodeStr) {
  unicodeStr = unicodeStr.codeUnits.toString();
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0065', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EBB', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0065', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00E9', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0065', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00E8', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0065', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EB9', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0065', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EBD', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00EA', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EC3', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00EA', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EBF', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00EA', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EC1', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00EA', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EC7', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00EA', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EC5', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0079', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EF7', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0079', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00FD', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0079', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EF3', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0079', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EF5', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0079', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EF9', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0075', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EE7', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0075', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00FA', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0075', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00F9', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0075', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EE5', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0075', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('0169', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01B0', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EED', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01B0', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EE9', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01B0', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EEB', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01B0', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EF1', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01B0', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EEF', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0069', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EC9', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0069', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00ED', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0069', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00EC', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0069', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1ECB', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0069', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('0129', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('006F', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1ECF', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('006F', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00F3', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('006F', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00F2', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('006F', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1ECD', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('006F', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('00F5', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A1', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EDF', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A1', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EDB', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A1', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EDD', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A1', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EE3', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A1', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EE1', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00F4', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1ED5', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00F4', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1ED1', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00F4', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1ED3', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00F4', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1ED9', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00F4', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1ED7', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0061', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EA3', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0061', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00E1', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0061', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00E0', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0061', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EA1', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0061', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('00E3', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0103', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EB3', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0103', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EAF', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0103', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EB1', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0103', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EB7', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0103', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EB5', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00E2', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EA9', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00E2', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EA5', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00E2', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EA7', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00E2', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EAD', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00E2', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EAB', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0045', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EBA', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0045', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00C9', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0045', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00C8', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0045', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EB8', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0045', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EBC', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00CA', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EC2', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00CA', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EBE', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00CA', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EC0', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00CA', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EC6', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00CA', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EC4', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0059', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EF6', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0059', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00DD', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0059', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EF2', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0059', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EF4', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0059', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EF8', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0055', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EE6', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0055', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00DA', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0055', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00D9', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0055', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EE4', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0055', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('0168', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01AF', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EEC', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01AF', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EE8', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01AF', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EEA', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01AF', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EF0', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01AF', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EEE', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0049', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EC8', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0049', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00CD', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0049', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00CC', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0049', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1ECA', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0049', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('0128', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('004F', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1ECE', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('004F', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00D3', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('004F', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00D2', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('004F', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1ECC', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('004F', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('00D5', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A0', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EDE', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A0', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EDA', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A0', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EDC', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A0', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EE2', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('01A0', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EE0', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00D4', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1ED4', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00D4', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1ED0', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00D4', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1ED2', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00D4', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1ED8', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00D4', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1ED6', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0041', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EA2', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0041', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('00C1', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0041', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('00C0', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0041', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EA0', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0041', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('00C3', radix: 16)}"); // ??
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0102', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EB2', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0102', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EAE', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0102', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EB0', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0102', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EB6', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('0102', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EB4', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00C2', radix: 16)}, ${int.parse('0309', radix: 16)}",
      "${int.parse('1EA8', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00C2', radix: 16)}, ${int.parse('0301', radix: 16)}",
      "${int.parse('1EA4', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00C2', radix: 16)}, ${int.parse('0300', radix: 16)}",
      "${int.parse('1EA6', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00C2', radix: 16)}, ${int.parse('0323', radix: 16)}",
      "${int.parse('1EAC', radix: 16)}"); // ???
  unicodeStr = unicodeStr.replaceAll(
      "${int.parse('00C2', radix: 16)}, ${int.parse('0303', radix: 16)}",
      "${int.parse('1EAA', radix: 16)}"); // ???
  final charList =
      unicodeStr.replaceAll('[', '').replaceAll(']', '').split(', ');
  final charListInt =
      List.generate(charList.length, (i) => int.parse(charList[i]));
  final string = String.fromCharCodes(charListInt);
  // log(string + '  ' + string.codeUnits.toString());
  // log('m???c ???? x??a' + '--' + 'm???c ???? x??a'.codeUnits.toString());
  return string;
}

DateTime dateOnly(DateTime date) {
  if (date == null) return DateTime.now();
  return DateTime(date.year, date.month, date.day);
}

Color parseColor(String color) {
  String hex = color.replaceAll("#", "");
  if (hex.isEmpty) hex = "ffffff";
  if (hex.length == 3) {
    hex =
        '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
  }
  Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  return col;
}

/// Chuy???n chu???i s??? ???? cho theo ?????nh d???ng
///
/// ```dart
/// formatNumWithFormat(string:  '1234567890', format: '(000,000,0000)');// '(123,456,7890)'
/// N???u ????? format b???ng ''
/// formatNumWithFormat(string: '1234567890');// '1,234,567,890'
/// ```

String numWithFormat({String string = '', String format = ''}) {
  if (string == '' || string == null || string == 'null') {
    return 'n/a';
  }
  if (format == '') {
    try {
      List arrNum = string.split('.');
      format = thousandSeparator(int.parse(arrNum[0])) + arrNum[1];
    } catch (e) {
      format = thousandSeparator(int.parse(string));
    }
  }
  var result = '';
  var fpos = 0;
  var spos = 0;
  try {
    while ((format.length - 1) >= fpos) {
      if (format.substring(fpos, fpos + 1).isNum) {
        result = result + string.substring(spos, spos + 1);
        if (spos < string.length) {
          spos++;
        }
      } else {
        result = result + format.substring(fpos, fpos + 1);
      }
      if (fpos < format.length) {
        fpos++;
      }
    }
    return result;
  } catch (e) {
    return null;
  }
}

Future<DateTime> datePicker(BuildContext context,
    {DateTime selectedDate}) async {
  return await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now().add(Duration(days: 365 * 2)));
}

Future<TimeOfDay> timePicker(BuildContext context,
    {TimeOfDay selectedTime}) async {
  return await showTimePicker(
    context: context,
    initialTime: selectedTime != null ? selectedTime : TimeOfDay.now(),
  );
}
