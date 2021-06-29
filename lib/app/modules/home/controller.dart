import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final nameController = TextEditingController();
  final applicationIdController = TextEditingController();
  final logoController = TextEditingController();
  final userNameController = TextEditingController();
  final secretController = TextEditingController();
  final faker = new Faker();

  @override
  void onClose() {
    nameController.dispose();
    applicationIdController.dispose();
    logoController.dispose();
    userNameController.dispose();
    secretController.dispose();
    super.onClose();
  }
}
