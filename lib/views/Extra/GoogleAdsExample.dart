import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mvvmproject/resources/AdResources.dart';

class GoogleAdsExample extends StatefulWidget {

  @override
  State<GoogleAdsExample> createState() => _GoogleAdsExampleState();
}

//     ( 1 )   Banner top bottom ad

       //android builder pub get
//ca-app-pub-4869079701257297~7204667678

              //unit id
//ca-app-pub-4869079701257297/4582373764-top
//ca-app-pub-4869079701257297/6239317782-bottom

          //testing unit id
//ca-app-pub-3940256099942544/6300978111

//---------------------------------------

//    ( 2 )   Interstitial button click event ad

      //android builder pub get
//ca-app-pub-4869079701257297~7204667678

              //unit id
//ca-app-pub-4869079701257297/7476032357-center

          //testing unit id
//ca-app-pub-3940256099942544/1033173712

class _GoogleAdsExampleState extends State<GoogleAdsExample> {

  BannerAd _topBannerAd;
  BannerAd _bottomBannerad;

  bool _istop=false;
  bool _isbottom=false;

   InterstitialAd myInterstitial;
    InterstitialAd interstitialAd;

  // @override
  // void dispose() {
  //   interstitialAd?.dispose();
  //   super.dispose();
  // }


   // ----------------     Banner Top Ad

  loadtopbanner()
  {
    _topBannerAd = BannerAd(
      adUnitId: AdResources.TOP_BANNER,
      size: AdSize.largeBanner,
      listener:  BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _istop = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print("error");
        },
      ),
    );
    _topBannerAd.load();
  }
  // ---------------------------    Banner Bottom Ad
  loadbottombanner()
  {
    _bottomBannerad = BannerAd(
      adUnitId: AdResources.BOTTOM_BANNER,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener:  BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isbottom = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerad.load();
  }
  // -----------------------    Interstitial Ad

  InterstitialAd _interstitialAd;
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _interstitialAd = null;
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

  // ---------------------------   Rewarded Ad


  RewardedAd _rewardedAd;
  void _createRewardedAd() async{
    RewardedAd.load(
      adUnitId:"ca-app-pub-3940256099942544/5224354917",
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;

          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _createRewardedAd();
          }),);
  }


  void _showRewardedAd()async {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd.setImmersiveMode(true);
    _rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        });
    _rewardedAd .show();
    _rewardedAd = null;
  }

  @override
  void initState() {
    super.initState();
    loadtopbanner();
    loadbottombanner();
    _createInterstitialAd();
    _createRewardedAd();
  }

  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async
    {_showInterstitialAd();
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if(_showInterstitialAd==isExitWarning){
      final message = "Press Back agin to exit";
      print(message);
      return false;
    }
    else
    {
      return true;
    }},
    child:Scaffold(
      appBar: AppBar(
        title: Text("Google Adds Example"),
      ),

      body:  Column(
        children: [
          (_istop)?
          Container(
            height: _topBannerAd.size.height.toDouble(),
            width: _topBannerAd.size.width.toDouble(),
            child: AdWidget(ad: _topBannerAd),
          ):SizedBox(height: 0,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: ()async{
                            _showInterstitialAd();
                          },
                          child: Text("Open Interstitial ad")),
                    ),
                  ),
                  ElevatedButton(onPressed: ()async{
                    _showRewardedAd();

                  },
                      child:Text("RewardedAd"))
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          (_isbottom)?
          Container(
            height: _bottomBannerad.size.height.toDouble(),
            width: _bottomBannerad.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerad),
          ):SizedBox(height: 0,),
        ],
      ),
    ),
    );
  }
}
