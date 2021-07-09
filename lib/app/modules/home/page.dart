import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edocman_demo/app/modules/home/controller.dart';
import 'package:edocman_demo/widgets/error_dialog.dart';
import 'package:edocman_demo/widgets/request_totp_dialog.dart';
import 'package:edocman_demo/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final _ = controller;

    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(hintText: "name"),
                  ),
                  TextField(
                    controller: controller.applicationIdController,
                    decoration: InputDecoration(hintText: "applicationId"),
                  ),
                  TextField(
                    controller: controller.logoController,
                    decoration: InputDecoration(hintText: "logo"),
                  ),
                  TextField(
                    controller: controller.userNameController,
                    decoration: InputDecoration(hintText: "userName"),
                  ),
                  TextField(
                    controller: controller.secretController,
                    decoration: InputDecoration(hintText: "secretKey"),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _.nameController.text = _.faker.company.name();
                        controller.applicationIdController.text =
                            _.faker.internet.domainName();
                        controller.userNameController.text =
                            _.faker.phoneNumber.us();
                        controller.logoController.text =
                            "https://ipsicon.io/${_.faker.guid.guid()}.png";
                        controller.secretController.text = _.faker.guid.guid();
                      },
                      child: Text("Tự động tạo")),
                  ElevatedButton(
                    onPressed: () {
                      final name = _.nameController.text;
                      final applicationId = _.applicationIdController.text;
                      final userName = _.userNameController.text;
                      final secretText = _.secretController.text;
                      final data = base64Encode(utf8.encode(jsonEncode({
                        "name": name,
                        "applicationId": applicationId,
                        "userName": userName,
                        "secretKey": secretText,
                        "logo": _.logoController.text
                      })));
                      launch("totp://totp.com/registerTotp?data=$data");
                    },
                    child: Text("Kết nối với CMC Authenticator"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final secretText = _.secretController.text;
                      final secretKey = secretText;
                      final otp = await Get.dialog(TOTPInputDialog(
                        label: "Nhập TOTP",
                      ));
                      if (otp == null) {
                        return;
                      }
                      var response = await Dio().post(
                          'http://183.91.3.60:50010/api/totp/verify-totp',
                          data: {'secretKey': secretKey, 'otp': otp});
                      final okTotp = response.data["data"] as bool;
                      if (okTotp) {
                        Get.dialog(
                          SuccessDialog(
                            title: "Xác thực TOTP",
                            descriptions: "Xác thực TOTP thành công.",
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
                    },
                    child: Text("Yêu cầu TOTP"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final applicationId = _.applicationIdController.text;
                      final userName = _.userNameController.text;
                      final data = base64Encode(utf8.encode(jsonEncode({
                        "applicationId": applicationId,
                        "userName": userName,
                        "deeplinkCallback": "edocman://edocman.vn?totp="
                      })));
                      launch("totp://totp.com/requestTotp?data=$data");
                    },
                    child: Text("Yêu cầu TOTP 2"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
