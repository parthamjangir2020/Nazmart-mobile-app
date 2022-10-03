import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/place_order_service.dart';
import 'package:no_name_ecommerce/view/payments/mercado_pago_payment_page.dart';
import 'package:provider/provider.dart';

class MercadoPagoService {
  payByMercado(BuildContext context) {
    Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MercadopagoPaymentPage(),
      ),
    );
  }
}
