import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view_model/sign_in_up_view_model.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.hintText,
    this.controller,
    this.readOnly = false,
    this.isEdit = false,
    this.suffixIcon,
    this.isMultiLine = false,
    this.maxLines = 1,
    this.height = 36,
    this.isObscure = false,
  });

  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool isEdit;
  final Widget? suffixIcon;
  final bool? isMultiLine;
  final int? maxLines;
  final double? height;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<SignInUpViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEdit ? Text(hintText ?? "") : const Text(""),
        SizedBox(
          height: height,
          child: TextFormField(
            obscureText: isObscure,
            maxLines: maxLines,
            controller: controller,
            readOnly: readOnly,
            keyboardType: isMultiLine == true ? TextInputType.multiline : null,
            style: const TextStyle(color: Colors.lightBlue),
            decoration: InputDecoration(
              border: isMultiLine == true ? const OutlineInputBorder() : null,
              suffixIcon: suffixIcon,
              focusColor: isMultiLine == true ? Colors.grey : null,
              focusedBorder: isMultiLine == true
                  ? OutlineInputBorder()
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.black12,
                    )),
              hintText: hintText,
            ),
            onChanged: (change) {
              loginViewModel.validation();
            },
          ),
        ),
      ],
    );
  }
}
