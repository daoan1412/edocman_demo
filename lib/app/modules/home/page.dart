import 'dart:convert';

import 'package:edocman_demo/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:base32/base32.dart';

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
                      final secretKey = base32.encodeString(secretText);
                      final data = base64Encode(utf8.encode(jsonEncode({
                        "name": name,
                        "applicationId": applicationId,
                        "userName": userName,
                        "secretKey": secretKey,
                        "logo": _.logoController.text
                      })));
                      launch("mygovvn://mygov.vn/registerTotp?data=$data");
                    },
                    child: Text("Kết nối với myGovVN"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("yêu cầu OTP");
                    },
                    child: Text("Yêu cầu TOTP"),
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
