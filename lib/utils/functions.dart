import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'constants.dart' show mainGold, primary;

void showError(String message,
    {Color background = mainGold, Color text = primary}) {
  HapticFeedback.heavyImpact();
  showToast(message, background: background, text: text);
}

void showToast(String message,
        {Color background = mainGold, Color text = primary}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2,
      backgroundColor: background,
      textColor: text,
      fontSize: 14.sp,
    );

void unFocus() => FocusManager.instance.primaryFocus?.unfocus();

String formatAmount(String price) {
  String priceInText = "";
  int counter = 0;
  for (int i = (price.length - 1); i >= 0; i--) {
    counter++;
    String str = price[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

String formatLocation(String location,
    {String separate = "#", String format = ", "}) {
  List<String> split = location.split(separate);
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < split.length; ++i) {
    buffer.write(split[i]);
    if (i != split.length - 1) {
      buffer.write(format);
    }
  }
  return buffer.toString();
}

String currency() => NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

String formatDateString(String dateTime,
    {bool shorten = false, bool fancy = false}) {
  int firIndex = dateTime.indexOf("/");
  String d = dateTime.substring(0, firIndex);
  int secIndex = dateTime.indexOf("/", firIndex + 1);
  String m = dateTime.substring(firIndex + 1, secIndex);
  String y = dateTime.substring(secIndex + 1);

  return !fancy
      ? "${month(m, shorten)} ${day(d)}, $y"
      : "${day(d)} of ${month(m, shorten)}, $y";
}

String formatDateTime(DateTime dateTime,
        {bool shorten = false, bool fancy = false}) =>
    formatDateString(DateFormat("dd/MM/yyy").format(dateTime),
        shorten: shorten, fancy: fancy);

String formatTime(int duration) {
  int time = (duration * 0.001).truncate();
  int min = (time / 60).truncate();
  int sec = time % 60;
  return "${min < 10 ? "0$min" : min}:${sec < 10 ? "0$sec" : sec}";
}

String month(String val, bool shorten) {
  int month = int.parse(val);
  switch (month) {
    case 1:
      return shorten ? "Jan" : "January";
    case 2:
      return shorten ? "Feb" : "February";
    case 3:
      return shorten ? "Mar" : "March";
    case 4:
      return shorten ? "Apr" : "April";
    case 5:
      return "May";
    case 6:
      return shorten ? "Jun" : "June";
    case 7:
      return shorten ? "Jul" : "July";
    case 8:
      return shorten ? "Aug" : "August";
    case 9:
      return shorten ? "Sep" : "September";
    case 10:
      return shorten ? "Oct" : "October";
    case 11:
      return shorten ? "Nov" : "November";
    default:
      return shorten ? "Dec" : "December";
  }
}

String day(String val) {
  int day = int.parse(val);
  int remainder = day % 10;
  switch (remainder) {
    case 1:
      return (day == 11) ? "${day}th" : "${day}st";
    case 2:
      return (day == 12) ? "${day}th" : "${day}nd";
    case 3:
      return (day == 13) ? "${day}th" : "${day}rd";
    default:
      return "${day}th";
  }
}

Future<void> launchSocialMediaUrl(String url) async {
  Uri destination = Uri.parse("https://$url");
  await launchUrl(destination, mode: LaunchMode.externalApplication);
}

Future<void> launchContactUrl(String contact,
    {String countryCode = "+234"}) async {
  if (contact.isEmpty) return;
  Uri number = Uri.parse("tel:$countryCode${contact.substring(1)}");
  await launchUrl(number);
}

Future<void> launchEmail(String address,
    {String emailSubject = "", String emailBody = ""}) async {
  String email = Uri.encodeComponent(address);
  String subject = Uri.encodeComponent("Playbucks:$emailSubject");
  String body = Uri.encodeComponent(emailBody);
  Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
  await launchUrl(mail);
}

Future<void> launchWebUrl(String url) async {
  String prefix = "https://";
  Uri address = Uri.parse("$prefix$url");
  await launchUrl(address, mode: LaunchMode.externalApplication);
}

void textChecker({required String text, required VoidCallback onAction}) {
  if (text.length == 1 || text.isEmpty) {
    onAction();
  }
}

bool validateForm(GlobalKey<FormState> formKey) {
  unFocus();
  FormState? currentState = formKey.currentState;
  if (currentState != null) {
    if (!currentState.validate()) return false;

    currentState.save();
    return true;
  }
  return false;
}

String formatAmountInDouble(double price, {int digits = 0}) =>
    formatAmount(price.toStringAsFixed(digits));

String formatDateRaw(DateTime date, {bool shorten = false}) =>
    formatDate(DateFormat("dd/MM/yyy").format(date), shorten: shorten);

String formatDateWithTime(DateTime date, {bool shorten = false}) =>
    formatDate(DateFormat("dd/MM/yyy").format(date),
        shorten: shorten, time: date);

String formatDate(String dateTime, {bool shorten = false, DateTime? time}) {
  int firIndex = dateTime.indexOf("/");
  String d = dateTime.substring(0, firIndex);
  int secIndex = dateTime.indexOf("/", firIndex + 1);
  String m = dateTime.substring(firIndex + 1, secIndex);
  String y = dateTime.substring(secIndex + 1);

  String formatTime = "";
  if (time != null) {
    formatTime =
        " ${(time.hour - 12) < 10 ? "0" : ""}${time.hour - 12}:${time.minute} ${time.hour < 12 ? "AM" : "PM"}";
  }

  return "${day(d)} ${month(m, shorten)}, $y$formatTime";
}

String joinToAddress(String address, {bool ignoreFourth = false}) {
  List<String> subs = address.split("#");
  return "${subs[0]}, ${subs[1]}, ${subs[2]}${ignoreFourth ? "" : ", ${subs[3]}"}";
}

List<String> toStringList(List<dynamic> data) {
  List<String> result = [];
  for (var element in data) {
    result.add(element as String);
  }
  return result;
}

String generateWhatsAppLink(
    {String number = "", String code = "+234", String text = ""}) {
  String link = "wa.me/$code$number?text=";
  List<String> split = text.split(" ");
  for (int i = 0; i < split.length; ++i) {
    String s = split[i];
    link = "$link$s";
    if (i != split.length - 1) {
      link = "$link%20";
    }
  }

  return link;
}
