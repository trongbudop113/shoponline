import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemBodyRight extends StatefulWidget {
  ItemBodyRight({Key key, this.item, this.menuLeftPresenter}) : super(key: key);
  final BodyRight item;
  final MenuLeftPresenter menuLeftPresenter;

  @override
  _ItemBodyRightState createState() => _ItemBodyRightState();
}

class _ItemBodyRightState extends State<ItemBodyRight> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemWidthCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    var widthTextDisCount = (itemWidth * 0.02) > 35 ? itemWidth * 0.02 : 35;
    var sizeTextDisCount = 10.0;
    var sizeTextName = (itemWidth * 0.01) > 14 ? itemWidth * 0.01 : 14;

    return InkWell(
      onTap: (){
        widget.menuLeftPresenter.goToDetail();
      },
      child: Container(
        width: itemWidthCustom * 0.4,
        margin: EdgeInsets.only(right: itemWidth * 0.02),
        child: CachedNetworkImage(
            imageUrl: widget.item.image,
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
                      child: widget.item.discount == '0' ?
                      Container() :
                      Container(
                        color: BLACK,
                        width: widthTextDisCount,
                        height: widthTextDisCount,
                        alignment: Alignment.center,
                        child: textView('-' + widget.item.discount + '%', WHITE, sizeTextDisCount, FontWeight.normal),
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
                            child: textView( widget.item.name, WHITE, sizeTextName, FontWeight.bold),
                          ),
                          Container(
                            child: textView(widget.item.price, WHITE, sizeTextName, FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
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
  }
}