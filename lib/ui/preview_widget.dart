import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/favorite_button.dart';
import 'package:propertio_mobile/ui/component/search_form.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';
import 'package:propertio_mobile/ui/view/alamat_info_view.dart';
import 'package:propertio_mobile/ui/view/description_info_view.dart';
import 'package:propertio_mobile/ui/view/detail_info_view.dart';
import 'package:propertio_mobile/ui/view/detail_overview_view.dart';
import 'package:propertio_mobile/ui/view/headline_properti_view.dart';
import 'package:propertio_mobile/ui/widgets/agent_card.dart';
import 'package:propertio_mobile/ui/widgets/new_properti_card.dart';
import 'package:propertio_mobile/ui/widgets/progress_properti.dart';

import 'package:propertio_mobile/ui/widgets/properti_card.dart';
import 'package:propertio_mobile/ui/widgets/proyek_card.dart';
import 'package:propertio_mobile/ui/widgets/review_card.dart';
import 'package:propertio_mobile/ui/widgets/small_proyek_card.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  int _sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            ProgressProperti(27),
            Slider(
              // 10
              min: 1,
              max: 10,
              divisions: 9,
              // 11
              label: '${_sliderVal} servings',
              // 12
              value: _sliderVal.toDouble(),
              // 13
              onChanged: (newValue) {
                setState(() {
                  _sliderVal = newValue.round();
                });
              },
              // 14
              activeColor: primaryColor,
              inactiveColor: secondaryColor,
            ),
            CustomTextField(
              title: 'Title',
              mandatory: true,
              hintText: 'Hint Text',
            ),
            SizedBox(height: 24),
            CustomButton(text: 'Login', onPressed: () {}),
            SizedBox(height: 24),
            SearchForm(),
            DescriptionView(
                description:
                    'Lorem ipsum dolor sit amet consectetur. Quis in mauris tellus etiam ultrices eget. Elit natoque ornare id at eget. Fames egestas libero accumsan vitae nibh. Id eget elit porta nec. Maecenas mi neque non gravida. Erat maecenas aliquam sit imperdiet malesuada. Tortor ipsum dignissim ac enim lacinia nulla nisl arcu elementum. Mi malesuada pharetra est elementum eu porttitor. Tortor malesuada in a proin.'),
            SizedBox(height: 24),
            DetailInfoView(listInfo: [
              RowTextInfo(title: 'Unit Kode', value: 'Pasd'),
              RowTextInfo(title: 'Unit Kode', value: 'asd'),
              RowTextInfo(title: 'Harga unit', value: 'Rp. 900000'),
              RowTextInfo(title: 'Harga unit', value: 'Rp. 900000'),
              RowTextInfo(title: 'Harga unit', value: 'Rp. 900000'),
            ]),
            SizedBox(height: 24),
            AlamatInfoView([
              RowTextInfo(title: 'Unit Kode', value: 'Pasd'),
              RowTextInfo(title: 'Unit Kode', value: 'asd'),
              RowTextInfo(title: 'Harga unit', value: 'Rp. 900000'),
              RowTextInfo(title: 'Harga unit', value: 'Rp. 900000'),
            ]),
            SizedBox(height: 24),
            HeadlinePropertiView(),
            SizedBox(height: 24),
            FavoriteButton(),
            SizedBox(height: 24),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 16),
            //   decoration: BoxDecoration(
            //     color: secondaryColor,
            //   ),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         SmallProyekCard(
            //           'LSE perlao',
            //           'menteng kebun jeruk',
            //           'Rp. 90000',
            //           'assets/img_small_properti.png',
            //           isUnit: true,
            //         ),
            //         SmallProyekCard(
            //           'LSE perlao',
            //           'menteng kebun jeruk',
            //           'Rp. 90000',
            //           'assets/img_small_properti.png',
            //           isFavorite: false,
            //         ),
            //         SmallProyekCard('LSE perlao', 'menteng kebun jeruk',
            //             'Rp. 90000', 'assets/img_small_properti.png'),
            //         SmallProyekCard('LSE perlao', 'menteng kebun jeruk',
            //             'Rp. 90000', 'assets/img_small_properti.png'),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 24),
            DetailOverView(),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       AgentCard('den armanda', 'banyuwangi, jawa timur',
            //           'assets/img_agent.png'),
            //       AgentCard('den armanda', 'banyuwangi, jawa timur',
            //           'assets/img_agent.png'),
            //       AgentCard('den armanda', 'banyuwangi, jawa timur',
            //           'assets/img_agent.png')
            //     ],
            //   ),
            // ),
            SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ReviewCard(),
                  ReviewCard(),
                  ReviewCard(),
                ],
              ),
            ),
            SizedBox(height: 24),
            // NewPropertiCard(),
            SizedBox(height: 24),
            // PropertiCard(isFavorite: true),
            // SizedBox(height: 24),
            // PropertiCard(hideAgent: true),
            SizedBox(height: 24),
            // ProyekCard(isFavorite: true),
            // SizedBox(height: 24),
            // ProyekCard(hideAgent: true)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
