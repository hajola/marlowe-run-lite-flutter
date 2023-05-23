import 'package:flutter/material.dart';

class ContractDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contract Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
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
            Expanded(
              // <-- Add this
              child: SingleChildScrollView(
                // <-- Wrap this
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.fingerprint),
                      title: Text('ContractId'),
                      subtitle: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Creator'),
                      subtitle: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                            double.infinity, 50), // Button width and height
                      ),
                      onPressed: () {},
                      child: const Text('Go to set terms'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
