import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/filepicker.dart';
import '../../marlowe-cubit/marlowe_cubit.dart';

class ContractUploadScreen extends StatelessWidget {
  final TextEditingController contractIdController = TextEditingController();

  ContractUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 32.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                uploadJSONnWidget(),
                const Divider(),
                const SizedBox(height: 40),
                const Text(
                  'Enter a contract ID',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextField(controller: contractIdController),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => {},
                  child: Text('Go To contract'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadJSONnWidget() {
    return BlocBuilder<MarloweCubit, MarloweState>(builder: (context, state) {
      bool isJsonLoaded = (state.scJSON != null && state.scJSON!.isNotEmpty);
      return Column(
        children: [
          const Text(
            'Upload a JSON contract',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Select and upload a contract from your files.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          MarloweSCPicker(),
          SizedBox(height: 10),
          isJsonLoaded
              ? TextButton.icon(
                  onPressed: () => {},
                  label: Text('Create marlowe Contract'),
                  icon: Icon(Icons.auto_awesome),
                )
              : SizedBox(height: 20),
          SizedBox(height: 20),
        ],
      );
    });
  }
}
