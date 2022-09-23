import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());

  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //点击弹窗
    return OKToast(
        //屏幕自适应
        child: ScreenUtilInit(
          //尺寸
          designSize: const Size(375, 831),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false, // 不显示右上角的 debug
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const MinePage(title: '个人中心'),
            );
          },
        ));
  }
}

class MinePage extends StatefulWidget {
  const MinePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFF8FAFF),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            const SizedBox(
                width: 365,
                child: Image(
                  image: AssetImage("images/bg_personal.png"),
                  fit: BoxFit.cover,
                )),
            Scaffold(
                // backgroundColor: const Color(0xFFF8FAFF), //把scaffold的背景色改成透明
                backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  //把appbar的背景色改成透明
                  elevation: 0,
                  //appbar的阴影
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      //跳转页面
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => const HomePage()));
                      //跳转并关闭当前页面
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
                    color: const Color(0xFF333333),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  title: Text(
                    widget.title,
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFF333333)),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          buildMessage(), //个人信息
                          Container(height: 20.w),
                          buildFunction(context), //功能
                        ],
                      ),
                    ),
                    // Container(height: 80.w),
                    buildOutLoginButton(context), //退出登录
                  ],
                ))
          ],
        ));
  }
}

//退出登录
Widget buildOutLoginButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 34),
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () {
        showToast('点击退出登录');
        //跳转页面
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: Container(
        height: 40,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4581FD), width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Text(
          '退出登录',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF417EFB),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

//功能
Widget buildFunction(BuildContext context) {
  return Container(
    // margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    height: 350.w,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        buildSignature(context),
        Align(
            alignment: const Alignment(0, 1), child: buildButtonList(context)),
      ],
    ),
  );
}

Widget buildCell(String iconUrl, String imageName) {
  return Material(
      color: Colors.transparent,
      child: Container(
          padding: const EdgeInsets.fromLTRB(16.5, 0, 16.5, 0),
          height: 50,
          child: Ink(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  showToast('点击$imageName');
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右两边对齐
                    children: <Widget>[
                      //left
                      Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage(iconUrl),
                            width: 29,
                            height: 29,
                          ),
                          const SizedBox(width: 14.5),
                          Text(
                            imageName,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      //right
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 17,
                        color: Color(0xFFCDCEDF),
                      ),
                    ]),
              ))));
}

//按钮列表
Widget buildButtonList(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 241.w,
    // color: Colors.white,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              // color: Colors.black12,
              // color: Colors.white,
              color: Color(0xFFE6EBF7),
              offset: Offset(0.0, 5.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 2.0 //阴影扩散程度
              )
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildCell("images/icon_personal.png", "个人信息"),
        buildLine(),
        buildCell("images/icon_change_password.png", "修改密码"),
        buildLine(),
        buildCell("images/icon_face_entry.png", "人脸录入"),
        buildLine(),
        buildCell("images/icon_update.png", "版本更新"),
      ],
    ),
  );
}

//分割线
Widget buildLine() {
  return Container(
    height: 0.5,
    color: const Color(0xFFF0F0F0),
    margin: const EdgeInsets.fromLTRB(16.5, 0, 16.5, 0),
  );
}

//签名
Widget buildSignature(BuildContext context) {
  return Container(
    height: 147.w,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/bg_signature.png"),
        fit: BoxFit.fitWidth,
      ),
    ),
    child: Stack(
      children: [
        const Align(
          alignment: Alignment(-0.84, -0.3),
          child: Image(
            image: AssetImage("images/signature_title.png"),
            // height: 30,
            // width: 90,
            height: 13.5,
            width: 66,
          ),
        ),
        const Align(
          alignment: Alignment(-0.795, -0.05),
          child: Text(
            "您签的名字将显示在这里！",
            style: TextStyle(fontSize: 12, color: Color(0xB3FFFFFF)),
          ),
        ),
        Align(
          alignment: const Alignment(0.8, -0.19),
          child: buildInkWellContainer(context),
        ),
      ],
    ),
  );
}

//签名按钮
Widget buildInkWellContainer(BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () {
        showToast('点击签字按钮');
      },
      child: Container(
        height: 29,
        width: 76,
        //设置child 居中
        alignment: const Alignment(0, 0),
        child: Ink.image(
          image: const AssetImage(
            "images/bg_signature_button.png",
          ),
        ),
      ),
    ),
  );
}

//个人信息
Widget buildMessage() {
  return Container(
    margin: const EdgeInsets.fromLTRB(30, 61, 0, 0),
    child: Row(
      children: [
        const CircleAvatar(
            radius: 41,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 39,
              backgroundImage: AssetImage("images/portrait.jpg"),
            )),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "你的名字",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 7),
            Text(
              "185****2568",
              style: TextStyle(fontSize: 13, color: Color(0xFFA2A2B8)),
            ),
          ],
        )
      ],
    ),
  );
}
