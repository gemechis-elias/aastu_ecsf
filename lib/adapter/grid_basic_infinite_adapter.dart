import 'package:flutter/material.dart';

class GridBasicInfiniteAdapter {
  List? items = <String>[];
  List itemsTile = <ItemTile>[];
  Function? onLoadMore;
  late Function onItemClick;

  GridBasicInfiniteAdapter(this.items, onItemClick) {
    this.onItemClick = onItemClick;
    for (var i = 0; i < items!.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items![i], onClick: this.onItemClick));
    }
  }

  void addItems(List<String> items){
    int length = this.items!.length;
    this.items!.addAll(items);
    for (var i = length; i < this.items!.length; i++) {
      itemsTile.add(ItemTile(index: i, object: this.items![i], onClick: this.onItemClick));
    }
  }

  void setOnLoadMore(Function onLoadMore){
    this.onLoadMore = onLoadMore;
  }

  void setLoading(){
    int length = this.items!.length;
    this.items!.add("#LOADING#");
    itemsTile.add(ItemTile(index: length, object: this.items!.last, onClick: this.onItemClick));
  }

  void setLoaded(){
    if(this.items!.last == "#LOADING#") {
      this.items!.removeLast();
      this.itemsTile.removeLast();
    }
  }

  Widget getView() {
    return NotificationListener(
      child: GridView.builder(
        itemCount: itemsTile.length,
        padding: EdgeInsets.all(3),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            crossAxisCount: 2
        ),
        itemBuilder: (BuildContext context, int index) {
          return itemsTile[index];
        },
      ),
      onNotification: (dynamic scrollState) {
        if (scrollState is ScrollEndNotification && scrollState.metrics.pixels == scrollState.metrics.extentBefore) {
          if(onLoadMore != null) onLoadMore!(this.items!.length);
        }
        return false;
      },
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final String object;
  final int index;
  final Function onClick;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
    required this.onClick,
  })  : super(key: key);

  void onItemClick(String obj) {
    onClick(index, obj);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = object == "#LOADING#";
    return !isLoading ? Stack(
      children: <Widget>[
        Image.asset(
          object,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
              highlightColor: Colors.black.withOpacity(0.1),
              splashColor: Colors.black.withOpacity(0.1),
              onTap: () {
                onItemClick(object);
              },
              child: Container(
                  height: double.infinity,
                  width: double.infinity
              )
          ),
        ),
      ],
    ) : Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            transform: Matrix4.translationValues(18, 0, 0),
            width: 30, height: 30,
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
