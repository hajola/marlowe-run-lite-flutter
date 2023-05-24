import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marlowe_run/components/skey_filepicker.dart';
import '../../marlowe-cubit/marlowe_cubit.dart';

class WalletSelectScreen extends StatelessWidget {
  final TextEditingController walletAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                            'assets/images/marlowe-logo-primary-black-purple.png'),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Choose a wallet to deploy and run a Marlowe smart contract',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Selecting a wallet is your first step in deploying a smart contract, your choice should be compatible with the blockchain network you want to deploy your contract on',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      Text(
                        'Choose a wallet',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Please input your wallet details',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text('Wallet Address'),
                      TextField(
                        controller: walletAddressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text('Signing Key'),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: const SkeyFilePicker(),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          child: Text('Connect wallet'),
                          onPressed: () {
                            context.read<MarloweCubit>().storeWalletAddress(
                                walletAddressController.text);
                            context.go('/upload');
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text('Learn more'),
                            onPressed: () {},
                          ),
                          Text('I don\'t have a wallet'),
                        ],
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
