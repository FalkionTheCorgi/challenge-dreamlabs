import 'dart:convert';

import 'package:dreamlabs_challenge/database/JsonDataRepository.dart';
import 'package:dreamlabs_challenge/database/data/JsonData.dart';
import 'package:dreamlabs_challenge/list/ListDLRow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ListDLViewModel.dart';

class ListDL extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListDLState();
}

class ListDLState extends ConsumerState<ListDL>{

  late ScrollController scrollController;

  scrollListener() async {
    final model = ref.watch(listDLViewModel);
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await model.fillListLoad(model.list);
    }
  }

  @override
  void initState(){
    final model = ref.read(listDLViewModel);
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    model.getJson();
    super.initState();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final model = ref.watch(listDLViewModel);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: model.listLoad.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : model.listLoad.any((item) => item.title == "")
              ? const Center(
                  child: Text("Itens wasn't detected"),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    model.refreshPage();
                    await model.getJson();
                  },
                  child: ListView.builder(
                      itemCount: model.listLoad.length + 1,
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < model.listLoad.length) {
                          return ListDLRow(
                              id: model.listLoad[index].id,
                              title: model.listLoad[index].title,
                              body: model.listLoad[index].body);
                        } else {
                          if (model.page <= 5) {
                            return circularProgressIndicator(width);
                          }
                        }
                      })),
    );
  }

  Widget circularProgressIndicator(double width) {
    return SizedBox(
      width: width,
      height: 40,
      child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [CircularProgressIndicator()],
          )),
    );
  }


}