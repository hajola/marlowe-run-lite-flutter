import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../marlowe-cubit/marlowe_cubit.dart';

class MarloweSCPicker extends StatefulWidget {
  const MarloweSCPicker({super.key});

  @override
  State<MarloweSCPicker> createState() => _MarloweSCPickerState();
}

class _MarloweSCPickerState extends State<MarloweSCPicker> {
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
          return TextButton.icon(
            icon: const Icon(Icons.file_upload),
            label: const Text('Upload Contract'),
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
                    'Change SC',
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
        dialogTitle: 'Pick a Marlowe Smart Contract',
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

    String marloweSCJSON = '';
    final file = File(_file!.path.toString());
    Stream<String> lines = file
        .openRead()
        .transform(utf8.decoder) // Decode bytes to UTF-8.
        .transform(const LineSplitter()); // Convert stream to individual lines.
    try {
      await for (var line in lines) {
        marloweSCJSON += line;
      }
      logger.i('File is now closed.');
    } catch (e) {
      logger.e('Error: $e');
    }

    context.read<MarloweCubit>().loadscJSON(marloweSCJSON, _file!.name);
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
