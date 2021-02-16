import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/item_view/item_body_right.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/widget/text_widget.dart';

import 'filter/item_filter.dart';

class ContainBodyHome extends StatefulWidget {
  ContainBodyHome({Key key, this.width, this.height}) : super(key: key);
  final double width, height;

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
  ContainBodyRight({Key key, this.postItem, this.width, this.height, this.menuLeftPresenter, this.title}) : super(key: key);
  final String title;
  Future<List<BodyRight>> postItem;
  final double width, height;
  final MenuLeftPresenter menuLeftPresenter;

  @override
  _ContainBodyRightState createState() => _ContainBodyRightState();
}

class _ContainBodyRightState extends State<ContainBodyRight>{

  var listSort = Common.getListSort();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: textView(widget.title, Colors.black, 35, FontWeight.bold),
          ),
          SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerLeft,
            child: textView('View more', Colors.black, 12, FontWeight.bold),
          ),
          SizedBox(height: 20,),
          Container(
            height: 45,
            child:  ListView.builder(
              itemCount: listSort.length,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return i == 0 ? ItemSortProduct(name: listSort[i]) : ItemFilterProduct(name: listSort[i]);
              },
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
              child: FutureBuilder<List<BodyRight>>(
                future: widget.postItem,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text('No data found');
                      } else {
                        if (!snapshot.hasData) return Container();
                        return GridView.count(
                          crossAxisCount: 4,
                          crossAxisSpacing: widget.height * 0.05,
                          mainAxisSpacing: widget.width * 0.02,
                          childAspectRatio: 9 / 12,
                          children: snapshot.data.map((int) => ItemBodyRight(item: int, menuLeftPresenter: widget.menuLeftPresenter,)).toList(),
                        );
                      }
                  }
                },
              )
          )
        ],
      ),
    );
  }
}