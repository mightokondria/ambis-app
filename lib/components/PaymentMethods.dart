import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/api/models/Invoice.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class PaymentMethods extends StatefulWidget {
  final API api;

  const PaymentMethods({Key key, this.api}) : super(key: key);

  @override
  PaymentMethodInstance createState() => PaymentMethodInstance(api);
}

class PaymentMethodInstance extends State<PaymentMethods> {
  final API api;
  List<PaymentModel> data = [];

  PaymentMethodInstance(this.api);

  @override
  initState() {
    if (api.payments == null)
      api.request(path: "invoice/get_methods").then((value) {
        List<dynamic> result = jsonDecode(value.body);

        api.payments = result.map((e) => PaymentModel.fromJson(e)).toList();
        api.payments[0].selected = true;

        setState(() {
          data = api.payments;
        });
      });
    else
      setState(() {
        data = api.payments;
      });
  }

  PaymentModel getAnswer() {
    PaymentModel selected;

    data.forEach((element) {
      if (element.selected) selected = element;
    });

    return selected;
  }

  select(int index) {
    setState(() {
      data = data.map((e) {
        e.selected = false;
        return e;
      }).toList();
      data[index].selected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    api.paymentInstance = this;

    return LayoutBuilder(builder: (context, constraints) {
      final dim = (constraints.maxWidth / data.length) - 10;

      return PaymentMethodElement(
          data: data, dim: dim, parent: this, api: api.defaultAPI);
    });
  }
}

class PaymentMethodElement extends StatelessWidget {
  const PaymentMethodElement({
    Key key,
    @required this.data,
    @required this.dim,
    @required this.parent,
    this.api,
  }) : super(key: key);

  final List<PaymentModel> data;
  final double dim;
  final PaymentMethodInstance parent;
  final String api;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Wrap(
            spacing: 5,
            children: Helpers.mapIndexed(
                data,
                (i, e) => Clickable(
                      child: GestureDetector(
                        onTap: () {
                          parent.select(i);
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 100),
                            width: dim,
                            height: 100,
                            decoration: BoxDecoration(
                                color: e.selected
                                    ? Color(0xfff2f3ff)
                                    : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(3, 3),
                                      blurRadius: 6,
                                      color: Colors.black.withOpacity(.05))
                                ],
                                border: e.selected
                                    ? Border.all(
                                        color: Color(0xFF66B0FF), width: 2)
                                    : null,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Image.network(
                              "${api}files/method/" + e.logo,
                              width: dim * .4,
                            ))),
                      ),
                    )).toList()));
  }
}
