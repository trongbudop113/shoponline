import 'package:flutter/material.dart';
import 'package:flutter_project/dialog/progress_dialog.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/image_widget.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  bool _isShow = false;

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;
    var sizeTextCustom = 28.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BLACK,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                width: 50,
                height: 50,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_back, size: 30, color: WHITE),
                ),
            ),
          ),
          Spacer(flex: 1,),
          Container(
            alignment: Alignment.center,
            child: textViewCenter('WEARISM', WHITE, sizeTextCustom, FontWeight.bold),
          ),
          Spacer(flex: 1,),
          InkWell(
            onTap: (){

            },
            child: Container(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Icon(Icons.shopping_cart, size: 30, color: WHITE),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: textView('0', WHITE, 18, FontWeight.normal),
                    )
                  ],
                )
            ),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isShow,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: itemWidth,
                height: itemWidth,
                child: customImageView('https://giayxshop.vn/wp-content/uploads/2019/02/MG_4329.jpg'),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(itemWidth * 0.05),
                      alignment: Alignment.center,
                      width: itemWidth * 0.6,
                      child: textView('Giày Thể Thao XSPORT Prophere Rep', BLACK, 20, FontWeight.normal),
                    ),
                    Container(
                      padding: EdgeInsets.all(itemWidth * 0.05),
                      alignment: Alignment.center,
                      width: itemWidth * 0.4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: textView('-', WHITE, 18, FontWeight.normal),
                            color: BLACK,
                            width: 30,
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: textViewCenter('1', BLACK, 18, FontWeight.normal),
                            width: 40,
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: textView('+', WHITE, 18, FontWeight.normal),
                            color: BLACK,
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(color: Colors.grey, height: 1),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: itemWidth  * 0.05, vertical: 10),
                      width: itemWidth * 0.5 - 1,
                      child: Row(
                        children: [
                          textView('Màu sắc:', BLACK, 15, FontWeight.normal),
                          Spacer(flex: 1),
                          Container(
                            width: 40,
                            height: 40,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: itemHeight * 0.05,
                      child: VerticalDivider(color: Colors.grey, width: 1)
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: itemWidth  * 0.05, vertical: 10),
                      width: itemWidth * 0.5,
                      child: Row(
                        children: [
                          textView('Size:', BLACK, 15, FontWeight.normal),
                          Spacer(flex: 1),
                          textView('31.5', BLACK, 18, FontWeight.normal),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
            SliverToBoxAdapter(
              child: Divider(color: Colors.grey, height: 1),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(itemWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textView('Thông tin chi tiết', BLACK, 20, FontWeight.normal),
                    SizedBox(height: itemHeight * 0.01),
                    textViewLine('Thật sự Adidas đã tạo ra một sản phẩm thú vị dành cho các sneakerhead trên toàn thế giới: không giới hạn, không giá trị, chỉ đơn giản là đẹp và chất lượng'+
                      '\nBạn hoàn toàn có thể mang đôi giày cho bất kì hoạt động thường ngày nào: đi làm, đi học, đi bar và cả tập gym'+
                      '\nĐế Chunky năng động, mạnh mẽ và hầm hố',
                        Colors.grey,
                        15,
                        FontWeight.normal,
                        1.5
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        progressIndicator: IndicatorProgress(),
      ),
      bottomNavigationBar: Container(
        color: BLACK,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: (itemWidth * 0.4) - 1,
              child: textView('750,000 VND', WHITE, 20, FontWeight.normal),
            ),
            Container(
              height: 60,
              child: VerticalDivider(color: WHITE, width: 1),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: itemWidth * 0.2,
              child: Container(
                child: Icon(Icons.shopping_bag, color: WHITE, size: 30),
              ),
            ),
            Container(
              height: 60,
              child: VerticalDivider(color: WHITE, width: 1),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: (itemWidth * 0.4) - 1,
              child: Container(
                child: textView('ADD TO CART', WHITE, 20, FontWeight.normal),
              )
            )
          ],
        ),
      )
    );
  }
}