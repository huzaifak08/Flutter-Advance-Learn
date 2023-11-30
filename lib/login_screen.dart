import 'package:face_authentication/local_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _supportedState = false;
  late final LocalAuthentication auth;

  @override
  void initState() {
    auth = LocalAuthentication();
    config();

    super.initState();
  }

  config() async {
    bool isSupported = await LocalAuth.canAuthenticate();
    setState(() {
      _supportedState = isSupported;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login Screen'),
      ),
      body: Column(
        children: [
          // ignore: unnecessary_null_comparison
          if (_supportedState != null)
            const Text('This device is supported')
          else
            const Text('This device is not supported'),
          const Divider(),
          ElevatedButton(
            onPressed: () => _getAvailableBiometrics(),
            child: const Text('Available Prints'),
          ),
          const SizedBox(height: 23),
          ElevatedButton(
            onPressed: () => LocalAuth.authenticate(),
            child: const Text('Authenticate'),
          ),
        ],
      ),
    );
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availabeBiometrics =
        await auth.getAvailableBiometrics();

    debugPrint("Availabe Biometrics: $availabeBiometrics");

    if (!mounted) {
      return;
    }
    // then we call set state
  }
}
