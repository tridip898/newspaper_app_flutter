import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_assets.dart';
import '../constraints/app_colors.dart';
import '../constraints/app_constraints.dart';
import '../constraints/app_text_style.dart';
import '../utils/helper/app_helper.dart';
import 'dynamic_rich_text.dart';

class AppWidgets {
  final bool needScreenUtil = true;

  Widget gapH(double height) {
    return SizedBox(
      height: needScreenUtil ? height.h : height,
    );
  }

  Widget gapW(double width) {
    return SizedBox(
      width: needScreenUtil ? width.w : width,
    );
  }

  divider({
    double height = 10,
    Color color = AppColors.dividerColor,
    double thickness = 0.5,
  }) {
    return Divider(
      color: color,
      height: needScreenUtil ? height.h : height,
      thickness: thickness,
    );
  }

  showSimpleDialog(
    String title,
    String body,
    retryClick, {
    buttonText = "Try Again",
    isErrorMessageBangla = false,
    barrierDismissible = true,
  }) {
    if (Get.context == null) {
      return null;
    }
    return showDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          // style: textAppBarStyle(),
        ),
        content: Text(
          body,
          // style: textRegularStyle(),
        ),
        actions: <Widget>[
          TextButton(
              child: Text(
                buttonText == "Try Again"
                    ? (isErrorMessageBangla ? "আবার চেষ্টা করুন" : buttonText)
                    : buttonText,
              ),
              onPressed: () {
                Navigator.pop(context);
                if (buttonText != "Ok") {
                  if (buttonText != "ঠিক আছে") {
                    try {
                      retryClick();
                      AppHelper().showLoader();
                    } catch (e) {
                      AppHelper().hideLoader();
                    }
                  }
                }
              })
        ],
      ),
    );
  }

  showSimpleToast(
    String? message, {
    String? title,
    bool isSuccess = false,
    bool doNeedScreenUtil = false,
    bool isInfo = false,
    bool isErrorMessageBangla = false,
    bool isError = true,
    int duration = 3,
  }) {
    Get.snackbar(
      title ??
          (isSuccess
              ? isErrorMessageBangla
                  ? "সফল হয়েছে"
                  : "Success"
              : isInfo
                  ? isErrorMessageBangla
                      ? "তথ্য"
                      : "Info"
                  : isErrorMessageBangla
                      ? "ত্রুটি"
                      : "Error"),
      message ?? "",
      icon: Icon(
        (isSuccess
            ? Icons.check_circle
            : isInfo
                ? Icons.info
                : Icons.error),
        color: AppColors.white,
      ),
      shouldIconPulse: true,
      barBlur: 20,
      overlayBlur: 1,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      backgroundColor: (isSuccess
          ? AppColors.successColor.withValues(alpha: .8)
          : isInfo
              ? AppColors.infoColor.withValues(alpha: .8)
              : AppColors.errorColor.withValues(alpha: .8)),
      margin: EdgeInsets.only(
        top: doNeedScreenUtil ? 20.h : 20,
        left: doNeedScreenUtil ? 20.w : 20,
        right: doNeedScreenUtil ? 20.w : 20,
      ),
      colorText: AppColors.white,
      duration: Duration(seconds: duration),
    );
  }

  Future<bool> appExitConfirmation({
    String? msg,
    bool needOnlyBack = false,
    bool isErrorMessageBangla = false,
    EdgeInsetsGeometry? actionsPadding,
  }) async {
    bool? shouldClose = await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        content: Text(
          msg ??
              (isErrorMessageBangla
                  ? "আপনি কি নিশ্চিত আপনি অ্যাপটি বন্ধ করতে চান?"
                  : 'Are you sure you want to close application?'),
          style: text14Style(),
        ),
        actionsPadding: actionsPadding,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              isErrorMessageBangla ? "না" : 'NO',
              style: text14Style(
                isPrimaryColor: true,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (needOnlyBack) {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              } else {
                SystemNavigator.pop();
              }
            },
            child: Text(
              isErrorMessageBangla ? "হ্যাঁ" : 'YES',
              style: text14Style(
                isPrimaryColor: true,
              ),
            ),
          ),
        ],
      ),
    );

    if ((shouldClose ?? false)) {
      Navigator.pop(Get.context!);
    }

    return false;
  }

  Widget noDataFound({
    String? title,
    String? subTitle,
    String image = notFound,
    bool needTitleTop = false,
  }) {
    return Container(
      padding: mainPadding(20, 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (needTitleTop)
            Text(
              title ?? "",
              style: text18Style(
                isWeight700: true,
              ),
            ),
          if (needTitleTop) gapH20,
          Stack(
            children: [
              Image.asset(
                image,
                width: Get.width * 0.7,
              ),
              !needTitleTop
                  ? Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Oops!",
                            style: text18Style(color: AppColors.liteTextColor),
                          )))
                  : Container(),
            ],
          ),
          gapH16,
          if (!needTitleTop)
            Text(
              title ?? "",
              style: text14Style(
                fontSize: 13,
                isWeight400: true,
              ),
            ),
          gapH6,
          Text(
            subTitle ?? "",
            style:
                text12Style(isWeight400: true, color: AppColors.liteTextColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Widget noData({msg = "No data found", color = Colors.redAccent}) {
//   return Center(
//     child: Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: mainPaddingH,
//         horizontal: mainPaddingW,
//       ),
//       child: Text(
//         msg,
//         style: textAppBarStyle(color: color, fontSize: 25),
//         textAlign: TextAlign.center,
//       ),
//     ),
//   );
// }

  showCongratulateDialog() {
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 47),
              child: Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: mainPadding(27, 27),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        successIcons,
                        height: 72.w,
                        width: 72.w,
                      ),
                      gapH8,
                      Text(
                        "Congratulation",
                        style: text18Style(
                            isWeight500: true, isPrimaryColor: true),
                      ),
                      gapH6,
                      Text(
                        "Your account has been created successfully",
                        style: text14Style(
                          isWeight500: true,
                          color: AppColors.liteTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      gapH6,
                      DynamicRichText(
                        textParts: [
                          TextPart(
                            text: 'Welcome to ',
                            style: text16Style(
                              color: AppColors.liteTextColor,
                              isWeight600: true,
                            ),
                          ),
                          TextPart(
                            text: 'SUZUKI ',
                            style: text16Style(
                              isSuzukiProBold: true,
                              isPrimaryColor: true,
                              isWeight800: true,
                            ),
                          ),
                          TextPart(
                            text: 'App',
                            style: text16Style(
                              color: AppColors.liteTextColor,
                              isWeight600: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<DateTime?> datePickerMain(
      {bool canPickFutureDate = true,
      bool canPickFirstDate = false,
      required DateTime initialDate,
      //Todo Need to work here
      DateTime? firstDate}) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: canPickFirstDate
          ? (initialDate.isBefore(firstDate ?? DateTime.now())
              ? firstDate
              : initialDate)
          : initialDate,
      firstDate: canPickFirstDate
          ? (firstDate ?? DateTime.now())
          : DateTime.now().subtract(const Duration(days: 365)),
      lastDate: canPickFutureDate
          ? DateTime.now().add(const Duration(days: 365))
          : DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius here
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      initialDate = pickedDate;
      return initialDate;
      /*  logger.i("Before format $pickedDate");
      String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
      logger.i("After format $formattedDate");
      return formattedDate;*/
    }
    return null;
  }

  Widget addNewBikeButton({String? title, Function()? onTap}) {
    return Material(
      borderRadius: mainBorderRadius(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.r),
        onTap: onTap,
        child: Ink(
          padding: mainPadding(7, 6),
          decoration: BoxDecoration(
            borderRadius: mainBorderRadius(6),
            color: Color.fromRGBO(0, 54, 143, 1),
          ),
          child: Row(
            children: [
              Image.asset(
                addIcon,
                width: 20.w,
                height: 20.h,
              ),
              gapW6,
              Text(
                title ?? "",
                style: text12Style(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  isWeight500: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  errorDialog() {
    return showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0.1, 0.85],
                colors: [AppColors.backgroundColor, AppColors.backgroundColor],
              ),
            ),
            child: AlertDialog(
              backgroundColor: AppColors.white,
              title: Text(
                'Error',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    notFound,
                    width: Get.width * 0.7,
                  ),

                  // Lottie.asset(
                  //   'assets/lottie/no_internet.json',
                  //   width: 200,
                  //   height: 200,
                  // ),
                  gapH16,
                  Text(
                    'Something went wrong. Please try again later.',
                    textAlign: TextAlign.center,
                    style: text16Style(
                      color: AppColors.grey,
                    ),
                  ),
                  gapH32,

                  ActionChip(
                    label: Text("Back"),
                    onPressed: () => Get.back(),
                  )
                ],
              ),
            ),
          );
        });
  }

  showComingSoon() {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: 1),
      content: Animate(
        effects: [
          FadeEffect(duration: 400.ms),
          ScaleEffect(duration: 300.ms),
        ],
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("Coming Soon ...", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  verifiedOrNotWidget(String imagePath, Function()? onTap) {
    return Positioned(
      top: 30.h,
      right: 8.w,
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          "",
          height: 26.h,
          width: 76.w,
        ),
      ),
    );
  }
}
