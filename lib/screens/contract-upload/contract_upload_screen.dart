import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marlowe_run/components/loading_screen.dart';
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
      body: BlocBuilder<MarloweCubit, MarloweState>(
        builder: (context, state) {
          bool isJsonLoaded =
              (state.scJSON != null && state.scJSON!.isNotEmpty);
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children: [
                      isJsonLoaded
                          ? contractCreateWidget()
                          : contractUploadWidget()
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        uploadJSONnWidget(),
                        const Divider(
                          color: Colors.black26,
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Enter a contract ID',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          controller: contractIdController,
                          decoration: InputDecoration(
                            hintText: 'Contract ID',
                            helperText: 'Long-press to paste',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () => handleGoToContract(),
                          child: Text('Go To contract'),
                          style: TextButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 256),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget uploadJSONnWidget() {
    return BlocBuilder<MarloweCubit, MarloweState>(builder: (context, state) {
      return BlocBuilder<UploadCubit, UploadState>(
        builder: (uploadContext, uploadState) {
          bool isJsonLoaded =
              (state.scJSON != null && state.scJSON!.isNotEmpty);

          /// OR success because then it doesnt do a quick flash, should fix by showing everything succeeded
          bool isUploading = uploadState.status == UploadStatus.loading ||
              uploadState.status == UploadStatus.success;

          if (uploadState.status == UploadStatus.success) {
            context.go('/details');
          }
          return Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Column(
                children: [
                  Text(
                    isJsonLoaded
                        ? 'Create and deploy your contract'
                        : 'Upload a JSON contract',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Select and upload a contract from your files.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  MarloweSCPicker(),
                  SizedBox(height: 10),
                  isJsonLoaded
                      ? TextButton.icon(
                          style: TextButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () => handleCreateContractFromJSON(
                              scJSON: state.scJSON),
                          label: Text(isUploading
                              ? 'Uploading'
                              : 'Create marlowe Contract'),
                          icon: Icon(Icons.auto_awesome),
                        )
                      : SizedBox(height: 20),
                  SizedBox(height: 20)
                ],
              ),
              uploadState.status == UploadStatus.loading
                  ? FullScreenLoader(message: uploadState.message ?? "")
                  : SizedBox(),
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

//  Delete later
  updateLoadingmessage({required String message}) {
    context.read<UploadCubit>().updateLoadingMessage(message: message);
  }

  contractUploadWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32),
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 100,
                image:
                    AssetImage('assets/images/drive_folder_upload_black.png'),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Upload or enter the contract you want to run',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Text(
            'Once connected, upload or find your thoroughly tested contract, ensure the contract code is final and accurate before doing so as it will be immutable once deployed and run.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  contractCreateWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32),
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 100,
                image: AssetImage('assets/images/vpn_lock_black.png'),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Deploying a contract to the blockchain',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Text(
            'Before deploying your contract there are some things to know:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16.0),
          Text(
            'Security',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Marlowe has gone through countless security checks and is a DSL based on academic peer reviewed papers as well as proofs to validate the secruity of the code used. Marlowe does not and can not account for user error.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16.0),
          Text(
            'Immutability',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Your contract can not be altered once deployed.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16.0),
          Text(
            'Permanence',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Once your contract is deployed to the blockchain there is no turning back, proof of it’s existence will remain forever and your contract will execute to the specifications that have been set.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  handleGoToContract() {
    String contractID = contractIdController.text;
    context.read<UploadCubit>().saveContractId(contractId: contractID);
    context.go('/detail');
  }
}
