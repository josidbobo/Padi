import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final TextEditingController controller;
  final String text;

  const TextView({Key? key, required this.text, required this.controller,})
      : super(key: key);

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: widget.text,
            hintStyle: const TextStyle(fontSize: 15, color: Colors.white),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white),
            ),
            ),
        autocorrect: true,
        controller: widget.controller,
        showCursor: true,
        cursorWidth: 1,
        cursorColor: Colors.white,
      ),
    );
  }
}
