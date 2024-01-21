import 'package:abstract_curiousity/Features/Posts/_components/ModalSheet.dart';
import 'package:flutter/material.dart';

class OptionsMenu extends StatelessWidget {
  const OptionsMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return const ModalSheet();
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(
          Icons.more_vert,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
