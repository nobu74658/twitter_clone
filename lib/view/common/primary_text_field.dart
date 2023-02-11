import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view_model/login_view_model.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.hintText,
    this.controller,
    this.readOnly = false,
    this.isEdit = false,
    this.suffixIcon,
  });

  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool isEdit;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<LoginViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEdit ? Text(hintText ?? "") : const Text(""),
        SizedBox(
          height: 36,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            style: const TextStyle(color: Colors.lightBlue),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black12,
              )),
              hintText: hintText,
            ),
            onChanged: (change) {
              loginViewModel.validation();
              // if (change == "") {
              //   // isEdit = false;
              //   setState(() {
              //     print(widget.controller?.text);
              //   });
              // } else {
              //   isEdit = true;
              //   setState(() {
              //     print(widget.controller?.text);
              // }
              // );
              // }
            },
          ),
        ),
      ],
    );
  }
}
