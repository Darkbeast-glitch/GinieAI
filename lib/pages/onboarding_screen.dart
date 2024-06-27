import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/pages/get_started.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/constants.dart';

// OnboardingInfo widget
class OnboardingInfo extends StatelessWidget {
  final String heading;
  final String subheading;

  const OnboardingInfo(
      {super.key, required this.heading, required this.subheading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: AppConstants.titleTextStyle),
        const SizedBox(height: 5),
        Text(subheading, style: AppConstants.subtitleTextStyle),
      ],
    );
  }
}

// OnBoardingScreen widget
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  final List<OnboardingInfo> onboardingPages = [
    const OnboardingInfo(
      heading: 'Welcome to GinieAI🧞',
      subheading:
          'Say a wish, and watch our Ultimate Ginie grant \nthem for you.Let Ginie be your companion.',
    ),
    const OnboardingInfo(
      heading: 'Book a Ride 🚕.',
      subheading:
          'Hate to  open the you rider app to book a ride?.\nSimply book a ride with your just a voice command.',
    ),
    const OnboardingInfo(
      heading: 'Ginie for Ghana 🇬🇭',
      subheading:
          'Love to command with your local dialect?, Speak Twi to Ginie and watch it respond to your commands.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Top image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/ginieAI.png',
                    width: 300, height: 300),
              ),
            ),
            // Bottom container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 360,
                width: double.infinity,
                color: AppConstants.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      // PageView for onboarding pages
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: onboardingPages.length,
                          itemBuilder: (context, index) =>
                              onboardingPages[index],
                        ),
                      ),
                      // Page indicator
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: onboardingPages.length,
                        ),
                      ),
                      // Skip and Next buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(
                            onTap: () => _pageController.animateToPage(
                                onboardingPages.length - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn),
                            text: "Skip",
                            color: const Color(0xFF28374e),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MyButton(
                            onTap: () {
                              if (currentPage < onboardingPages.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                // Navigate to the next screen when "Get Started" is pressed
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const GetStarted(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var tween = Tween(begin: begin, end: end);
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            text: currentPage == onboardingPages.length - 1
                                ? "Get Started"
                                : "Next",
                            color: AppConstants.primaryColor,
                          ),
                        ],
                      ),
                      // Privacy policy and terms of use
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'By continuing, you agree to our Privacy \nPolicy & Terms of user',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
