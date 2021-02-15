import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/widget/text_widget.dart';

class HeaderPage extends StatefulWidget {
  HeaderPage({Key key, this.title, this.homePresenter}) : super(key: key);
  final String title;
  final HomePresenter homePresenter;

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {

  bool _isCancelIconEmail = false;
  final _searchController = TextEditingController();
  FocusScopeNode currentFocus;

  void filterSearchResults(String query) {

  }

  void clearFocusText(){
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Row(
        children: [
          InkWell(
            child: textView('WEARISM', Colors.black, 35, FontWeight.bold),
            onTap: (){

            },
          ),
          Spacer(flex: 1,),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 15, right: 10),
            decoration: new BoxDecoration(
                color: Colors.grey[200],
                borderRadius: new BorderRadius.all(Radius.circular(15)
                )
            ),
            width: itemWidth * 0.4,
            child: FocusScope(
              onFocusChange: (value) {
                if (value) {
                  setState(() {});
                } else {
                  setState(() {
                    _isCancelIconEmail = false;
                  });
                }
              },
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _isCancelIconEmail = true;
                    filterSearchResults(text);
                  });
                },
                onTap: (){
                  setState(() {
                    filterSearchResults("");
                    _isCancelIconEmail = true;
                  });
                },
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                maxLines: 1,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for items, brands and inspiration',
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  suffixIcon: !_isCancelIconEmail ? null : InkWell(
                    onTap: () {
                      _searchController.clear();
                      clearFocusText();
                      setState(() {
                        _isCancelIconEmail = false;
                      });
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ),
            )
          ),
          Spacer(flex: 1,),
          InkWell(
            onTap: (){
              widget.homePresenter.goToWishList(context);
            },
            focusColor: Colors.grey,
            hoverColor: Colors.grey,
            child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.favorite_border, size: 30,),
            ),
          ),
          SizedBox(width: 20,),
          InkWell(
            onTap: (){
              widget.homePresenter.goToPersonInformation(context);
            },
            focusColor: Colors.grey,
            hoverColor: Colors.grey,
            child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.person, size: 30,),
            ),
          ),
          SizedBox(width: 20,),
          InkWell(
            onTap: (){
              widget.homePresenter.goToCartDetail(context);
            },
            focusColor: Colors.grey,
            hoverColor: Colors.grey,
            child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.shopping_cart, size: 30,),
            ),
          )
        ],
      ),
    );
  }
}