import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/cart/domain/entities/shipping_address.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_state.dart';
import 'package:shop_mobile/core/stripe_service.dart';
import 'package:shop_mobile/features/cart/presentation/pages/check_payment_screen.dart';

class ShippingFormDialog extends StatefulWidget {
  const ShippingFormDialog({super.key});

  @override
  State<ShippingFormDialog> createState() {
    return _ShippingFormDialogState();
  }
}

class MyCustomClass {
  const MyCustomClass();

  Future<void> myAsyncMethod(BuildContext context, String secret) async {
    try {
      final sessionId = await StripeService.instatnce.makePayment(secret);
      if (!context.mounted) return;
      Navigator.of(context).pushNamed(
        CheckPaymentScreen.routeName,
        arguments: sessionId,
      );
    } catch (e) {
      print(e);
    }
  }
}

class _ShippingFormDialogState extends State<ShippingFormDialog> {
  final _form = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredPhone = '';
  var _enteredCountry = '';
  var _enteredCity = '';
  var _enteredLine1 = '';
  var _enteredLine2 = '';
  var _enteredState = '';
  var _enteredPostalCode = '';
  var isSubmit = false;

  void _createPayment() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      BlocProvider.of<PaymentBloc>(context).add(
        CreatePayment(
          ShippingAddressEntity(
            name: _enteredName,
            phone: _enteredPhone,
            country: _enteredCountry,
            city: _enteredCity,
            line1: _enteredLine1,
            line2: _enteredLine2,
            state: _enteredState,
            postalCode: _enteredPostalCode,
          ),
        ),
      );
      isSubmit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Please add your shipping address',
        style: TextStyle(fontSize: 22),
      ),
      content: SizedBox(
        height: 260,
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  key: const Key('name_field'),
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('phone_field'),
                  decoration: const InputDecoration(
                    label: Text('Phone'),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredPhone = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('country_field'),
                  decoration: const InputDecoration(
                    label: Text('Country'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return "Please enter valid country name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredCountry = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('city_field'),
                  decoration: const InputDecoration(
                    label: Text('City'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return "Please enter valid city name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredCity = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('state_field'),
                  decoration: const InputDecoration(
                    label: Text('State'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return "Please enter valid state";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredState = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('postal_code_field'),
                  decoration: const InputDecoration(
                    label: Text('Postal Code'),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  validator: (value) {
                    if (value == null ||
                        value.trim().length < 5 ||
                        value.trim().length > 5) {
                      return "Please enter valid postal code";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredPostalCode = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('address_one_field'),
                  decoration: const InputDecoration(
                    label: Text('Address (Line 1)'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter address";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredLine1 = newValue!;
                  },
                ),
                TextFormField(
                  key: const Key('address_two_field'),
                  decoration: const InputDecoration(
                    label: Text('Address (Line 2)'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter address";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredLine2 = newValue!;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
          if (state is PaymentLoaded && isSubmit == true) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              final navigator = Navigator.of(context);
              navigator.pop();
              try {
                StripeService.instatnce
                    .makePayment(state.clientSecret)
                    .then((sessionId) {
                  navigator.pushNamed(
                    CheckPaymentScreen.routeName,
                    arguments: sessionId,
                  );
                });
              } catch (e) {
                print(e);
              }
            });
          }

          return Column(
            children: [
              if (state is PaymentFailed && isSubmit == true)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    state.errors[0],
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (state is PaymentLoading && isSubmit == true) {
                        return;
                      }
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                          state is PaymentLoading && isSubmit == true
                              ? Colors.black38
                              : Colors.blue,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _createPayment,
                    child: Text(
                      state is PaymentLoading && isSubmit == true
                          ? 'Loading'
                          : 'Continue',
                    ),
                  ),
                ],
              )
            ],
          );
        })
      ],
    );
  }
}
