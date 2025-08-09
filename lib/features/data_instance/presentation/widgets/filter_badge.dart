import 'package:flutter/material.dart';

class FilterBadge extends StatelessWidget {
  const FilterBadge({Key? key, this.count = 0, this.onTap}) : super(key: key);
  final int count;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    // if (count == 0) return const SizedBox.shrink();
    // Show number of active filters from ViewModel
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.filter_list, size: 30,),
          ),
          if (count > 0)  Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(count.toString(),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
