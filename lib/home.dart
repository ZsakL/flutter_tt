import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:oktoast/oktoast.dart';

import 'CustomSwiperPaginationBuilder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            buildGetTop(context),
            const SizedBox(height: 18),
            buildGetName(),
            const SizedBox(height: 28),
            buildSafetyAndPrecaution(),
            const SizedBox(height: 7),
            buildClosed(),
            const SizedBox(height: 18),
            buildFunction(),
            const SizedBox(height: 18),
            buildSwiper(),
          ],
        ),
      ),
    );
  }
}

//轮播图
Widget buildSwiper() {
  List<String> imgList = [
    "images/icon_safety_tips.png",
    "images/icon_safety_tips.png",
    "images/icon_safety_tips.png"
  ];
  return Container(
      height: 290.w,
      padding: const EdgeInsets.fromLTRB(1, 4.5, 0, 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg_swiper.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Swiper(
        autoplay: true,
        autoplayDelay: 5000,
        itemCount: imgList.length,
        itemBuilder: (BuildContext context, int index) {
          //每次循环遍历时，将i赋值给index
          return PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: AssetImage(imgList[index]),
                fit: BoxFit.fill,
              ));
        },

        onTap: (index) {
          print(imgList[index]);
        },
        //指示器
        pagination: SwiperPagination(
          margin: const EdgeInsets.all(22),
          builder: CustomSwiperPaginationBuilder(),
        ),
      ));
}

//按钮cell
Widget buildFunctionCell(String name, String url) {
  return getInkWell(
      name,
      SizedBox(
          // width: 63.5.w,
          height: 58.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(url),
                height: 30.w,
                width: 30.w,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 15, color: Color(0xFF555555)),
              ),
            ],
          )));
}

//功能按钮
Widget buildFunction() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      buildFunctionCell("重大危险源", "images/icon_danger.png"),
      buildFunctionCell("特殊作业管理", "images/icon_special.png"),
      buildFunctionCell("敏捷应急", "images/icon_contingency.png"),
      buildFunctionCell("危化品运输", "images/icon_transportation.png")
    ],
  );
}

//封闭化管理
Widget buildClosed() {
  return SizedBox(
    height: 58.5.w,
    child: getInkWell(
        "封闭化管理",
        const Image(
          image: AssetImage("images/bg_closed.png"),
          fit: BoxFit.fill,
        )),
  );
}

//安全基础信息和双重预防机制
Widget buildSafetyAndPrecaution() {
  return SizedBox(
    height: 93.w,
    child: Stack(
      children: [
        getGestureDetector(
            "安全基础信息",
            const Align(
              alignment: Alignment(-1, 0),
              child: Image(
                image: AssetImage("images/bg_safety.png"),
              ),
            )),
        getGestureDetector(
            "点击双重预防机制",
            const Align(
              alignment: Alignment(1, 0),
              child: Image(
                image: AssetImage("images/bg_precaution.png"),
              ),
            ))
      ],
    ),
  );
}

//名称
Widget buildGetName() {
  return const Text(
    "四川省汉源工业园区",
    style: TextStyle(fontSize: 22, color: Color(0xFF333333)),
  );
}

//顶部
Widget buildGetTop(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    //指的是子Widget的对其方式，默认情况是以左上角为开始点
    children: [
      const Text(
        "欢迎！",
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      const Expanded(
        child: Text(''), // 中间用Expanded控件
      ),
      InkWell(
        onTap: () {
          showToast('点击扫码按钮');
        },
        child: const Image(
          image: AssetImage("images/icon_scan.png"),
          width: 21,
          height: 21,
        ),
      ),
      const SizedBox(width: 14),
      InkWell(
          onTap: () {
            // showToast('点击我的');
            //返回上一个页面
            // Navigator.of(context).pop();
            //跳转并关闭当前页面
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  const MinePage( title: "个人中心",)),
                  (route) => false,
            );
          },
          child: const Image(
            image: AssetImage("images/icon_personnel.png"),
            width: 21,
            height: 21,
          )),
      //消息小红点
      Container(
        width: 4.2,
        height: 4.3,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: const Color(0xFFCD0000),
            borderRadius: BorderRadius.circular(100.0)),
      ),
    ],
  );
}

Widget getGestureDetector(String showText, Widget widget) {
  return GestureDetector(
    onTap: () {
      showToast("点击$showText");
    },
    child: widget,
  );
}

Widget getInkWell(String showText, Widget widget) {
  return InkWell(
    onTap: () {
      showToast("点击$showText");
    },
    child: widget,
  );
}
