import 'package:flutter/material.dart';

class DrawerTitleWidget extends StatelessWidget {
  const DrawerTitleWidget({Key? key, this.callback}) : super(key: key);

  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              callback!();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
