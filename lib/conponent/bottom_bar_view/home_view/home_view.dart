import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_splash_view.dart';
import 'package:develop_app_hoangnm/conponent/base_view/base_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/home_view/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../ui/shared/images.dart';

class HomeView extends BaseView {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState
    extends BaseViewState<HomeView, HomeViewModel, DimensSplashView> {
  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().dimensSplashView;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = HomeViewModel()..onInitViewModel(context);
  }

  final List<String> _listCategories = [
    Images.iconHeart,
    Images.iconTag,
    Images.iconTrendingUp,
    Images.iconDot,
  ];

  double _currentSliderValue = 20;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildNoticeAndUser(),
                _buildGreeting(),
                _buildHeader(title: "Our Best Deal"),
                _buildSlideItem(),
                _buildCategories(),
                _buildHeader(title: "Donate Now"),
                _buildSlideItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeAndUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(Images.iconNotification),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(Images.iconNotification),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Hello, Yametew",
                style: TextStyle(
                  color: HexColors.textColorUserName,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "What do you want to eat?",
                style: TextStyle(
                  color: HexColors.textColorAnswer,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: HexColors.textColorUserName,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "See all",
            style: TextStyle(
              color: HexColors.textColorSeeAll,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideItem() {
    return SizedBox(
      height: viewSize.fullHeight * 0.3,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: viewSize.fullWidthSafeArea * 0.8,
                  height: viewSize.fullHeight * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    Images.slideImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: viewSize.fullHeight * 0.15,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: viewSize.fullWidthSafeArea * 0.7,
                  height: viewSize.fullHeight * 0.10,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dunkin’s Donut",
                            style: TextStyle(
                              color: HexColors.textColorUserName,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "1 Dozen of Mix Donuts",
                            style: TextStyle(
                              color: HexColors.textColorAnswer,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "140000",
                            style: TextStyle(
                              color: HexColors.textColorUserName,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: HexColors.textColorUserName,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "5 Left",
                          style: TextStyle(color: HexColors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlideItem2() {
    return SizedBox(
      height: viewSize.fullHeight * 0.2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, position) {
          return Container(
              margin: const EdgeInsets.all(10),
              width: viewSize.fullWidthSafeArea * 0.8,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.iconNotification),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent),
                          width: viewSize.fullWidthSafeArea * 0.2,
                          height: 40,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: viewSize.fullWidthSafeArea * 0.8,
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Yayasan Y Team",
                          style: TextStyle(
                            color: HexColors.textColorSeeAll,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Slider(
                          value: _currentSliderValue,
                          max: 100,
                          divisions: 1,

                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "360.000 / 1.000.000",
                              style: TextStyle(
                                color: HexColors.textColorUserName,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: HexColors.textColorUserName,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Donate",
                                style: TextStyle(
                                  color: HexColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: viewSize.fullWidthSafeArea * 0.1),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (int i = 0; i < _listCategories.length; i++)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SvgPicture.asset(_listCategories[i]),
          )
      ]),
    );
  }
}
