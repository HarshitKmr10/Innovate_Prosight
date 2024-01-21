
import 'package:abstract_curiousity/Features/Profile/_components/widgets/know_about_prestigepoints.dart';
import 'package:abstract_curiousity/Features/Profile/_components/widgets/profile_settings_modal.dart';
import 'package:abstract_curiousity/Features/UserRegisteration/screens/login_google.dart';
import 'package:abstract_curiousity/features/Profile/bloc/profile_bloc.dart';
import 'package:abstract_curiousity/features/UserRegisteration/services/bloc/auth_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _name = "Loading";
  String _bio = "Loading";

  // void getUserData() async {
  //   CustomUser? _customUser = await _profileRepository.getCurrentNameAndBio(
  //       firebaseUid: _firebaseAuth.currentUser!.uid, context: context);
  //   _name = _customUser!.name;
  //   _bio = _customUser.bio!;
  // }

  @override
  void initState() {
    setState(() {});
    super.initState();
    _pullRefresh();
  }

  Future<void> _pullRefresh() async {
    BlocProvider.of<ProfileBloc>(context).add(
      ProfileDetailsRequested(
        email: _firebaseAuth.currentUser!.email!,
        context: context,
      ),
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ProfileSettings(
                    carrriedContext: context,
                    nameOfUser: _name,
                    bioOfUser: _bio,
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.settings_suggest,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: Colors.white,
        backgroundColor: Colors.yellow,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LandingPage()),
                (route) => false,
              );
            }
          },
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoaded) {
                _name = state.customUser!.name;
                _bio = state.customUser!.bio!;
              }
              if (state is ProfileLoading) {
                const Center(child: CircularProgressIndicator());
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  const Center(child: CircularProgressIndicator());
                }
                if (state is ProfileNotFetched || state is ProfileError) {
                  const Center(
                      child: Text(
                    "Page Not Serviced",
                    style: TextStyle(color: Colors.white),
                  ));
                }

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const NetworkImage(
                            'https://plus.unsplash.com/premium_photo-1661265961086-05fda2956714?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://plus.unsplash.com/premium_photo-1661265961086-05fda2956714?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.shield,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Seeker',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                _bio,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const Column(
                        //   children: [
                        //     Text(
                        //       '157',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 20.0,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(height: 5.0),
                        //     Text(
                        //       'Likes',
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 15.0,
                        //         fontWeight: FontWeight.w300,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const Column(
                          children: [
                            Text(
                              '50',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Followers',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          children: [
                            Text(
                              '12',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Following',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.black.withOpacity(1),
                              elevation: 10,
                              showDragHandle: true,
                              barrierColor: Colors.white.withOpacity(0.2),
                              context: context,
                              builder: (BuildContext context) {
                                return const KnowAboutEngagements();
                              },
                            );
                          },
                          child: const Column(
                            children: [
                              Text(
                                '9',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Presitge',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey.withOpacity(0.7),
                      thickness: 1,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
