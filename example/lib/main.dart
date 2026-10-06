import 'package:flutter/material.dart';
import 'package:indian_input_formatter/indian_input_formatter.dart';

void main() {
  runApp(const MyApp());
}

/// The example application demonstrating `indian_input_formatter`.
class MyApp extends StatelessWidget {
  /// Creates the [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indian Input Formatter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const FormatterDemoPage(),
    );
  }
}

/// A demo page demonstrating all Indian formatters and validators.
class FormatterDemoPage extends StatefulWidget {
  /// Creates the [FormatterDemoPage].
  const FormatterDemoPage({super.key});

  @override
  State<FormatterDemoPage> createState() => _FormatterDemoPageState();
}

class _FormatterDemoPageState extends State<FormatterDemoPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indian Input Formatter Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Preconfigured IndianTextFormField Fields',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.aadhaar,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.pan,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.gstin,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.ifsc,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.pincode,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.upi,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              const IndianTextFormField(
                type: IndianFieldType.currency,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  final valid = _formKey.currentState?.validate() ?? false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        valid
                            ? 'All fields are valid!'
                            : 'Please fix validation errors',
                      ),
                      backgroundColor: valid ? Colors.green : Colors.red,
                    ),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Validate Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
