import 'package:awarake/models/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../helpers/add_helper.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';

class DetailsCare extends StatefulWidget {
  final Care model;

  DetailsCare(this.model);


  @override
  State<DetailsCare> createState() => _DetailsCareState();
}

class _DetailsCareState extends State<DetailsCare> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdds();

  }
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
  BannerAd? _bannerAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet:_bannerAd != null?
        Container(

          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: Center(child: AdWidget(ad: _bannerAd!)),
        ):SizedBox(),
        appBar: AppBar(
          elevation: 0,

          leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),

          backgroundColor: const Color(0xff6A644C),
          title:  Text(widget.model.name!,
              style: TextStyle(
                fontFamily: 'pnuB',
                fontSize: 18,
                color: Colors.white,
              )),
        ),
        body:SingleChildScrollView(
          child: Column(

            children: [
          Container(
            height: 200,
            child: CachedNetworkImage(
            imageUrl: baseurlImage + widget.model.image!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: homeColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(widget.model.desc!,
                    style: TextStyle(
                      fontFamily: 'pnuB',
                      fontSize: 20,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 100,)

            ],

          ),
        ));

  }
}
