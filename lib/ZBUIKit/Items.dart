import 'package:zbflutter/Global/ZBGlobalHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:banner/banner.dart';

class BDBaseCellModel {
  var index = 0;
  var identifier = "";
  var data;

  BDBaseCellModel(this.identifier, this.data);
}

class BDCells {
  static Container containerCell(
      List<Widget> children, double height, BuildContext context) {
    var container = Container(
      height: height,
      color: Colors.white,
      width: ZBDevice.width(context),
      child: Wrap(
        spacing: 0,
        runSpacing: 0,
        children: children,
      ),
    );

    return container;
  }

  static Container imageScaleCell(url, double height, BuildContext context) {
    var image = FadeInImage.assetNetwork(
      placeholder: kPlaceholderImageNameLarge,
      image: url,
      fit: BoxFit.fill,
      width: ZBDevice.width(context),
      height: ZBDevice.scaleHeight(height, context),
    );

    return Container(
        color: Colors.white,
        height: ZBDevice.scaleHeight(height, context),
        child: image);
  }

  static Container spaceCell(double heiht, Color color) {
    var space = Container(
      height: 8,
      color: color == null ? BDColor.spaceColor : color,
    );
    return space;
  }

  static Container bannerCell(
      List urls, double height, double aspecRatio, BuildContext context) {
    var banner = Container(
      color: Colors.white,
      child: new BannerView(
        data: urls,
        height: height,
        buildShowView: (index, data) {
          return new Container(
              height: ZBDevice.scaleHeight(300, context),
              color: Colors.black,
              child: new AspectRatio(
                aspectRatio: aspecRatio,
                child: new Image.network(data),
              ));
        },
        onBannerClickListener: (index, data) {},
      ),
    );
    return banner;
  }

  static blockCell(List infos, BuildContext context) {
    List<Widget> items = [];

    for (Map item in infos) {
      String imageURLStr = ZBSafe.getSafeString(item, 'url', '');
      String title = ZBSafe.getSafeString(item, 'title', '');

      var image = FadeInImage.assetNetwork(
        height: 40,
        placeholder: kPlaceholderImageNameMiddle,
        image: imageURLStr,
        fit: BoxFit.contain,
      );

      items.add(Expanded(
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 8), height: 48, child: image),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: Text(
                title,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )));
    }

    var blocks = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items,
    );
    return blocks;
  }
}
