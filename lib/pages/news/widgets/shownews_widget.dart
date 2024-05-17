import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:intl/intl.dart';

class ShowNews extends StatefulWidget {
  const ShowNews({super.key});

  @override
  State<ShowNews> createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  @override
  Widget build(BuildContext context) {
    return showNews();
  }
}

Widget showNews() {
  return Container(
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      //scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItemNews(index);
      },
    ),
  );
}

Widget _buildItemNews(int index) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return Container(
    height: Dimensions.height10 * 12,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius10),
      color: Colors.white,
    ),
    //width: 350,
    //color: Colors.amber,
    margin: EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Dimensions.height10 * 12,
          width: Dimensions.width10 * 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius10),
                bottomLeft: Radius.circular(Dimensions.radius10)),
            image: DecorationImage(
                image: AssetImage("assets/images/ho_ba_be.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: Dimensions.width15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Dimensions.width10 * 23,
              margin: EdgeInsets.only(top: Dimensions.height10),
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, top: 2, right: 10, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[600],
                    ),
                    child: Center(
                      child: BigText(
                        text: "New",
                        color: Colors.white,
                        size: Dimensions.font16,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 100,
                  // ),
                  SmallText(
                    text: formattedDate,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Container(
              width: Dimensions.width10 * 23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "This is title of the news",
                    size: Dimensions.font16,
                    color: Colors.blue[600],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SmallText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce auctor metus eu turpis cursus, eget vestibulum nunc varius. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin eget convallis libero. Donec non velit a velit bibendum finibus. Nullam euismod consequat libero, eget pulvinar velit fermentum vel. Nulla eget purus at magna convallis sollicitudin. Integer id lectus eget nibh posuere sodales.",
                    maxLines: 2,
                    size: Dimensions.font16,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}
