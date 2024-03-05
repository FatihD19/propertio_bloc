import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';

class NavigationButton extends StatefulWidget {
  final int lastPage;
  int? currentPage;
  final Function(int) implementLogic;

  NavigationButton(
      {required this.lastPage, this.currentPage, required this.implementLogic});

  @override
  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.currentPage == 1
                ? null
                : () => setPage(widget.currentPage! - 1),
          ),
          SizedBox(width: 10),
          Row(
            children: List.generate(
              widget.lastPage,
              (index) => ElevatedButton(
                onPressed: () => setPage(index + 1),
                child: Text('${index + 1}',
                    style: widget.currentPage == index + 1
                        ? buttonTextStyle
                        : primaryTextStyle),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  minimumSize: Size(50, 50),
                  backgroundColor:
                      widget.currentPage == index + 1 ? primaryColor : null,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: widget.currentPage == widget.lastPage
                ? null
                : () => setPage(widget.currentPage! + 1),
          ),
        ],
      ),
    );
  }

  void setPage(int page) {
    setState(() {
      widget.currentPage = page;
    });
    widget.implementLogic(page); // Call custom logic function
  }
}
