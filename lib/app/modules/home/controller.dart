import 'dart:async';

import 'package:dio/dio.dart';
import 'package:edocman_demo/widgets/error_dialog.dart';
import 'package:edocman_demo/widgets/success_dialog.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import 'package:base32/base32.dart';

class HomeController extends GetxController {
  final nameController = TextEditingController();
  final applicationIdController = TextEditingController();
  final logoController = TextEditingController();
  final userNameController = TextEditingController();
  final secretController = TextEditingController();
  final faker = new Faker();
  late StreamSubscription _sub;

  @override
  void onInit() {
    super.onInit();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      _sub = linkStream.listen((String? link) {
        if (link == null) return;
        parseLink(link);
      }, onError: (err) {});
      if (initialLink == null) return;
      parseLink(initialLink);
    } catch (e) {
      print(e);
    }
  }

  parseLink(String link) async {
    final uri = Uri.tryParse(link);
    if (uri == null) {
      return;
    }
    if (uri.scheme != "edocman") {
      return;
    }

    if (uri.host != "edocman.vn") {
      return;
    }
    final totp = uri.queryParameters["totp"];
    final secretText = secretController.text;
    final secretKey = secretText;
    var response = await Dio().post(
        'http://183.91.3.60:50010/api/totp/verify-totp',
        data: {'secretKey': secretKey, 'otp': totp});
    final okTotp = response.data["data"] as bool;
    if (okTotp) {
      Get.dialog(
        SuccessDialog(
          title: "Xác thực TOTP",
          descriptions: "Xác thực TOTP ${totp} thành công.",
          text: "Ok",
        ),
      );
    } else {
      Get.dialog(
        ErrorDialog(
          title: "Xác thực TOTP",
          descriptions: "Xác thực TOTP không thành công.",
          text: "Ok",
        ),
      );
    }
  }

  @override
  void onClose() {
    _sub.cancel();
    nameController.dispose();
    applicationIdController.dispose();
    logoController.dispose();
    userNameController.dispose();
    secretController.dispose();
    super.onClose();
  }
}
