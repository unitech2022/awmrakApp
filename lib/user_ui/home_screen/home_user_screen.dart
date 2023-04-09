import 'package:awarake/bloc/home_cubit/home_cubit.dart';
import 'package:awarake/helpers/constants.dart';
import 'package:awarake/models/home_model.dart';
import 'package:awarake/user_ui/category_screen/category_screen.dart';
import 'package:awarake/user_ui/details_care/details_care_screen.dart';
import 'package:awarake/user_ui/search_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../helpers/add_helper.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import '../../models/product.dart';
import '../details_product/details_product.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({Key? key}) : super(key: key);

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getHomeData();
    getAdds();
  }

  BannerAd? _bannerAd;

  void getAdds() {
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.code}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return HomeCubit.get(context).load
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: homeColor,
                ),
              )
            : RefreshIndicator(
                color: Colors.white,
                backgroundColor: const Color(0xff6A644C),
                onRefresh: () async {
                  HomeCubit.get(context).getHomeData();
                },
                child: Scaffold(
                  backgroundColor: KYellow2Color,
                  bottomSheet: _bannerAd != null
                      ? Container(
                       color: KYellow2Color,
                          width: double.infinity,
                          height: _bannerAd!.size.height.toDouble(),
                          child: Center(child: AdWidget(ad: _bannerAd!)),
                        )
                      : SizedBox(),
                  body: Padding(
                    padding:  EdgeInsets.only(bottom:_bannerAd != null? 50:20),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        SearchContainer(() {
                          pushPage(
                              page: const SearchScreen(), context: context);
                        }),
                        HomeCubit.get(context).homeModel.sliders!.isNotEmpty
                            ? SliderWidget()
                            : SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        HomeCubit.get(context).homeModel.cares!.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    child: const Text(
                                      'هذا التطبيق برعاية',
                                      style: TextStyle(
                                        fontFamily: 'pnuB',
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        height: 1.625,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : SizedBox(),

                        HomeCubit.get(context).homeModel.cares!.isNotEmpty? SizedBox(
                          height: 100,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: HomeCubit.get(context)
                                  .homeModel
                                  .cares!
                                  .length,
                              itemBuilder: (_,index){
                                Care sliderModel = HomeCubit.get(context)
                                    .homeModel
                                    .cares![index];
                                return InkWell(
                                  onTap: () {
                                    // Category categoryModel=Category(name: sliderModel.name,
                                    //     id: sliderModel.id,image: sliderModel.image);
                                    pushPage(
                                        context: context,
                                        page: DetailsCare(sliderModel));
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 200,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: baseurlImage +
                                              sliderModel.image!,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Center(
                                              child:
                                              CircularProgressIndicator(
                                                color: homeColor,
                                              ),
                                            ),
                                          ),
                                          errorWidget:
                                              (context, url, error) =>
                                          const Icon(Icons.error),
                                        )),
                                  ),
                                );

                              }),
                        ):SizedBox(),
                        /*  CarouselSlider.builder(
                                    options: CarouselOptions(
                                      aspectRatio: .9,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      height: 100,
                                      autoPlay: false,
                                      reverse: true,
                                      enableInfiniteScroll: false,
                                      initialPage: 0,
                                    ),
                                    itemCount: HomeCubit.get(context)
                                        .homeModel
                                        .cares!
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      Care sliderModel = HomeCubit.get(context)
                                          .homeModel
                                          .cares![itemIndex];

                                      return InkWell(
                                        onTap: () {
                                          // Category categoryModel=Category(name: sliderModel.name,
                                          //     id: sliderModel.id,image: sliderModel.image);
                                          pushPage(
                                              context: context,
                                              page: DetailsCare(sliderModel));
                                        },
                                        child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: baseurlImage +
                                                    sliderModel.image!,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    const Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: homeColor,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )),
                                        ),
                                      );
                                    },
                                  ),*/
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: const Text(
                            'الأقسام',
                            style: TextStyle(
                              fontFamily: 'pnuB',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              height: 1.625,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: HomeCubit.get(context)
                                .homeModel
                                .categories!
                                .length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 2),
                            itemBuilder: (BuildContext context, int index) {
                              Category category = HomeCubit.get(context)
                                  .homeModel
                                  .categories![index];
                              return InkWell(
                                onTap: () {
                                  pushPage(
                                      context: context,
                                      page: CategoryScreen(category));
                                  // pushPage(context: context,page: ProductDetailsScreen(food));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              baseurlImage + category.image!,
                                          height: 110,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(
                                            child: Container(
                                                width: 25,
                                                height: 25,
                                                child:
                                                    const CircularProgressIndicator(
                                                  color: Colors.green,
                                                )),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                  height: 110,
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.error,
                                                    size: 25,
                                                  ))),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.yellow
                                                      .withOpacity(0.4),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: SizedBox(
                                                width: 150,
                                                height: 80,
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          category.name!,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "pnuR",
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff215661)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    )),
                  ),
                ),
              );
      },
    );
  }
}

class SearchContainer extends StatelessWidget {
  final void Function() onPress;

  SearchContainer(this.onPress);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(.5)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'بتدور على ايه ؟',
                style: TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends StatelessWidget {


  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: .9,
            // enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            height: 130,
            // autoPlay: true,
            reverse: true,
            onPageChanged: (index,slid){
              HomeCubit.get(context).changIndex(index);
            },
            enableInfiniteScroll: false,
            initialPage: 0,
          ),
          itemCount: HomeCubit.get(context).homeModel.sliders!.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            Product sliderModel =
                HomeCubit.get(context).homeModel.sliders![itemIndex];

            return InkWell(
              onTap: () {
                // Category categoryModel=Category(name: sliderModel.name,
                //     id: sliderModel.id,image: sliderModel.image);
                pushPage(context: context, page: DetailsProduct(sliderModel.id!));
              },
              child: Container(
                height: 150,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: baseurlImage + sliderModel.image!,
                      width: 300,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: homeColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )),
              ),
            );
          },
        ),

        SizedBox(
          height: 20,
        ),
        CarouselIndicator(
          width: 10,
          height: 10,
          activeColor: Colors.red,
          color: Colors.grey,
          cornerRadius: 40,
          count:  HomeCubit.get(context).homeModel.sliders!.length,
          index: HomeCubit.get(context).indexSlide,
        ),
      ],
    );
  },
);
  }
}
