import 'package:flutter/material.dart';

class MyFx {
  static Widget textfield(String title, TextEditingController controller,
          {bool? obscureText,
          Widget? suffix,
          bool? mandatory,
          bool readOnly = false,
          bool autofocus = false,
          void Function(String)? onChanged,
          TextInputType? keyboardType,
          String? Function(String?)? validator}) =>
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title${(mandatory ?? false) ? " *" : ""}"),
            TextFormField(
              autofocus: autofocus,
              readOnly: readOnly,
              keyboardType: keyboardType,
              validator: validator,
              obscureText: obscureText ?? false,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                suffix: suffix,
                hintText: 'Masukkan $title',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      );
  static Container button(void Function()? onTap, String title,
          {Color color = Colors.blue}) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  // function untuk men simple kan future builder
  static FutureBuilder<T> future<T>({
    required Future<T>? future,
    required Widget Function(BuildContext context, T? data) builder,
    Widget Function(BuildContext context, T? data)? failedBuilder,
  }) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting &&
            snapshot.data != null) {
          return builder(context, snapshot.data);
        } else {
          return failedBuilder != null
              ? failedBuilder(context, snapshot.data)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }
      },
    );
  }
}
