import 'package:abstract_curiousity/Features/UserRegisteration/screens/personaliseTopics.dart';
import 'package:abstract_curiousity/Features/UserRegisteration/services/auth_repository.dart';
import 'package:abstract_curiousity/Features/UserRegisteration/services/bloc/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/widgets/extendedTextButton.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthRepository authRepository = AuthRepository();
  void SignUpUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (builder) => const ChooseTopics()),
                (route) => false);
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return LandingWidget();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class LandingWidget extends StatefulWidget {
  const LandingWidget({
    super.key,
  });

  @override
  State<LandingWidget> createState() => _LandingWidgetState();
}

class _LandingWidgetState extends State<LandingWidget> {
  void loginWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/landingScreen4.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ExtendedTextButton(
            imageUrl: "http://pngimg.com/uploads/google/google_PNG19635.png",
            title: "Continue With Google",
            onPressed: () {
              loginWithGoogle(context);
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
