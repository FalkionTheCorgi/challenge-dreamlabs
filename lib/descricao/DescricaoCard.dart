import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescricaoCard extends ConsumerStatefulWidget {

  String title;
  String body;

  DescricaoCard({super.key,
    required this.title,
    required this.body
  });
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DescricaoCardState();
}



class DescricaoCardState extends ConsumerState<DescricaoCard>{

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ),
          const SizedBox(height: 16),
          Align(
              alignment: Alignment.topLeft,
              child: Text(widget.body),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'FECHAR',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }




}