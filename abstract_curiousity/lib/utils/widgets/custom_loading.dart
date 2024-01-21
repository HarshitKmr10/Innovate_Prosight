// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatefulWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationComponent(index: 20, color: Colors.red.shade50),
              LoadingAnimationComponent(index: 18, color: Colors.red.shade100),
              LoadingAnimationComponent(index: 16, color: Colors.grey.shade50),
              LoadingAnimationComponent(index: 14, color: Colors.grey.shade100),
              LoadingAnimationComponent(index: 12, color: Colors.grey.shade100),
              LoadingAnimationComponent(index: 10, color: Colors.grey.shade200),
              LoadingAnimationComponent(index: 8, color: Colors.grey.shade300),
              LoadingAnimationComponent(index: 6, color: Colors.grey.shade400),
              LoadingAnimationComponent(index: 4, color: Colors.grey.shade700),
              const LoadingAnimationComponent(index: 2, color: Colors.grey),
              const LoadingAnimationComponent(index: 2, color: Colors.grey),
              LoadingAnimationComponent(index: 4, color: Colors.grey.shade700),
              LoadingAnimationComponent(index: 6, color: Colors.grey.shade400),
              LoadingAnimationComponent(index: 8, color: Colors.grey.shade300),
              LoadingAnimationComponent(index: 10, color: Colors.grey.shade200),
              LoadingAnimationComponent(index: 12, color: Colors.grey.shade100),
              LoadingAnimationComponent(index: 14, color: Colors.grey.shade100),
              LoadingAnimationComponent(index: 16, color: Colors.grey.shade50),
              LoadingAnimationComponent(index: 18, color: Colors.red.shade100),
              LoadingAnimationComponent(index: 20, color: Colors.red.shade50),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingAnimationComponent extends StatefulWidget {
  final int index;
  final Color color;
  const LoadingAnimationComponent({
    Key? key,
    required this.index,
    required this.color,
  }) : super(key: key);

  @override
  State<LoadingAnimationComponent> createState() =>
      _LoadingAnimationComponentState();
}

class _LoadingAnimationComponentState extends State<LoadingAnimationComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool disposed = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 2.0, end: 50.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    Future.delayed(
      Duration(milliseconds: widget.index * 20),
      () {
        if (!disposed) {
          _animationController.forward();
        }
      },
    );

    _animationController.addListener(() {
      if (!disposed) {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else if (_animationController.isDismissed) {
          _animationController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    disposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (disposed) return Container();
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Container(
          height: _scaleAnimation.value,
          width: 10,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(5.0)),
        );
      },
    );
  }
}
