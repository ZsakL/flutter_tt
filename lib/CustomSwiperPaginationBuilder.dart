import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

/// 自定义页面指示器

class CustomSwiperPaginationBuilder extends SwiperPlugin {
  // 当滚动到此时的颜色
  late Color? activeColor;

  // 默认颜色
  late Color? color;

  // 每个圆点的间距
  final double space;

  // 每个圆点的大小
  final double size;

  // 特殊点的宽度
  final double activeSize;

  final Key? key;

  CustomSwiperPaginationBuilder(
      {this.color =const Color(0xFF5DCCF6),
        this.activeColor = const Color(0xFF5DCCF6),
        this.space = 3.0,
        this.size = 6.0,
        this.activeSize = 23.0,
        this.key});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    // 处理边界情况
    if (config.itemCount > 20) {
      log(
        'The itemCount is too big, we suggest use FractionPaginationBuilder '
            'instead of DotSwiperPaginationBuilder in this situation',
      );
    }
    int activeIndex = config.activeIndex;
    // 用于存放小圆点
    List<Widget> list = [];
    for (var i = 0; i < config.itemCount; ++i) {
      if (activeIndex == i) {
        list.add(Container(
            key: Key('pagination_$i'),
            margin: EdgeInsets.all(space),
            child: PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: activeColor,
                width: activeSize,
                height: size,
              ),
            )));
      } else {
        list.add(Container(
          key: Key('pagination_$i'),
          margin: EdgeInsets.all(space),
          child: ClipOval(
            // 圆角组件
            child: Container(
              color: color,
              width: size,
              height: size,
            ),
          ),
        ));
      }
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            left: 0,
            right: 0,
            bottom: -35.0,
            child: Row(
              key: key,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: list,
            ))
      ],
    );
  }
}