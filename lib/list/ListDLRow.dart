import 'package:dreamlabs_challenge/descricao/DescricaoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDLRow extends ConsumerStatefulWidget {
  final int id;
  final String title;
  final String body;

  const ListDLRow(
      {super.key, required this.id, required this.title, required this.body});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListDLRowState();
}

class ListDLRowState extends ConsumerState<ListDLRow> {
  bool showCard = false;

  void toggleExpand() {
    setState(() {
      showCard = !showCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return DescricaoCard(title: widget.title, body: widget.body);
              });
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [Text("Title: ${widget.title}")],
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 400),
                    child: showCard
                        ? showCardAnimation()
                        : Column(mainAxisSize: MainAxisSize.min, children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    Text(widget.body.length > 100
                                        ? "${widget.body.substring(0, 100)}..."
                                        : widget.body)
                                  ],
                                )),
                          ])),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        toggleExpand();
                      },
                      child: Icon(
                          showCard ? Icons.expand_less : Icons.expand_more),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget showCardAnimation() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            children: [Text(widget.body)],
          )),
    ]);
  }
}
