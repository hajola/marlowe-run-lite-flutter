import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../marlowe-cubit/marlowe_cubit.dart';

class SkeyFilePicker extends StatefulWidget {
  const SkeyFilePicker({super.key});

  @override
  State<SkeyFilePicker> createState() => _SkeyFilePickerState();
}

class _SkeyFilePickerState extends State<SkeyFilePicker> {
  String? _fileName;
  PlatformFile? _file;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  FileType _pickingType = FileType.custom;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarloweCubit, MarloweState>(
      builder: (context, state) {
        if (state.status == MarloweStatus.unloaded) {
          return TextButton(
            style: TextButton.styleFrom(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            child: Text('Upload',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            onPressed: () => _pickFiles(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  'Uploaded: ${state.fileName}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.file_upload),
                  label: const Text(
                    'Change Skey',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => _pickFiles(),
                )
              ],
            ),
          );
        }
      },
    );
  }

  void _pickFiles() async {
    _resetState();
    try {
      _file = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => logger.i(status),
        allowedExtensions: ['json'],
        dialogTitle: 'Pick a Skey file',
        lockParentWindow: _lockParentWindow,
      ))
          ?.files[0];
    } on PlatformException catch (e) {
      logger.e('Unsupported operation$e');
    } catch (e) {
      logger.e(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _file != null ? _file.toString() : '...';
      _userAborted = _file == null;
    });

    final file = File(_file!.path.toString());

    context.read<MarloweCubit>().storeSkeyFile(_file!);
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _fileName = null;
      _file = null;
      _userAborted = false;
    });
  }
}
