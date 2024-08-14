import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_pkp/app/data/fetch_data.dart';

class EditController extends GetxController {
  //TODO: Implement EditController

  final isEdit = false.obs;
  final id = Get.parameters['id'] ?? '0';
  final title = ''.obs;
  final form = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final userIdController = TextEditingController();
  @override
  void onInit() async {
    final data = await API.getPost(int.parse(id));
    titleController.text = data.title ?? '';
    bodyController.text = data.body ?? '';
    userIdController.text = (data.userId ?? 0).toString();
    title.value = data.title ?? '';
    super.onInit();
  }
}
