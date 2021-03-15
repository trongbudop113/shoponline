import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/values/image_page.dart';


class BannerPage extends StatefulWidget {

  BannerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerPageState();
  }
}

class _BannerPageState extends State<BannerPage> with AutomaticKeepAliveClientMixin<BannerPage> {
  int _current = 0;

  var post = [
    PageImage.PIC_1,
    PageImage.PIC_2,
    PageImage.PIC_3,
    PageImage.PIC_4,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeight = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(itemWidth * 0.02),
      color: BLACK,
      height: itemHeight * 0.5,
      width: itemWidth,
      child: Column(
          children: [
            Stack(
              children: <Widget>[
                CarouselSlider(
                  items: post.map((item) => GestureDetector(
                    onTap: (){

                    },
                    onDoubleTap: (){

                    },
                    child: Container(
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: item,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(backgroundColor: WHITE),
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 50,
                              ),
                            ),
                          ],
                        )
                    ),
                  )).toList(),
                  options: CarouselOptions(
                      height: itemHeight * 0.5,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                  ),
                ),

                Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 20,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: post.map((url) {
                          int index = post.indexOf(url);
                          return _current == index ?
                          Container(
                            width: 25,
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              border: Border.all(width: 2, color: WHITE),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(60)),
                                color: WHITE
                              ),
                            ),
                          ) : Container(
                            width: 25,
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(60)),
                                  color: WHITE
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                )
              ],
            ),
          ]
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}