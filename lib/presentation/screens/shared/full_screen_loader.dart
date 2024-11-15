import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading Movies',
      'buying popcorns',
      'Loading Popular movies',
      'Calling my girlfriend',
      'this is taking longer than I expected',
    ];

    return Stream.periodic(
      const Duration(milliseconds: 1200),
      (step) {
        return messages[step];
      },
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please wait '),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
