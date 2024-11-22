import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/app_colors.dart';

class ModalSheet {
  static void showModal(context, List items,String? key, final ValueChanged<String> update,
      final ValueChanged<int> indexselct,
      [String? selValue]) {
    String? val;
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        // useSafeArea: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //  Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // Icon(
                    //   Icons.remove,
                    //   color: Colors.grey[600],
                    //   size: 40,
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      items[index][key],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15),
                                    ),
                                    if ( items[index][key] == selValue)
                                      Icon(CupertinoIcons.checkmark,
                                          size: 24, color: Colors.blue)
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       border: Border.all(
                                    //         color: Theme.of(context)
                                    //             .canvasColor,
                                    //       )),
                                    //       alignment: Alignment.center,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(2),
                                    //     child: Icon(Icons.circle,
                                    //         size: 10,
                                    //         color: Colors.blue),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              onTap: () {
                                // Get.find<AccountSetUpController>()
                                //     .setAccountValue(items[index]);
                                //    _controller.accountType.value =  TextEditingController(text: _items[index]);
                                indexselct(index);
                                update( items[index][key]);
                                Navigator.pop(context);
                              });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              ));
        });
  }
 
}
