import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:playbucks/utils/constants.dart';


void showError(BuildContext context, String message)
{
  HapticFeedback.heavyImpact();
  context.messenger.showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 1),
    dismissDirection: DismissDirection.vertical,
  ),);
}

void unFocus() => FocusManager.instance.primaryFocus?.unfocus();

String formatAmount(String price)
{
  String priceInText = "";
  int counter = 0;
  for(int i = (price.length - 1);  i >= 0; i--)
  {
    counter++;
    String str = price[i];
    if((counter % 3) != 0 && i !=0) {
      priceInText = "$str$priceInText";
    } else if(i == 0 ) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

String formatLocation(String location, {String separate = "#", String format = ", "}) {
  List<String> split = location.split(separate);
  StringBuffer buffer = StringBuffer();
  for(int i = 0; i < split.length; ++i) {
    buffer.write(split[i]);
    if(i != split.length - 1) {
      buffer.write(format);
    }
  }
  return buffer.toString();
}

String currency() => NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

String formatDateString(String dateTime) {
  int firIndex = dateTime.indexOf("/");
  String d = dateTime.substring(0, firIndex);
  int secIndex = dateTime.indexOf("/", firIndex + 1);
  String m = dateTime.substring(firIndex + 1, secIndex);
  String y = dateTime.substring(secIndex + 1);

  return "${month(m)} ${day(d)}, $y";
}

String formatDateTime(DateTime dateTime) => formatDateString(DateFormat("dd/MM/yyy").format(dateTime));

String month(String val) {
  int month = int.parse(val);
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    default:
      return "December";
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

Future<void> launchContactUrl(String contact, {String countryCode = "+234"}) async {
  if(contact.isEmpty) return;
  Uri number = Uri.parse("tel:$countryCode${contact.substring(1)}");
  await launchUrl(number);
}


Future<void> launchEmail(String address, {String emailSubject = "", String emailBody = ""}) async {
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
