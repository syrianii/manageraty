import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerWidget extends StatelessWidget {
 // ShimmerWidget({Key key, @required this.width,@required this.height}) : super(key: key);
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  ShimmerWidget.rectangle({
    @required this.height ,
    @required this.width ,
}) : this.shapeBorder = const RoundedRectangleBorder();

  ShimmerWidget.circle({
    @required this.height,
    @required this.width,
   this.shapeBorder = const CircleBorder(),
});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Colors.grey[100],
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
