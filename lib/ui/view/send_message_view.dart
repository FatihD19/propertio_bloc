import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/sendMessage/send_message_bloc.dart';
import 'package:propertio_mobile/data/model/agent_model.dart';
import 'package:propertio_mobile/data/model/developer_model.dart';
import 'package:propertio_mobile/data/model/request/send_message_request_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/bottom_modal.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';
import 'package:propertio_mobile/ui/view/listile_agen.dart';

class ModalInformasi extends StatefulWidget {
  AgentModel? agent;
  DeveloperModel? developer;
  String? propertyCode;
  String? projectCode;

  ModalInformasi(
      {this.developer,
      this.agent,
      this.propertyCode,
      this.projectCode,
      super.key});

  @override
  State<ModalInformasi> createState() => _ModalInformasiState();
}

class _ModalInformasiState extends State<ModalInformasi> {
  TextEditingController nameController =
      TextEditingController(text: 'polcmsekke');
  TextEditingController phoneController =
      TextEditingController(text: '08199023456789');
  TextEditingController emailController =
      TextEditingController(text: 'mke900looppl@mail.cs');
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Text(
            'Dapatkan informasi lebih lanjut',
            style: primaryTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 16),
          widget.agent != null
              ? ListileAgent(agent: widget.agent)
              : ListileDeveloper(developer: widget.developer),
          SizedBox(height: 16),
          CustomTextField(
            controller: nameController,
            title: 'Nama Lengkap',
            mandatory: true,
            hintText: 'Masukan Nama Lengkap Anda',
          ),
          CustomTextField(
            controller: phoneController,
            title: 'Nomor Telepon',
            mandatory: true,
            hintText: 'Masukan Nomor Telepon Anda',
          ),
          CustomTextField(
            controller: emailController,
            title: 'Email',
            mandatory: true,
            hintText: 'Masukan Email Anda',
          ),
          BlocConsumer<SendMessageBloc, SendMessageState>(
            listener: (context, state) {
              if (state is SendMessageSuccess) {
                succsessDialog(context, 'Pesan Berhasil Terkirim',
                    () => Navigator.pop(context));
                // showMessageModal(context, 'sukses');
              }
              if (state is SendMessageError) {
                showMessageModal(context, 'error');
              }
            },
            builder: (context, state) {
              if (state is SendMessageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return CustomButton(
                  text: 'Mohon Informasi Lebih Lanjut',
                  onPressed: () {
                    // if (nameController.text.isEmpty ||
                    //     phoneController.text.isEmpty ||
                    //     emailController.text.isEmpty) {
                    //   showMessageModal(context, 'Data tidak boleh kosong');
                    // }
                    print(nameController.text);
                    print(phoneController.text);
                    print(emailController.text);
                    print(widget.propertyCode);

                    widget.projectCode != null
                        ? context.read<SendMessageBloc>().add(OnSendMessage(
                            sendMessageProject: SendMessageProjectRequestModel(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                projectCode: widget.projectCode)))
                        : context.read<SendMessageBloc>().add(OnSendMessage(
                                sendMessageProperty:
                                    SendMessagePropertyRequestModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                              propertyCode: widget.propertyCode,
                            )));
                  });
            },
          )
        ],
      ),
    );
  }
}
