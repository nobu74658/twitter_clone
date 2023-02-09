import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({super.key, this.hintText, this.controller});

  final String? hintText;
  final TextEditingController? controller;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

bool isEdit = false;

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEdit ? Text(widget.hintText ?? "") : Text(""),
        SizedBox(
          height: 36,
          child: TextFormField(
            style: const TextStyle(color: Colors.lightBlue),
            decoration: InputDecoration(
              suffixIcon: Image.asset(
                "assets/images/verified.png",
                scale: 20,
                color: Colors.green,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black12,
              )),
              hintText: widget.hintText,
            ),
            onChanged: (change) {
              if (change == "") {
                isEdit = false;
                setState(() {});
              } else {
                isEdit = true;
                setState(() {});
              }
            },
          ),
        ),
      ],
    );
  }
}
