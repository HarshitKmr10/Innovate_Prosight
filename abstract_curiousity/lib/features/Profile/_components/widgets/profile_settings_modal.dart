// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:abstract_curiousity/Features/Profile/edit_profile.dart';
import 'package:abstract_curiousity/Features/Profile/_components/widgets/app_info_modal.dart';
import 'package:abstract_curiousity/Features/Profile/_components/widgets/danger_modal.dart';
import 'package:abstract_curiousity/Features/Reading%20History/reading_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../UserRegisteration/services/bloc/auth_bloc.dart';

class ProfileSettings extends StatefulWidget {
  final BuildContext carrriedContext;
  final String nameOfUser;
  final String bioOfUser;
  const ProfileSettings({
    Key? key,
    required this.carrriedContext,
    required this.nameOfUser,
    required this.bioOfUser,
  }) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    nameOfuser: widget.nameOfUser,
                    bioOfUser: widget.bioOfUser,
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.edit_note_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadingHistory(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Reading History',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              // Request notification permission
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.notification_important,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Notifications',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const AppInfoModal();
                },
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_sharp,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'App Info',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const DangerModal();
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.dangerous_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Danger Zone',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              widget.carrriedContext.read<AuthBloc>().add(LogOutRequested());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Logout : Stop Being Curious?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
