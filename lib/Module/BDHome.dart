import 'package:zbflutter/Global/ZBGlobalHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:zbflutter/ZBUIKit/Items.dart';
import 'package:zbflutter/ZBUIKit/BDHomeViews.dart';
import 'package:zbflutter/ZBUIKit/ZBSegmentView.dart';

//------------- StateWidget
class BDHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '贝店',
      color: Colors.red,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomeApp(title: '贝店'),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  final String title;
  MyHomeApp({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyHomeAppState();
  }
}
//------------- State

class _MyHomeAppState extends State<MyHomeApp> {
//------------- property

  List datas = [];
  List subDatas = [];
  List<String> titles = [
    "今日特卖",
    "新品",
    "居家",
    "服饰",
    "水果",
    "美食",
    "美妆",
    "母婴",
    "最后疯抢",
    "贝店周边"
  ];
  PageController _pageController = PageController();
  int topSegmentViewItemIndex = 0;

//------------- life cycle
  @override
  void initState() {
    this.featchHomePageData(kHomePageRequest, this.datas);
    this.featchHomePageData(kHomeSubPageRequest, this.subDatas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getNavigationBar(context), body: getBody());
  }

//------------- Event Response
  _segmentViewItemChange(SegmentViewItem item) {
    if (_pageController != null) {
      _pageController.animateToPage(item.index,
          duration: kAnimateTime, curve: Curves.easeInOut);
    }
    this.topSegmentViewItemIndex = item.index;
  }

  _pageControllerPageChanged(int index) {
    setState(() {
      this.topSegmentViewItemIndex = index;
    });
  }
//------------- privite

  getBody() {
    var topSegmentView = new ZBSegmentView(
      titles: titles,
      onItemChange: _segmentViewItemChange,
      itemIndex: topSegmentViewItemIndex,
    );

    var listView = Container(
      width: ZBDevice.width(context),
      margin: EdgeInsets.all(0),
      child: getListViewBody(this.datas),
    );

    var subListView = Container(
      width: ZBDevice.width(context),
      margin: EdgeInsets.all(0),
      child: getListViewBody(this.subDatas),
    );

    var page = PageView.builder(
        controller: _pageController,
        onPageChanged: _pageControllerPageChanged,
        itemCount: titles.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Widget content = index == 0 ? listView : subListView;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: content,
          );
        });

    var content = Column(
      children: <Widget>[
        topSegmentView,
        Expanded(
          child: page,
        )
      ],
    );
    return content;
  }

  featchHomePageData(String requestURLStr, List data) async {
    try {
      Future.wait([ZBNetwork.sendRequestGet(requestURLStr)])
          .then((dynamic result) {
        setState(() {
          var jsonData = result[0];
          if (jsonData["banners"] != null) {
            List banners = jsonData["banners"];
            if (banners.length > 0) {
              data.add(BDBaseCellModel("banners", banners));
            }
          }
          if (jsonData["ads"] != null) {
            List ads = jsonData["ads"];
            if (ads.length > 0) {
              data.add(BDBaseCellModel("ads", ads));
            }
          }
          if (jsonData["hotspots_ad"] != null) {
            data.add(BDBaseCellModel("hotspots_ad", jsonData["hotspots_ad"]));
            data.add(BDBaseCellModel("space", 8.0));
          }
          if (jsonData["block_ad"] != null) {
            List blockData = jsonData["block_ad"];
            if (blockData.length == 2) {
              data.add(BDBaseCellModel("block_ad", blockData));
              data.add(BDBaseCellModel("space", 8.0));
            }

            data.add(BDBaseCellModel("time", null));
          }

          List items = jsonData['items'];
          if (items.length > 0) {
            for (var item in items) {
              data.add(BDBaseCellModel("product", item));
            }
          }
        });
      });
    } catch (e) {
      return print(e);
    }
  }

  getListViewItemForItem(var subject) {
    BDBaseCellModel cellModel = subject;
    if (cellModel.identifier == "space") {
      return BDCells.spaceCell(cellModel.data, BDColor.spaceColor);
    }
    if (cellModel.identifier == "banners") {
      return BDCells.bannerCell(cellModel.data, 300, 750 / 300, context);
    }
    if (cellModel.identifier == "ads") {
      return BDCells.blockCell(cellModel.data, context);
    }
    if (cellModel.identifier == "hotspots_ad") {
      return BDCells.imageScaleCell(
          cellModel.data['url'], cellModel.data['height'] / 1.0, context);
    }
    if (cellModel.identifier == "block_ad") {
      return getDoubleBlockItem(cellModel);
    }
    if (cellModel.identifier == "product") {
      return getProductItem(cellModel, context);
    }
    if (cellModel.identifier == "time") {
      return getTimeSegmenCell(cellModel, context);
    }
    return Container();
  }

  getListViewBody(List data) {
    if (data.length != 0) {
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int position) {
            return getListViewItemForItem(data[position]);
          });
    } else {
      return CupertinoActivityIndicator();
    }
  }
}
