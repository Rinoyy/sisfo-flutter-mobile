import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];
  final List<int> colorCodes = <int>[600, 500, 100, 200];

  
   @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: 400,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/tb.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: const Color(0x484488B7),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: const Text(
                            'Semua',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF485777),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Alat Tulis"),
                  const SizedBox(width: 8),
                  const Text("Elektronik"),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                color: Colors.amber[colorCodes[index % colorCodes.length]],
                child: Center(child: Text('Entry ${entries[index % entries.length]}')),
              );
            },
          ),
        ),
      ],
    ),
  );
}

}

















// Card(
                    //   elevation: 4,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Container(
                    //     width: 180,
                    //     height: 220,
                    //     padding: const EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white,
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child: Image.asset(
                    //             'assets/images/tb.png',
                    //             height: 100,
                    //             width: double.infinity,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //         const Text(
                    //           'Infocus',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 16),
                    //         ),
                    //         const Text(
                    //           'IN-001',
                    //           style: TextStyle(
                    //             color: Colors.grey,
                    //           ),
                    //         ),
                    //         const Text(
                    //           'Elektronik',
                    //           style: TextStyle(
                    //             color: Colors.grey,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Card(
                    //   elevation: 4,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Container(
                    //     width: 180,
                    //     height: 220,
                    //     padding: const EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white,
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child: Image.asset(
                    //             'assets/images/tb.png',
                    //             height: 100,
                    //             width: double.infinity,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //         const Text(
                    //           'Infocus',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 16),
                    //         ),
                    //         const Text(
                    //           'IN-001',
                    //           style: TextStyle(
                    //             color: Colors.grey,
                    //           ),
                    //         ),
                    //         const Text(
                    //           'Elektronik',
                    //           style: TextStyle(
                    //             color: Colors.grey,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),