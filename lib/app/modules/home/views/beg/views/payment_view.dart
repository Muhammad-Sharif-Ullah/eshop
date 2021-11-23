import 'package:eshop/app/modules/home/views/beg/views/payment_edit_view.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt currentCard = 1.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your payment cards'),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemCount: 2,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CreditCardWidget(
                      cardNumber: "44594",
                      expiryDate: "kk",
                      cardHolderName: "Md. Sharif Ullah",
                      cvvCode: "kkd",
                      showBackView: false, //
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      // cardBgColor: AppColors.backgroundDark,
                    ),
                    Obx(() => CheckboxListTile(
                          value: currentCard.value == index ? true : false,
                          title: Text('Use as default payment method'),
                          activeColor:
                              context.isDarkMode ? Colors.white : Colors.black,
                          checkColor:
                              !context.isDarkMode ? Colors.white : Colors.black,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (newValue) => currentCard.value = index,
                        )),
                  ],
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => PaymentEditView()),
        elevation: 10,
        backgroundColor: context.isDarkMode ? Colors.white : Colors.black,
        child: Icon(Icons.add,
            color: !context.isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
