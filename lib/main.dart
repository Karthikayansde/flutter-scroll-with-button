import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Scaffold(body: ItemScroller(data: [],)),debugShowCheckedModeBanner: false,));
}



class ItemScroller extends StatefulWidget {
  List<List> data;

  ItemScroller({
    super.key,
    required this.data,
  });

  @override
  State<ItemScroller> createState() => _ItemScrollerState();
}

class _ItemScrollerState extends State<ItemScroller> {

  bool rState = true;
  final ScrollController _scrollController = ScrollController();
  Color leftButtonColor = Colors.grey;
  Color rightButtonColor = Colors.black;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.position.maxScrollExtent > 0) {
        // rState = true;
      } else {
        setState(() {
          rState = false;
        });
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.offset == 0) {
        setState(() {
          leftButtonColor = Colors.grey; // No more content to scroll right
        });
      } else {
        setState(() {
          leftButtonColor = Colors.black; // Can scroll left
        });
      }

      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        setState(() {
          rightButtonColor = Colors.grey; // No more content to scroll right
        });
      } else {
        setState(() {
          // if (rState) {
          rightButtonColor = Colors.black; // Can scroll right
          // }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 130.0,//MyWidgetSize.offSet,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 3, // Blur radius
                              offset: const Offset(0, 1), // Offset of the shadow
                            ),
                          ],
                          color: Colors.white, // Background color of the container
                          borderRadius: BorderRadius.circular(5), // Optional: Add rounded corners
                        ),
                        width: 35,
                        height: 60,
                        child: Icon(Icons.arrow_back_ios_new, color: leftButtonColor),
                      ),
                    ),
                  ),
    Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.black26,
                                      height: 115,
                                      width: 120,
                                      child: Image.network(
                                        "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                      child: Center(child: Text("widget.data[index][0] ??)"),
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 130, // Adjust the offset to scroll one card at a time
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 3, // Blur radius
                              offset: const Offset(0, 1), // Offset of the shadow
                            ),
                          ],
                          color: Colors.white, // Background color of the container
                          borderRadius: BorderRadius.circular(5), // Optional: Add rounded corners
                        ),
                        width: 35,
                        height: 60,
                        child: Icon(Icons.arrow_forward_ios, color: rState ? rightButtonColor : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}