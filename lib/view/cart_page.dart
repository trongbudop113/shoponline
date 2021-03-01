import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  TextEditingController codeTextController = TextEditingController();

  var textSize = 22.0;

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    Widget _entryFieldText(TextEditingController textController, TextInputType inputType) {
      return TextField(
          keyboardType: inputType,
          controller: textController,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            focusColor: Colors.white,
            fillColor: Colors.white,
            enabledBorder: new OutlineInputBorder(
              borderSide: BorderSide(
                width: 0
              ),
            ),
            focusedBorder : new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
            filled: true,
          )
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: BLACK,
      ),
      body: Container(
        width: itemWidth,
        child: !Common.isPortrait(context) ?
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.pink[100]
              ),
              width: itemWidth * 0.7,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.greenAccent,
              ),
              width: itemWidth * 0.3,
            )
          ],
        ) :
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: itemHeight * 0.02),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                child: textView('Giỏ hàng của bạn:', BLACK, 22, FontWeight.normal),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(itemWidth * 0.05),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) =>
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                            color: BLACK,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: itemWidth * 0.05),
                                Row(
                                  children: [
                                    Container(
                                      width: itemWidth * 0.3,
                                      height: itemWidth * 0.3,
                                      color: Colors.white,
                                    ),
                                    Spacer(flex: 1),
                                    Container(
                                      child: Icon(
                                        Icons.delete,
                                        color: WHITE,
                                        size: itemWidth * 0.08,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: textView('Name', WHITE, textSize, FontWeight.normal),
                                    ),
                                    Spacer(flex: 1,),
                                    Container(
                                      child: Row(
                                        children: [
                                          textView('-', WHITE, textSize, FontWeight.normal),
                                          SizedBox(width: 10,),
                                          textViewCenter('1', WHITE, textSize, FontWeight.bold),
                                          SizedBox(width: 10,),
                                          textView('+', WHITE, textSize, FontWeight.normal),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ),
                          Divider(height: 2, color: WHITE)
                        ],
                      ),
                    childCount: 5,
                  )
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: itemWidth * 0.6,
                      child: _entryFieldText(codeTextController, TextInputType.text),
                    ),
                    Spacer(flex: 1),
                    Container(
                      color: BLACK,
                      width: itemWidth * 0.2,
                      child: textViewCenter('Apply', WHITE, 20, FontWeight.normal),
                    )
                  ],
                )
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: itemHeight * 0.05),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                alignment: Alignment.centerRight,
                child: textView('Thành tiền: ' + '100.000', BLACK, 20, FontWeight.normal),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                alignment: Alignment.centerRight,
                child: textView('Giảm giá: ' + '20.000', BLACK, 20, FontWeight.normal),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
                alignment: Alignment.centerRight,
                child: textView('Tổng:' + '80.000', BLACK, 20, FontWeight.normal),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(itemWidth * 0.05),
                color: BLACK,
                child: textView('Thanh toán', WHITE, 20, FontWeight.normal),
              ),
            ),
          ],
        ),
      )
    );
  }
}