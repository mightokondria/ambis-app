import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Invoice.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class PaymentMethods extends StatefulWidget {
  final API api;

  const PaymentMethods({Key key, this.api}) : super(key: key);

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState(api);
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final API api;
  List<PaymentModel> data = [];

  _PaymentMethodsState(this.api);

  @override
  initState() {
    if (api.payments == null)
      api.request(path: "invoice/get_methods").then((value) {
        List<dynamic> result = jsonDecode(value.body);

        api.payments = result.map((e) => PaymentModel.fromJson(e)).toList();
        setState(() {
          data = api.payments;
        });
      });
    else
      setState(() {
        data = api.payments;
      });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final dim = (constraints.maxWidth / data.length) - 10;

      return PaymentMethodElement(data: data, dim: dim);
    });
  }
}

class PaymentMethodElement extends StatelessWidget {
  const PaymentMethodElement({
    Key key,
    @required this.data,
    @required this.dim,
  }) : super(key: key);

  final List<PaymentModel> data;
  final double dim;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      child: Container(
        width: double.infinity,
        child: Wrap(
            spacing: 5,
            children: data
                .map((e) => Container(
                    width: dim,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(
                        //     color: Colors.blue.withOpacity(.8), width: 2),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 3),
                              blurRadius: 6,
                              color: Colors.black.withOpacity(.05))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Image.network(
                      "https://api.mentoring.web.id/files/method/" + e.logo,
                      width: 60,
                    ))))
                .toList()),
      ),
    );
  }
}
