import 'package:flutter/material.dart';

class WalletSelectScreen extends StatelessWidget {
  final TextEditingController walletAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Choose a wallet to deploy and run a Marlowe smart contract',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Selecting a wallet is your first step in deploying a smart contract, your choice should be compatible with the blockchain network you want to deploy your contract on',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Choose a wallet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Please input your wallet details',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('Wallet Address'),
              TextField(
                controller: walletAddressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Signing Key'),
              Container(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.purple, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  child: Text('Upload', style: TextStyle(color: Colors.purple)),
                  onPressed: () {
                    // implement your file upload functionality here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Upload Signing Key Pressed')),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  child: Text('Connect wallet'),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
