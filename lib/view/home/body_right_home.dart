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
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';

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
  ContainBodyRight({Key key, this.width, this.height, this.menuLeft, this.homePresenter}) : super(key: key);
  final double width, height;
  final MenuLeft menuLeft;
  final HomePresenter homePresenter;

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
    var itemHeight = MediaQuery.of(context).size.height;

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

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: textView(widget.menuLeft.name, Colors.black, 35, FontWeight.bold),
          ),
          SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerLeft,
            child: textView('View more', Colors.black, 12, FontWeight.bold),
          ),
          SizedBox(height: 20,),
          // Container(
          //   height: 45,
          //   child:  ListView.builder(
          //     itemCount: listSort.length,
          //     scrollDirection: Axis.horizontal,
          //     physics: BouncingScrollPhysics(),
          //     itemBuilder: (context, i) {
          //       return i == 0 ? ItemSortProduct(name: listSort[i]) : ItemFilterProduct(name: listSort[i]);
          //     },
          //   ),
          // ),
          Container(
              height: widget.height * 0.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: bodyRightNotifier.productList.length,
                itemBuilder: (context, index) {
                  print(bodyRightNotifier.productList[index].image);
                  return InkWell(
                    onHover: (value){
                      setState(() {
                        isHover = value;
                      });
                    },
                    onTap: (){
                      bodyRightNotifier.currentProduct = bodyRightNotifier.productList[index];
                      widget.homePresenter.goToDetail();
                    },
                    child: Container(
                        width: itemWidthCustom * 0.4,
                        margin: EdgeInsets.only(right: itemWidth * 0.02),
                        child: CachedNetworkImage(
                            imageUrl: bodyRightNotifier.productList[index].image,
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
                                        child: bodyRightNotifier.productList[index].discount == null ?
                                        Container() :
                                        Container(
                                          color: BLACK,
                                          width: widthTextDisCount,
                                          height: widthTextDisCount,
                                          alignment: Alignment.center,
                                          child: textView('-' + bodyRightNotifier.productList[index].discount + '%', WHITE, sizeTextDisCount, FontWeight.normal),
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
                                              child: textView(bodyRightNotifier.productList[index].name.toString(), WHITE, sizeTextName, FontWeight.bold),
                                            ),
                                            Container(
                                              child: textView(bodyRightNotifier.productList[index].price.toString(), WHITE, sizeTextName, FontWeight.normal),
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
                  );
                },
              )
          )
        ],
      ),
    );
  }
}