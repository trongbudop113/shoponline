import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/view_more_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ContainBodyHome extends StatefulWidget {
  ContainBodyHome({Key key, this.width, this.height, this.homePresenter}) : super(key: key);
  final double width, height;
  final HomePresenter homePresenter;

  @override
  _ContainBodyHomeState createState() => _ContainBodyHomeState();
}

class _ContainBodyHomeState extends State<ContainBodyHome>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Home home home')
    );
  }
}

class ContainBodyRight extends StatefulWidget {
  ContainBodyRight({Key key, this.width, this.height, this.menuLeft, this.homePresenter, this.withRight}) : super(key: key);
  final double width, height;
  final MenuLeft menuLeft;
  final HomePresenter homePresenter;
  final double withRight;

  @override
  _ContainBodyRightState createState() => _ContainBodyRightState();
}

class _ContainBodyRightState extends State<ContainBodyRight>{

  var listSort = Common.getListSort();
  bool isHover = false;

  @override
  void initState() {
    BodyRightNotifier bodyRightNotifier = Provider.of<BodyRightNotifier>(context, listen: false);
    getProductsData(bodyRightNotifier, widget.menuLeft);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemWidthCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;
    var itemHeight = (widget.withRight / 2) * (4/3);

    var widthTextDisCount = (itemWidth * 0.02) > 35.0 ? itemWidth * 0.02 : 35.0;
    var sizeTextDisCount = 10.0;
    var sizeTextName = (itemWidth * 0.01) > 14.0 ? itemWidth * 0.01 : 14.0;
    var widthButton = (itemWidth * 0.05) > 50.0 ? (itemWidth * 0.05) : 50.0;
    var sizeButton = (itemWidth * 0.02) > 20.0 ? (itemWidth * 0.02) : 20.0;

    BodyRightNotifier bodyRightNotifier = Provider.of<BodyRightNotifier>(context, listen: false);

    Widget itemButton(IconData icon, int type){
      return InkWell(
        child: Container(
          width: widthButton,
          height: widthButton,
          color: BLACK,
          child: Icon(icon, color: WHITE, size: sizeButton),
        ),
        onTap: (){
          switch(type){
            case 1 : {
              //onClickAddToCart(widget.item);
              break;
            }
            case 0 : {
              //onClickAddToWishList(widget.item);
              break;
            }
          }
        },
      );
    }

    Widget _gridViewPortrait() {
      return bodyRightNotifier.currentLoading ?
      GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        padding: EdgeInsets.all(4.0),
        childAspectRatio: 3 / 4,
        children: new List<Widget>.generate(4, (index) {
          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300],
            child: ShimmerLayout(),
            period: Duration(milliseconds: 2000),
          );
        }),
      ) :
      GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: EdgeInsets.all(4.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
        children: bodyRightNotifier.productList.map((item) =>
            InkWell(
              onHover: (value){
                setState(() {
                  isHover = value;
                });
              },
              onTap: (){
                bodyRightNotifier.currentProduct = item;
                widget.homePresenter.goToDetail();
              },
              child: Container(
                  child: CachedNetworkImage(
                      imageUrl: item.image,
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: BLACK),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.all(itemWidth * 0.01),
                                  child: item.discount == null ?
                                  Container() :
                                  Container(
                                    color: BLACK,
                                    width: widthTextDisCount,
                                    height: widthTextDisCount,
                                    alignment: Alignment.center,
                                    child: textView('-' + item.discount + '%', WHITE, sizeTextDisCount, FontWeight.normal),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: BLACK,
                                  padding: EdgeInsets.all(itemWidth* 0.01),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: textView(item.toString(), WHITE, sizeTextName, FontWeight.bold),
                                      ),
                                      Container(
                                        child: textView(item.price.toString(), WHITE, sizeTextName, FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              isHover ?
                              Container(
                                  color: Color.fromRGBO(0, 0, 0, 80),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          itemButton(Icons.favorite, 0),
                                          SizedBox(width: 5,),
                                          itemButton(Icons.add_shopping_cart, 1)
                                        ],
                                      ),
                                    ],
                                  )
                              ) :
                              Container(),
                            ],
                          )
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: BLACK),
                          ),
                          child: Icon(Icons.error),
                        );
                      }
                  )
              ),
            )
        ).toList(),
      );
    }

    Widget _gridViewLandscape() {
      return bodyRightNotifier.currentLoading ?
      GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.all(4.0),
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: new List<Widget>.generate(4, (index) {
          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300],
            child: ShimmerLayout(),
            period: Duration(milliseconds: 2000),
          );
        }),
      ) :
      GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.all(4.0),
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: bodyRightNotifier.productList.map((item) =>
            InkWell(
              onHover: (value){
                setState(() {
                  isHover = value;
                });
              },
              onTap: (){
                bodyRightNotifier.currentProduct = item;
                widget.homePresenter.goToDetail();
              },
              child: Container(
                  child: CachedNetworkImage(
                      imageUrl: item.image,
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: BLACK),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.all(itemWidth * 0.01),
                                  child: item.discount == null ?
                                  Container() :
                                  Container(
                                    color: BLACK,
                                    width: widthTextDisCount,
                                    height: widthTextDisCount,
                                    alignment: Alignment.center,
                                    child: textView('-' + item.discount + '%', WHITE, sizeTextDisCount, FontWeight.normal),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: BLACK,
                                  padding: EdgeInsets.all(itemWidth* 0.01),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: textView(item.toString(), WHITE, sizeTextName, FontWeight.bold),
                                      ),
                                      Container(
                                        child: textView(item.price.toString(), WHITE, sizeTextName, FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              isHover ?
                              Container(
                                  color: Color.fromRGBO(0, 0, 0, 80),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          itemButton(Icons.favorite, 0),
                                          SizedBox(width: 5,),
                                          itemButton(Icons.add_shopping_cart, 1)
                                        ],
                                      ),
                                    ],
                                  )
                              ) :
                              Container(),
                            ],
                          )
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: BLACK),
                          ),
                          child: Icon(Icons.error),
                        );
                      }
                  )
              ),
            )
        ).toList(),
      );
    }

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: textView(widget.menuLeft.name, Colors.black, 35, FontWeight.bold),
          ),
          SizedBox(height: 15,),
          InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              child: textView('View more', Colors.black, 12, FontWeight.bold),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewMorePage()));
            },
          ),
          SizedBox(height: 20),
          Container(
              //height: itemHeight * 2,
              child: Common.isPortrait(context) ? _gridViewPortrait() : _gridViewLandscape()
          ),
          Spacer(flex: 1),
          Container(
            height: Common.isPortrait(context) ? 25 : 30,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.only(right: 5.0),
                    width: Common.isPortrait(context) ? 25 : 30,
                    height: Common.isPortrait(context) ? 25 : 30,
                    child: Container(
                      alignment: Alignment.center,
                      child: textView('1', Colors.white, Common.isPortrait(context) ? 12 : 15, FontWeight.bold),
                    ),
                  ),
                  onTap: (){

                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 280;
    double containerHeight = 15;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Container(
                height: 100,
                color: Colors.grey,
              )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}