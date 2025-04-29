import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newspaper_app_flutter/app/core/constraints/app_constraints.dart';
import 'package:newspaper_app_flutter/app/routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user.bindStream(auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user != null) {
      fetchUserData();
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCred.user!.updateDisplayName(name);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({
        'uid': userCred.user!.uid,
        'email': email,
        'name': name,
      });

      Get.back();
      appWidget.showSimpleToast("Account created successfully",
          isSuccess: true, duration: 1);
    } catch (e) {
      logger.i(e.toString());
      appWidget.showSimpleToast(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(Routes.HOME);
      appWidget.showSimpleToast("Logged in successfully",
          isSuccess: true, duration: 1);
    } catch (e) {
      appWidget.showSimpleToast(e.toString());
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> fetchUserData() async {
    if (auth.currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        userData.value = userDoc.data()!;
      }
    }
  }
}
