import 'package:flutter/material.dart';

/// This is the main view for the onboarding process.
/// It is a stateless widget that builds the onboarding screen.
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  /// This method builds the widget and returns a Scaffold widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff05019E),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_images/background.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0x66000000),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _OnboardingTitle(),
                _ChannelGrid(),
                _ContinueButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// This widget represents the title of the onboarding screen.
class _OnboardingTitle extends StatelessWidget {
  const _OnboardingTitle();

  /// This method builds the widget and returns a Padding widget.
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Pick the channels that interests you',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// This widget represents the grid of channels on the onboarding screen.
class _ChannelGrid extends StatelessWidget {
  final List<String> channelImagePaths = [
    'assets/onboarding_images/mosayed.png',
    'assets/onboarding_images/cnn.png',
    'assets/onboarding_images/bbc.png',
    'assets/onboarding_images/sky.png',
    'assets/onboarding_images/atv.png',
    'assets/onboarding_images/espn.png',
    'assets/onboarding_images/nbc.png',
    'assets/onboarding_images/fox.png',
    'assets/onboarding_images/bein.png',
    'assets/onboarding_images/euro.png',
    'assets/onboarding_images/abc.png',
    'assets/onboarding_images/ctv.png',
    'assets/onboarding_images/ntv.png',
    'assets/onboarding_images/tn.png',
    'assets/onboarding_images/btv.png',
  ];

  /// This method builds the widget and returns an Expanded widget.
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: channelImagePaths.length,
          itemBuilder: (context, index) {
            return _ChannelIcon(imagePath: channelImagePaths[index]);
          },
        ),
      ),
    );
  }
}

/// This widget represents an icon of a channel on the onboarding screen.
class _ChannelIcon extends StatelessWidget {
  const _ChannelIcon({required this.imagePath});

  final String imagePath;

  /// This method builds the widget and returns a SizedBox widget.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}

/// This widget represents the continue button on the onboarding screen.
class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onPressed});

  final VoidCallback onPressed;

  /// This method builds the widget and returns a Padding widget.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFFFFF),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 24.0,
            color: Color(0xFF05019E),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
