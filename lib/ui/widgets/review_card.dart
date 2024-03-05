import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';
import 'package:propertio_mobile/shared/theme.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: customBoxDecoration(),
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kerja bagos',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 12)),
          Container(
            width: 183,
            child: Text(
              '“Lorem ipsum dolor sit amet consectetur. Nisi nulla nibh purus massa. Cursus tincidunt neque enim hendrerit eu enim ut ultricies quis. Nibh ac interdum quis.”',
              style: primaryTextStyle.copyWith(fontSize: 10),
            ),
          ),
          RatingBarIndicator(
            unratedColor: Color(0xffF0DB96),
            rating: 3.0,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Color(0xffFFCB42),
            ),
            itemCount: 5,
            itemSize: 25.0,
            direction: Axis.horizontal,
          ),
          SizedBox(height: 8),
          Container(
            color: secondaryColor,
            height: 1,
            child: SizedBox(width: 183),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset(
                'assets/img_person_review.png',
                width: 36,
                height: 36,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rizky Ramadhan',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 12)),
                  Text('Bandung, Jawa Barat',
                      style: secondaryTextStyle.copyWith(fontSize: 10)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
