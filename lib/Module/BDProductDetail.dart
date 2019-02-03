import 'package:zbflutter/Global/ZBGlobalHeader.dart';
class BDProductDetailWidget extends StatelessWidget {

  final String product;
  BDProductDetailWidget({Key key ,@required this.product}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('商详'),
      ),
      body:Center(
        child: Text(product),
      )
    );
  }
}