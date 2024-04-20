import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String? value;
  final Color? color;
  final double? fontSize;
  final MainAxisAlignment? mainAxisAlignment;
  const CustomRow(
      {required this.title,
      this.value,
      this.color=Colors.white,
      this.fontSize,
      super.key,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          title,style: const TextStyle(fontSize: 12,color: Colors.white),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value ?? "",
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        )
      ],
    );
  }
}

class CustomRowExtended extends StatelessWidget {
  final String title;
  final String? value;
  final Color? color;
  const CustomRowExtended(
      {super.key, required this.title, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
        ),
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            value ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color??Colors.black,
            ),
          ),
        )
      ],
    );
  }
}

class SimpleRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  const SimpleRow(
      {super.key,
      this.children = const <Widget>[],
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}
