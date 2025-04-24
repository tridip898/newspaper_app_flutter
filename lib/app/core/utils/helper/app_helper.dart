import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../network/api_urls.dart';
import '../../constraints/app_constraints.dart';

class AppHelper {
  final storage = const FlutterSecureStorage();
  late SharedPreferences prefs;

  saveToken(String token) async {
    await storage
        .write(key: "token", value: token)
        .whenComplete(() => logger.d('saveToken:  Saved'));
  }

  Future<String?> getToken() async {
    try {
      final accessToken = await storage.read(key: "token");
      return accessToken;
    } on PlatformException {
      await storage.deleteAll();
    }
    return null;
  }

  deleteToken() async {
    logger.i("Deleted");
    await storage.delete(key: "token");
    appHelper.hideLoader();
    // navigateLoginScreen();
  }

  saveRefreshToken(String token) async {
    await storage
        .write(key: "refresh_token", value: token)
        .whenComplete(() => logger.d('saveToken:  Saved'));
  }

  Future<String?> getRefreshToken() async {
    try {
      final accessToken = await storage.read(key: "refresh_token");
      return accessToken;
    } on PlatformException {
      await storage.deleteAll();
    }
    return null;
  }

  deleteRefreshToken() async {
    logger.i("Deleted");
    await storage.delete(key: "refresh_token");
    appHelper.hideLoader();
  }

  // navigateLoginScreen() {
  //   Get.offAllNamed(Routes.LOGIN_SCREEN);
  //   // Get.offAll(() => const LoginScreenView());
  // }

  saveIntPref(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  deleteIntPref(String key) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<int?> getIntPref(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  saveStringPref(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  deleteStringPref(String key) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<String?> getStringPref(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  hideLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  showLoader({needToShow = true}) {
    if (needToShow) {
      if (!EasyLoading.isShow) {
        return EasyLoading.show(
          status: "Loading...",
          maskType: EasyLoadingMaskType.black,
          dismissOnTap: kDebugMode ? true : false,
        );
      }
    }
  }

  Future<void> forceLogout() async {
    if (Get.currentRoute != "/login-screen") {
      await unSubscribeTopic();
      try {
        prefs = await SharedPreferences.getInstance();
        prefs.clear();
      } catch (e) {
        logger.d('forceLogout:  $e');
      }
      await storage.delete(key: "token");
      // Get.offAllNamed(Routes.LOGIN_SCREEN);
    }
  }

  validateImageURL(String url) {
    String finalUrl = url;
    if (url.startsWith("upload")) {
      finalUrl = baseImageUrl + url;
    } else if (url.startsWith("/storage")) {
      finalUrl = baseImageUrl + url;
    } else if (url.contains("https:")) {
      finalUrl = url;
    } else if (!url.contains("/")) {
      finalUrl = baseImageUrl + url;
    } else if (url.startsWith("https")) {
      finalUrl = url;
    } else {
      finalUrl = baseImageUrl + url;
    }
    logger.i("Image url $finalUrl");
    return finalUrl;
  }

  isValidImageUrl(String? url) {
    if (url == null) {
      return false;
    } else {
      if (url == baseImageUrl || url == "") {
        return false;
      }
      return true;
    }
  }

  directionClick(String lat, String lng) {
    if (Platform.isAndroid) {
      launchUrlString(
          'https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    } else if (Platform.isIOS) {
      launchUrlString('https://maps.apple.com/?q=$lat,$lng');
    }
  }

  String getOrdinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    } else {
      switch (number % 10) {
        case 1:
          return '${number}st';
        case 2:
          return '${number}nd';
        case 3:
          return '${number}rd';
        default:
          return '${number}th';
      }
    }
  }

  logout({needToShowMsg = false}) async {
    deleteToken();
    deleteRefreshToken();
    appHelper.showLoader();
    await unSubscribeTopic();
    storage.deleteAll();
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await Get.deleteAll(force: true);
  }

  //FCM

  /*subscribeFirebaseTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    // await FirebaseMessaging.instance.subscribeToTopic(token.toLowerCase());
  }

  unSubscribeFirebaseTopic() async {
    // await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
    // await FirebaseMessaging.instance.unsubscribeFromTopic(token.toLowerCase());
  }
*/
  Future<void> launchPhoneDialer(String contactNumber) async {
    logger.i("Email launch $contactNumber");
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (error) {
      throw ("Cannot dial $phoneUri");
    }
  }

  Future<void> launchEmail(String email) async {
    logger.i("Email launch $email");
    final Uri emailUri = Uri(scheme: "mailto", path: email);
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (error) {
      throw ("Cannot send email to $emailUri");
    }
  }

  formatTime(String time) {
    if (time == "") {
      return null;
    }
    return DateFormat.jms().format(
      DateTime.parse(time),
    );
  }

  formatJmTime(String time) {
    if (time == "") {
      return null;
    }
    return DateFormat('hh:mm aa').format(
      DateTime.parse(time),
    );
  }

  unSubscribeTopic() async {
    // String tempEmail =
    //     globalState.employeeData.value.companyEmail?.replaceAll("@", "%") ?? "";
    // bool isValidTopic =
    //     RegExp(r'^[a-zA-Z0-9-_.~%]{1,900}$').hasMatch(tempEmail);
    // if (isValidTopic && tempEmail != "") {
    //   try {
    //     logger.i(kDebugMode ? "dev%$tempEmail" : tempEmail);
    //     await FirebaseMessaging.instance
    //         .unsubscribeFromTopic(kDebugMode ? "dev%$tempEmail" : tempEmail);
    //   } catch (e) {
    //     logger.d('doneLogout:  $e');
    //   }
    // }
  }

  subscribeTopic() {
    // myHelper.getBoolPref("is_subscribed").then((value) {
    //   if (value == null) {
    //     String tempEmail =
    //         globalState.employeeData.value.companyEmail?.replaceAll("@", "%") ??
    //             "";
    //     bool isValidTopic =
    //         RegExp(r'^[a-zA-Z0-9-_.~%]{1,900}$').hasMatch(tempEmail);
    //     logger.d('subscribeTopic:  $isValidTopic $tempEmail');
    //     if (isValidTopic && tempEmail != "") {
    //       try {
    //         logger.i(kDebugMode ? "dev%$tempEmail" : tempEmail);
    //         if (kDebugMode) {
    //           FirebaseMessaging.instance.subscribeToTopic("dev%$tempEmail");
    //         }
    //         FirebaseMessaging.instance
    //             .subscribeToTopic(tempEmail)
    //             .then((value) {
    //           myHelper.saveBoolPref("is_subscribed", true);
    //         });
    //       } catch (e) {
    //         logger.d('saveDataToState:  $e');
    //       }
    //     }
    //   }
    // });
  }

  // timeAgo(String time) {
  //   return timeago.format(DateTime.parse(time));
  // }

  //Get notification:
  Future<String?> getNotificationDate() async {
    try {
      final dateStore = await storage.read(key: "date");
      return dateStore;
    } on PlatformException {
      await storage.deleteAll();
    }
    return null;
  }

  saveNotificationDate(String token) async {
    await storage.write(key: "date", value: token).whenComplete(() {
      // logger.d('saveDate:  date');
    });
  }

  notificationDeleteDate() async {
    await storage.delete(key: "date");
    logger.i("Notification Deleted");
  }

  String timeConverter(String? time, {int? hourToAdd}) {
    if (time == null || time == "") {
      return "";
    }
    DateTime? parsedTime = DateFormat("HH:mm:ss").parse(time);

    if (hourToAdd != null) {
      parsedTime = parsedTime.add(Duration(hours: hourToAdd));
    }
    return DateFormat('hh:mm a').format(parsedTime);
  }

  String englishToBanglaDigit(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], bangla[i]);
    }

    return input;
  }

  String formatDateForField(DateTime selectedDate, {String? dateFormat}) {
    final formatedDate =
        DateFormat(dateFormat ?? 'dd MMM yyyy, EEEE').format(selectedDate);
    return formatedDate;
  }

  parseDateForField(String selectedDate, {String? dateFormat}) {
    final parsedDate =
        DateFormat(dateFormat ?? 'dd MMM yyyy, EEEE').parse(selectedDate);
    return parsedDate;
  }

  setStatusBarWhite() {
    /*
    appHelper.setStatusBarWhite();
    */

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  setStatusBarBlack() {
    /*
    appHelper.setStatusBarBlack();
    */

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  logoutUser() async {
    await appHelper.deleteStringPref("bikeData");
    deleteRefreshToken();
    deleteToken();
  }

  popScopeFunc(
    BuildContext context,
    bool didPop, {
    String? msg,
    bool needOnlyBack = false,
  }) async {
    if (didPop) {
      return;
    }
    final bool shouldPop = await appWidget.appExitConfirmation(
      msg: msg,
      needOnlyBack: needOnlyBack,
    );
    if (Get.context!.mounted && shouldPop) {
      Navigator.pop(Get.context!);
    }
  }

  formatDate(String date, {bool isMonthDateYearFormat = false}) {
    DateTime inputDate = DateTime.parse(date);
    String formattedDate = DateFormat(
            isMonthDateYearFormat ? 'MMM d, y' : 'y-MM-d',
            Get.locale?.languageCode)
        .format(inputDate);
    return formattedDate;
  }
}
