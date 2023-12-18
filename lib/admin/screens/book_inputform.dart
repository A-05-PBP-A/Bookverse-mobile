import 'package:flutter/material.dart';

class FormInputPage extends StatelessWidget {
  const FormInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Input Form'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300,
            height: 660,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputField('ISBN'),
                _buildInputField('Title'),
                _buildInputField('Author'),
                _buildInputField('Year of publication'),
                _buildInputField('Publisher'),
                _buildInputField('Image URL-S'),
                _buildInputField('Image URL-M'),
                _buildInputField('Image URL-L'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle submit logic (masih harus di integrasi)
                      },
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go back'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}