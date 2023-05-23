import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:marlowe_run/components/filepicker.dart';

import 'marlowe-cubit/marlowe_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarloweCubit, MarloweState>(builder: (context, state) {
      return const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 48,
            ),
            Center(
              child: MarloweSCPicker(),
            ),
            SizedBox(
              height: 48,
            ),
          ],
        ),
      );
    });
  }
}
