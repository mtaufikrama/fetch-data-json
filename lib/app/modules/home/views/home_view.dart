import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:test_pkp/app/data/fetch_data.dart';
import 'package:test_pkp/app/data/function.dart';
import 'package:test_pkp/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soal PKP'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CREATE),
        child: const SizedBox(
          height: 50,
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      body: MyFx.future(
        future: API.listPost,
        builder: (context, listData) {
          return ListView.builder(
            itemCount: listData!.length,
            itemBuilder: (context, index) {
              final data = listData[index];
              return Slidable(
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  dragDismissible: false,
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        final post = await API.deletePost(
                          data.id ?? 0,
                        );
                        JsonEncoder encoder =
                            const JsonEncoder.withIndent('  ');
                        String prettyprint = encoder.convert(post);
                        Get.defaultDialog(
                          title: 'Success',
                          content: Text(prettyprint),
                        );
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () => Get.toNamed(Routes.EDIT(data.id ?? 0)),
                  title: Text(data.title ?? ''),
                  subtitle: Text(data.body ?? ''),
                  trailing: CircleAvatar(
                    child: Text(
                      (data.userId ?? 0).toString(),
                    ),
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      (data.id ?? 0).toString(),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
