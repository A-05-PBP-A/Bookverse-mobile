import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>[
  'Classical Mythology',
  'Clara Callan',
  'Decision in Normandy',
  'The Mummies of Urumchi'
];

void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Center(
          child: DropdownTitle(),
        ),
      ),
    );
  }
}

class DropdownTitle extends StatefulWidget {
  const DropdownTitle({super.key});

  @override
  State<DropdownTitle> createState() => _DropdownTitleState();
}

class _DropdownTitleState extends State<DropdownTitle> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    ));
  }
}
