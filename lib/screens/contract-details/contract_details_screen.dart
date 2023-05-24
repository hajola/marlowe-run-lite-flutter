import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marlowe_run/components/loading_screen.dart';
import 'package:marlowe_run/upload-cubit/upload_cubit.dart';

class ContractDetailsScreen extends StatefulWidget {
  @override
  State<ContractDetailsScreen> createState() => _ContractDetailsScreenState();
}

class _ContractDetailsScreenState extends State<ContractDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UploadCubit>().getContractDetails();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<UploadCubit, UploadState>(
        builder: (uploadContext, uploadState) {
          if (uploadState.status == UploadStatus.loading) {
            String message = uploadState.message ?? "";
            return FullScreenLoader(
              message: message,
            );
          } else if (uploadState.resource == null) {
            String message = 'ERROR';
            return FullScreenLoader(
              message: message,
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      child: Column(
                        children: [
                          SizedBox(height: 64),
                          const Image(
                            width: 200,
                            image: AssetImage(
                                'assets/images/find_in_page_black.png'),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'Review your contract details',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32),
                          Text(
                            'Review your contract details before setting the terms to run it. Check the code and all details, this is your last chance to correct any errors before the contract is permanently live.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    )),
                Container(
                  height: 1000,
                  color: Colors.white,
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Details'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Code'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.fingerprint),
                              title: Text('ContractId'),
                              subtitle:
                                  Text(uploadState.resource['contractId']),
                            ),
                            ListTile(
                              leading: Icon(Icons.done),
                              title: Text('Status'),
                              subtitle: Text(uploadState.resource['status']),
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Creator'),
                              subtitle: Text(
                                "Unsure where to find this",
                                style: TextStyle(color: Colors.black26),
                              ),
                            ),
                            const ListTile(
                              leading: Icon(Icons.list_alt),
                              title: Text('Transaction Id'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.book),
                              title: Text('Script Address'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.list),
                              title: Text('Epoch/Slot'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.grid_view),
                              title: Text('Block'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.grid_view),
                              title: Text('Block Hash'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.watch),
                              title: Text('Timestamp'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.menu),
                              title: Text('metadata'),
                              subtitle: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                              onPressed: () {
                                context.go('/run');
                              },
                              child: const Text('Go to set terms'),
                            ),
                          ],
                        ),
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
}
