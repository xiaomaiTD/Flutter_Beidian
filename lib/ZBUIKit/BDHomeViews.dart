import 'package:zbflutter/Global/ZBGlobalHeader.dart';
import 'package:zbflutter/ZBUIKit/Items.dart';
import 'package:zbflutter/Module/BDProductDetail.dart';

getDoubleBlockItem(var cellModel) {
  List blocks = cellModel.data;

  List leftImages = blocks.first['items'];
  List rightImages = blocks.last['items'];

  return Row(children: <Widget>[
    Expanded(
      child: getProductBlock(ZBSafe.getSafeString(blocks.first, 'title', ''),
          ZBSafe.getSafeString(blocks.first, 'sub_title', ''), leftImages),
    ),
    Container(
      height: 120,
      width: 0.5,
      color: BDColor.spaceColor,
    ),
    Expanded(
      child: getProductBlock(ZBSafe.getSafeString(blocks.last, 'title', ''),
          ZBSafe.getSafeString(blocks.last, 'sub_title', ''), rightImages),
    )
  ]);
}

getProductBlock(String title, String subTitle, List info) {
  return Container(
    height: 120,
    color: Colors.white,
    child: Wrap(
      children: <Widget>[
        Row(
          children: <Widget>[
            //title
            Container(
                margin: EdgeInsets.only(top: 10, left: 12),
                alignment: Alignment.centerLeft,
                height: 28,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                )),
            //subTitle
            Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                margin: EdgeInsets.only(top: 8, left: 12),
                alignment: Alignment.centerLeft,
                height: 16,
                decoration: new BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: new Border.all(
                      width: 0.5, color: BDColor.beidianRedColor),
                  borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                ),
                child: Text(
                  subTitle,
                  style:
                      TextStyle(fontSize: 10, color: BDColor.beidianRedColor),
                ))
          ],
        ),
        //两个商品
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  height: 70 + 6 + 7.5,
                  margin: EdgeInsets.only(top: 6, left: 12),
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child: getImageTest(info.first['img'], info.first['price'])),
            ),
            Expanded(
              child: Container(
                  height: 70 + 6 + 7.5,
                  margin: EdgeInsets.only(top: 6, right: 12),
                  color: Colors.white,
                  alignment: Alignment.topRight,
                  child: getImageTest(info.last['img'], info.last['price'])),
            )
          ],
        )
      ],
    ),
  );
}

getImageTest(String img, String text) {
  var imageText = Stack(
    alignment: const Alignment(0.1, 1.1),
    children: <Widget>[
      Image.network(
        img,
        width: 70,
        height: 70,
      ),
      Container(
        padding: EdgeInsets.only(left: 4, right: 4),
        decoration: new BoxDecoration(
          color: Color(0xFFFDEDEF),
          borderRadius: new BorderRadius.all(new Radius.circular(9.0)),
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: BDColor.beidianRedColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            )),
      )
    ],
  );
  return imageText;
}

getProductItem(var cellModel, BuildContext context) {
  var productInfo = cellModel.data;
  var rowHeight = ZBDevice.scaleHeight(350.0, context) + 97 + 8;
  var imageItem =
      BDCells.imageScaleCell(productInfo['rect_img'], 350.0, context);

  List<Widget> infos = [];
  if (productInfo['title'] != null) {
    infos.add(BDCells.spaceCell(12, Colors.white));

    var text = new Text(productInfo['title'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis);

    infos.add(Container(
      margin: EdgeInsets.only(left: 3, right: 12),
      child: text,
    ));
  }
  if (productInfo['desc'] != null) {
    infos.add(BDCells.spaceCell(6, Colors.white));

    var text = new Text(productInfo['desc'],
        style: TextStyle(
          fontSize: 12.0,
          color: Color(0xFF8F8F8F),
        ),
        maxLines: 1,
        overflow: TextOverflow.clip);

    infos.add(Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: text,
    ));

    infos.add(Container(
      height: 13.5,
      color: Colors.white,
    ));

    infos.add(Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12),
            height: 21,
            color: Colors.white,
            child: RealRichText([
              TextSpan(
                text: "￥138 ",
                style: TextStyle(color: Color(0xFF2E2E33), fontSize: 18),
              ),
              TextSpan(
                text: "赚 ",
                style: TextStyle(color: BDColor.beidianRedColor, fontSize: 13),
              ),
              TextSpan(
                text: "20",
                style: TextStyle(color: BDColor.beidianRedColor, fontSize: 18),
              ),
            ]),
          ),
        ),
        Container(
            margin: EdgeInsets.only(right: 12),
            height: 21,
            width: 44,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: new Border.all(width: 0.5, color: Color(0xCC333333)),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
            ),
            child: Text(
              '分享',
              style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
            ))
      ],
    ));
  }

  var titleItem = Container(
      height: 97,
      color: Colors.white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: infos));
  var spaceItem = BDCells.spaceCell(8, BDColor.spaceColor);

  return BDCells.containerCell(
      [imageItem, titleItem, spaceItem], rowHeight, context);
}

getNavigationBar(BuildContext context) {
  var bar = new AppBar(
    title: new Image.asset(
      'images/img_shop_logo.png',
      width: 43.0,
      height: 26.0,
      fit: BoxFit.fitWidth,
    ),
    leading: new Container(
      width: 34,
      height: 20,
      padding: EdgeInsets.only(left: 12, top: 15, bottom: 15),
      child: new Image.asset(
        'images/img_shop_information.png',
        width: 22.0,
        height: 22.0,
        fit: BoxFit.fitHeight,
      ),
    ),
    actions: <Widget>[
      new GestureDetector(
        child: new Container(
            width: 34,
            height: 30,
            padding: EdgeInsets.only(right: 12),
            child: new Image.asset(
              'images/ic_shop_seek.png',
              width: 22.0,
              height: 22.0,
              fit: BoxFit.contain,
            )),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return BDProductDetailWidget(product: '你好啊');
          }));
        },
      )
    ],
  );
  return bar;
}

Widget getTimeSegmenCell(var cellModel, BuildContext context) {
  var datas = [
    {"title": "21:00", "desc": "昨日精选"},
    {"title": "8:00", "desc": "已开枪"},
    {"title": "9:00", "desc": "抢购中"},
    {"title": "10:00", "desc": "即将开场"},
    {"title": "11:00", "desc": "即将开场"},
    {"title": "13:00", "desc": "即将开场"},
    {"title": "15:00", "desc": "即将开场"},
    {"title": "17:00", "desc": "即将开场"},
    {"title": "19:00", "desc": "即将开场"}
  ];

  Widget getItem(String title, String desc) {
    bool atNow = desc == "抢购中";
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 8.5, bottom: 4),
            height: 18,
            child: Text(
              title,
              style: TextStyle(
                  color: atNow ? BDColor.beidianRedColor : Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            )),
        Expanded(
          child: Container(
              height: 11,
              child: Text(
                desc,
                style: TextStyle(
                    color: atNow ? BDColor.beidianRedColor : Color(0xFF8F8F8F),
                    fontSize: 11),
              )),
        )
      ],
    );
  }

  getListViewItem(data) {
    return GestureDetector(
        onTap: () {
          ZBToast.show(data['title']);
        },
        child: Container(
          color: Colors.white,
          height: 50,
          width: 80,
          child: getItem(data['title'], data['desc']),
        ));
  }

  var listView = ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: datas.length,
    itemBuilder: (BuildContext context, int position) {
      return getListViewItem(datas[position]);
    },
  );

  return Container(
    color: Colors.white,
    height: 50,
    child: listView,
  );
}
