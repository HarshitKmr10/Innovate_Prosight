import 'package:flutter/material.dart';

class ExtendedTextButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageUrl;
  final VoidCallback onPressed;
  final Color? color;
  const ExtendedTextButton({
    Key? key,
    required this.title,
    this.icon,
    required this.onPressed,
    this.imageUrl,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (imageUrl != null)
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    )
                  : (icon != null)
                      ? Icon(
                          icon,
                          color: Colors.white,
                        )
                      : const SizedBox(),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
