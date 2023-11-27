import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeUtil {
  static const second = 1000;
  static const fifteenSeconds = 15 * second;
  static const thirtySecond = 30 * second;
  static const formatFull = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const formatSimple = "dd MMM yyyy";
  static const formatDayName  = "EEEE, d MMMM yyyy";
  static const fgdpExpected = "dd/MM/yyyy";
  static const moduleExpected = "dd/MM/yy HH.mm";
  static const fgdpFormat = "yyyy-mm-dd";
  static const formatDateTime = "dd MMM yyyy, HH.mm a";
  static const formatClassTime = "dd MMM yyyy • HH.mm";
  static const formatDatePicker = "dd MMM yyyy, HH.mm";
  static const formatDateWithFullTime = "yyyy-MM-dd HH:mm:ss.SSS";
  static const locale = 'id_ID';

  static String getCurrentDate({
    String toFormat = formatDayName,
    String locale = locale,
  }) {

    DateTime currentDate = DateTime.now();

    return DateFormat(toFormat, locale).format(currentDate);
  }

  static String translateDateTime(
    String dateTime, {
    String fromFormat = formatFull,
    String toFormat = formatSimple,
    String locale = locale,
  }) {
    try {
      var dt = DateFormat(fromFormat).parse(dateTime);
      return DateFormat(toFormat, locale).format(dt);
    } on FormatException catch (_) {
      return dateTime;
    }
  }

  bool isDate1GreaterThanDate2(String date1, String date2) {
    try {
      DateTime dateTime1 = DateTime.parse(date1);
      DateTime dateTime2 = DateTime.parse(date2);

      return dateTime1.isAfter(dateTime2);
    } catch (e) {
      return false;
    }
  }

  static String translateDateTimeLocale(
    String dateTime, {
    String fromFormat = formatFull,
    String toFormat = formatSimple,
    String locale = locale,
  }) {
    try {
      tz.initializeTimeZones();
      DateTime utcTime = DateTime.parse(dateTime);
      tz.TZDateTime utcDateTime = tz.TZDateTime.utc(utcTime.year, utcTime.month,
          utcTime.day, utcTime.hour, utcTime.minute, utcTime.second);
      tz.Location timeZone = tz.getLocation('Asia/Jakarta');
      tz.TZDateTime localDateTime = tz.TZDateTime.from(utcDateTime, timeZone);
      String formattedTime = DateFormat(toFormat).format(localDateTime);

      return formattedTime;
    } on FormatException catch (_) {
      return dateTime;
    }
  }

  static String translateDuration(int durationInSecond) {
    return sprintf(
      '%02d:%02d',
      [durationInSecond ~/ 60, (durationInSecond % 60)],
    );
  }

  static DateTime combineDateTime(String date, String time) {
// Parse the date string
    DateTime parsedDate = DateTime.parse(date);

    // Parse the time string
    List<String> timeComponents = time.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1].split(' ')[0]);
    String meridian = '';
    if (timeComponents[1].split(' ').length > 1) {
      meridian = timeComponents[1].split(' ')[1];
      if (meridian == 'PM' && hour < 12) {
        hour += 12;
      } else if (meridian == 'AM' && hour == 12) {
        hour = 0;
      }
    }

    // Combine the date and time
    DateTime combinedDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      hour,
      minute,
    );

    return combinedDateTime;
  }

  DateTime convertToLocalTime(String givenDate) {
    // Parse the given date
    DateTime parsedDate = DateTime.parse(givenDate);

    // Obtain the local time zone offset
    Duration offset = DateTime.now().timeZoneOffset;

    // Apply the offset to convert to the local time zone
    DateTime localDateTime = parsedDate.add(offset);

    return localDateTime;
  }

  String convertToLocalTimeString(String givenDate,
      {String toFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    // Parse the given date
    DateTime parsedDate = DateTime.parse(givenDate);

    // Obtain the local time zone offset
    Duration offset = DateTime.now().timeZoneOffset;

    // Apply the offset to convert to the local time zone
    DateTime localDateTime = parsedDate.add(offset);

    // Format the local date and time as a string
    String formattedDate = DateFormat(toFormat).format(localDateTime);

    return formattedDate;
  }

  DateTime calculateGivenDateBefore(String givenDate, int days) {
    // Parse the given date
    DateTime parsedDate = DateTime.parse(givenDate);

    // Subtract one day
    DateTime oneDayBefore = parsedDate.subtract(Duration(days: days));

    return oneDayBefore;
  }

  String calculateGivenDateBeforeString(DateTime givenDate, int days,
      {String toFormat = formatDateTime}) {
    // Subtract one day
    DateTime oneDayBefore = givenDate.subtract(Duration(days: days));

    String formattedDate = DateFormat(toFormat).format(oneDayBefore);

    return formattedDate;
  }

  bool isFirstBeforeSecond(String firstDateTime, String secondDateTime) {
    // Parse the given date and time strings
    DateTime firstDate = DateTime.parse(firstDateTime);
    DateTime secondDate = DateTime.parse(secondDateTime);

    // Compare the two date and time values
    return firstDate.isBefore(secondDate);
  }

  bool isNowBeforeGivenDate(String secondDateTime, int day) {
    // Parse the given date and time strings
    DateTime firstDate = DateTime.now();
    DateTime secondDate =
        DateTime.parse(secondDateTime).subtract(Duration(days: day));

    // Compare the two date and time values
    return firstDate.isBefore(secondDate);
  }

  bool isNowAfterGivenDate(String secondDateTime, {int day = 0}) {
    // Parse the given date and time strings
    DateTime firstDate = DateTime.now();
    DateTime secondDate =
        DateTime.parse(secondDateTime).subtract(Duration(days: day));

    // Compare the two date and time values
    return firstDate.isAfter(secondDate);
  }
}
