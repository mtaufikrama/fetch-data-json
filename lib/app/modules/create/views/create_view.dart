import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:test_pkp/app/data/fetch_data.dart';
import 'package:test_pkp/app/data/function.dart';
import 'package:test_pkp/app/data/test_model.dart';

import '../controllers/create_controller.dart';

class CreateView extends GetView<CreateController> {
  const CreateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
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
            final post = await API.postPost(data: data);
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
      ),
      body: Form(
        key: controller.form,
        child: ListView(
          children: [
            MyFx.textfield(
              'User ID',
              controller.userIdController,
              keyboardType: TextInputType.number,
              validator:
                  ValidationBuilder(requiredMessage: "Wajib Diisi").build(),
            ),
            MyFx.textfield(
              'Title',
              controller.titleController,
              validator:
                  ValidationBuilder(requiredMessage: "Wajib Diisi").build(),
            ),
            MyFx.textfield(
              'Body',
              controller.bodyController,
              validator:
                  ValidationBuilder(requiredMessage: "Wajib Diisi").build(),
            ),
          ],
        ),
      ),
    );
  }
}
