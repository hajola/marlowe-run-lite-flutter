import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marlowe_run/upload-cubit/upload_cubit.dart';

import '../../components/filepicker.dart';
import '../../marlowe-cubit/marlowe_cubit.dart';

class ContractUploadScreen extends StatefulWidget {
  ContractUploadScreen({super.key});

  @override
  State<ContractUploadScreen> createState() => _ContractUploadScreenState();
}

class _ContractUploadScreenState extends State<ContractUploadScreen> {
  final TextEditingController contractIdController = TextEditingController();

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
      return BlocBuilder<UploadCubit, UploadState>(
        builder: (uploadContext, uploadState) {
          bool isJsonLoaded =
              (state.scJSON != null && state.scJSON!.isNotEmpty);

          bool isUploading = uploadState.status == UploadStatus.loading;

          if (uploadState.status == UploadStatus.success) {
            context.go('/details');
          }
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
                      onPressed: () =>
                          handleCreateContractFromJSON(scJSON: state.scJSON),
                      label: Text(isUploading
                          ? 'Uploading'
                          : 'Create marlowe Contract'),
                      icon: Icon(Icons.auto_awesome),
                    )
                  : SizedBox(height: 20),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () => {context.go('/details')},
                  child: Text('test button'))
            ],
          );
        },
      );
    });
  }

  handleCreateContractFromJSON({required String? scJSON}) {
    if (scJSON == null) throw Exception('SC JSON is null');
    String address =
        "addr_test1vp28qhdavped0rwr24ww8fmstr727a5ln7vrshlvq7cl3zgn0uaxs";
    context
        .read<UploadCubit>()
        .createContract(scJSON: scJSON, address: address);
  }
}
