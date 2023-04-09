import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../helpers/functions.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,

        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title:  Text(
          "عن التطبيق",
          style: TextStyle(color: Colors.white, fontFamily: "pnuR"),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: SingleChildScrollView(
          child: HtmlWidget(

            kHtmlFR,

            textStyle: TextStyle(fontSize: 16, color:Colors.black.withOpacity(.5),fontFamily: "pnuB"),

          ),
        ),
      ),

    );
  }
}



const kHtmlFR = """
<p>


تطبيق اوامرك هو دليل شامل لكل الخدمات الموجودة بمنطقتك سواء خدمية او مهنية او استهلاكية او حتي مقدمي خدمات الصيانة والاصلاح... ستجد كل ماتحتاجه في حياتك اليومية.. حيث يشمل اكثر من 22 نشاط مختلف لخدمتك...


</p>



""";