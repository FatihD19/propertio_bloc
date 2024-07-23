import 'package:flutter/material.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/data/model/agent_model.dart';
import 'package:propertio_bloc/data/model/developer_model.dart';
import 'package:propertio_bloc/constants/api_path.dart';

import 'package:propertio_bloc/shared/ui/components/container_style.dart';
import 'package:propertio_bloc/pages/Agen/detail_agen_page.dart';

class ListileDeveloper extends StatelessWidget {
  DeveloperModel? developer;
  Function? onTap;
  ListileDeveloper({this.developer, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: customBoxDecoration(),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            ApiPath.image(developer!.pictureProfileFile.toString()),
          ),
        ),
        title: Text(developer!.fullName.toString(),
            style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
        subtitle: Text(
            '${developer?.address.toString()}, ${developer?.city.toString()}, ${developer?.province.toString()}',
            style: secondaryTextStyle.copyWith(fontSize: 12)),
        trailing: GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Image.asset('assets/ic_action_agen.png'),
        ),
      ),
    );
  }
}

class ListileAgent extends StatelessWidget {
  AgentModel? agent;
  Function? onTap;
  ListileAgent({this.agent, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailAgenPage(agent!.accountId.toString())));
      },
      child: Container(
        decoration: customBoxDecoration(),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              ApiPath.image(agent!.pictureProfileFile.toString()),
            ),
          ),
          title: Text(agent!.fullName.toString(),
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          subtitle: Text(
              '${agent?.address.toString()}, ${agent?.city.toString()}, ${agent?.province.toString()}',
              style: secondaryTextStyle.copyWith(fontSize: 12)),
          trailing: GestureDetector(
            onTap: () {
              onTap!();
            },
            child: Image.asset('assets/ic_action_agen.png'),
          ),
        ),
      ),
    );
  }
}
