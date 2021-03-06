import 'package:zbflutter/Global/ZBGlobalHeader.dart';

//------------- StateWidget
class ZBSegmentView extends StatefulWidget {
  final List<String> titles;
  final Color defaultColor = Colors.black;
  final Color seletedColor = BDColor.beidianRedColor;
  final ValueChanged<SegmentViewItem> onItemChange;
  final int itemIndex;

  ZBSegmentView(
      {Key key, @required this.titles, this.onItemChange, this.itemIndex})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new _SegmentViewState();
}

//------------- State

class _SegmentViewState extends State<ZBSegmentView> {
//------------- property
  ListView _listView;
  ScrollController _scrollController = new ScrollController();
  List<SegmentViewItem> _items = [];

//------------- life cycle
  @override
  void initState() {
    _handleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this._getContentView();
  }
//------------- API

//------------- Event Response

//------------- privite
  void _handleData() {
    int idx = 0;
    for (String title in widget.titles) {
      SegmentViewItem item = SegmentViewItem(title, false);
      item.index = idx;
      _items.add(item);
      idx++;
    }
  }

  Widget _getContentView() {
    _listView = ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int position) {
          return this._getItem(_items[position]);
        });

    return Container(
      height: 41,
      margin: EdgeInsets.only(left: 12),
      child: _listView,
    );
  }

  Widget _getItem(SegmentViewItem item) {
    Color color;    
    if (item.index == widget.itemIndex) {
      color = widget.seletedColor;
      this.setItemWithIdx(widget.itemIndex);
    } else {
      color = widget.defaultColor;
    }

    return GestureDetector(
      child: Container(
          key: item.gkey,
          height: 41,
          width: 56,
          margin: EdgeInsets.only(right: 22),
          alignment: Alignment.center,
          child: Text(
            item.displayName,
            style: TextStyle(
                color: color, fontSize: 14, fontWeight: FontWeight.w700),
          )),
      onTap: () {
        this._handleTap(item);
      },
    );
  }

  void _handleTap(SegmentViewItem item) {
    setState(() {
      setItemWithIdx(item.index);
      widget.onItemChange(item);
    });
  }

  void setItemWithIdx(int index) {
    if (index == null) {
      index = 0;
    }
    if (_listView.controller != null) {
      double itemWidt = 56.0 + 22; //TODO: 这个宽度可以动态化
      double contentSizeW = widget.titles.length * itemWidt;
      double currentOffset = 0;
      double viewWidth = ZBDevice.width(context) - 12;

      if (contentSizeW - viewWidth > 0) {
        if (index == 0) {
          currentOffset = 0;
        } else {
          double targetItemLeft = itemWidt * (index - 1);
          double v = contentSizeW - viewWidth;
          currentOffset = targetItemLeft - v > 0 ? v : targetItemLeft;
        }
        _listView.controller.animateTo(currentOffset,
            duration: kAnimateTime, curve: Curves.easeInOut);
      }
    }
  }
}

class SegmentViewItem {
  String displayName = "";
  bool seleted = false;
  int index = 0;
  GlobalKey gkey = new GlobalKey();
  SegmentViewItem(this.displayName, this.seleted);
}
