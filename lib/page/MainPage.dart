import 'package:animation_flutter_example/util/ColorUtil.dart';
import 'package:animation_flutter_example/util/SizeUtil.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final List<Widget> children = [
    Text("test"),
    Text("test"),
    Text("test"),
  ];

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget testText() => Text("test", style: TextStyle(fontSize: 250));

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(15),
      color: Colors.pink,
      child: Column(
        children: [
          AnimatedTabBar(
            children: children,
            height: 100,
            padding: EdgeInsets.all(20),
            intervalWidth: 20,
            selectedItemBackgroundColor: Colors.red,
          ),
          SizedBox(height: 20),
          Expanded(
              child: Container(
            color: Colors.amber,
            child: ListView(
              children: [
                testText(),
                testText(),
                testText(),
                testText(),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}

class AnimatedTabBar extends StatefulWidget {
  final List<Widget> children;
  final double? width;
  final double? height;
  final double intervalWidth;
  late final Color? backgroundColor;
  final Color selectedItemBackgroundColor;
  final EdgeInsets? padding;

  AnimatedTabBar({
    Key? key,
    required this.children,
    required this.selectedItemBackgroundColor,
    this.intervalWidth = 0,
    this.width,
    this.height,
    Color? backgroundColor,
    this.padding,
  }) : super(key: key) {
    this.backgroundColor = backgroundColor ?? Colors.white.withOpacity(0);
  }

  @override
  State<AnimatedTabBar> createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar> {
  double left = 0;
  double width = 0;
  double height = 0;
  final selectedGlobalKey = GlobalKey();

  List<Widget> get contentChildren {
    List<Widget> list = [];
    int i = 0;
    for (var child in widget.children) {
      list.add(Expanded(key: i==0?selectedGlobalKey:null,child: SizedBox.expand(child: child)));
      if (widget.intervalWidth > 0 && i < (widget.children.length - 1)) {
        list.add(SizedBox(width: widget.intervalWidth));
      }
      i++;
    }

    return list;
  }

  @override
  void initState() {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => afterBuild());
  }


  void afterBuild() {
    print("afterBuild");
    Size itemSize = SizeUtil.getSizeByKey(selectedGlobalKey);
    print("itemSize : $itemSize");
    width = itemSize.width;
    height = itemSize.height;
    setState(() {
      
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 3500),
            curve: Curves.ease,
            top: 0,
            left: 0,
            width: width,
            height: height,
            child: Container(
              color: widget.selectedItemBackgroundColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: contentChildren,
          )
        ],
      ),
    );
  }

  void moveNextMenuItem() async {
  }
}
//
// class RoundTabBarPage extends StatefulWidget {
//   RoundTabBarPage({Key? key}) : super(key: key);
//
//   @override
//   _RoundTabBarPageState createState() => _RoundTabBarPageState();
// }
//
// class _RoundTabBarPageState extends State<RoundTabBarPage> {
//   final int pageCount = 4;
//   late PageController _controller = PageController(initialPage: 3);
//   CustomTabBarController _tabBarController = CustomTabBarController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Widget getTabbarChild(BuildContext context, int index) {
//     return TabBarItem(
//         transform: ColorsTransform(
//             highlightColor: Colors.white,
//             normalColor: Colors.black,
//             builder: (context, color) {
//               return Container(
//                 padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                 alignment: Alignment.center,
//                 constraints: BoxConstraints(minWidth: 60),
//                 child: (Text(
//                   index == 2 ? 'Tab522222' : 'Tab$index',
//                   style: TextStyle(fontSize: 14, color: color),
//                 )),
//               );
//             }),
//         index: index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Round Indicator')),
//       body: Column(
//         children: [
//           CustomTabBar(
//             tabBarController: _tabBarController,
//             height: 35,
//             itemCount: pageCount,
//             builder: getTabbarChild,
//             indicator: RoundIndicator(
//               color: Colors.red,
//               top: 2.5,
//               bottom: 2.5,
//               left: 2.5,
//               right: 2.5,
//               radius: BorderRadius.circular(15),
//             ),
//             pageController: _controller,
//           ),
//           Expanded(
//               child: PageView.builder(
//                   controller: _controller,
//                   itemCount: pageCount,
//                   itemBuilder: (context, index) {
//                     return PageItem(index);
//                   })),
//           TextButton(
//               onPressed: () {
//                 _tabBarController.animateToIndex(3);
//               },
//               child: Text('gogogo'))
//         ],
//       ),
//     );
//   }
// }
// class PageItem extends StatefulWidget {
//   final int index;
//   PageItem(this.index, {Key? key}) : super(key: key);
//
//   @override
//   _PageItemState createState() => _PageItemState();
// }
//
// class _PageItemState extends State<PageItem>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     print('build index:${widget.index} page');
//     return Container(
//       // color: Colors.pink,
//       child: Text('index:${widget.index}'),
//       alignment: Alignment.center,
//     );
//   }
//
//   @override
//   // bool get wantKeepAlive => false;
//   bool get wantKeepAlive => true;
// }
