import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/onboarding_cubit/onboarding_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/onboarding_text_style.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../widgets/introduction_widget.dart';

class OnboardingScreen extends StatefulWidget {
  final bool? isFirstTime;

  const OnboardingScreen({
    Key? key,
    this.isFirstTime,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController _carouselController = CarouselController();

  void _onActionButtonTap() {
    context.read<OnboardingCubit>().setFirstTime();
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              width: double.infinity,
              height: size.height * 0.28,
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Plan your travel with ease',
                            style: OnboardingTextStyle.introduction,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Flexible(
                        child: Text(
                          'Our application can help you easily and conveniently organize your flights.',
                          style: OnboardingTextStyle.description,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CarouselSlider(
                items: const [
                  IntroductionWidget(
                    imagePath: 'assets/images/onboarding.png',
                  ),
                ],
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: size.height * 0.6,
                  autoPlay: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.17,
            ),
            ChosenActionButton(
              color: AppColors.redColor,
              onTap: _onActionButtonTap,
              text: 'Get started',
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
          ],
        ),
      ),
    );
  }
}
