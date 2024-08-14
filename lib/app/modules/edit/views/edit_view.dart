import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';

import '../../../data/fetch_data.dart';
import '../../../data/function.dart';
import '../../../data/test_model.dart';
import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  const EditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value.toUpperCase())),
        centerTitle: true,
      ),
      floatingActionButton: Obx(
        () => controller.isEdit.value
            ? FloatingActionButton(
                onPressed: () async {
                  final cek = controller.form.currentState!.validate();
                  if (cek) {
                    final data = TestModel(
                      body: controller.bodyController.text,
                      title: controller.titleController.text,
                      userId: int.parse(
                        controller.userIdController.text,
                      ),
                    );
                    final post = await API.updatePost(
                      int.parse(controller.id),
                      data: data,
                    );
                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                    String prettyprint = encoder.convert(post.toJson());
                    Get.defaultDialog(
                      title: 'Success',
                      content: Text(prettyprint),
                    );
                  }
                },
                child: const SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.send,
                  ),
                ),
              )
            : FloatingActionButton(
                onPressed: () => controller.isEdit.value = true,
                child: const SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.update,
                  ),
                ),
              ),
      ),
      body: Form(
        key: controller.form,
        child: Obx(() {
          return ListView(
            children: [
              MyFx.textfield(
                'User ID',
                autofocus: controller.isEdit.value,
                readOnly: !controller.isEdit.value,
                controller.userIdController,
                keyboardType: TextInputType.number,
                validator:
                    ValidationBuilder(requiredMessage: "Wajib Diisi").build(),
              ),
              MyFx.textfield(
                'Title',
                controller.titleController,
                readOnly: !controller.isEdit.value,
                validator:
                    ValidationBuilder(requiredMessage: "Wajib Diisi").build(),
              ),
              MyFx.textfield(
                'Body',
                controller.bodyController,
                readOnly: !controller.isEdit.value,
                validator:
                    ValidationBuilder(requiredMessage: "Wajib Diisi").build(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
