import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/shared/styles/colors.dart';

import '../../components/constants.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return getAccount(context);
      },
    );
  }

  Widget getAccount(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            ),
            title: Text(
              'Orders',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.perm_identity,
              size: 30,
            ),
            title: Text(
              'My Details',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            title: Text(
              'Delivery Address',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.credit_card_outlined,
              size: 30,
            ),
            title: Text(
              'Payment Methods',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.local_offer_sharp,
              size: 30,
            ),
            title: Text(
              'Promo Code',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.notifications_none_sharp,
              size: 30,
            ),
            title: Text(
              'Notifications',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const ListTile(
            leading: Icon(
              Icons.info_outline,
              size: 30,
            ),
            title: Text(
              'About',
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: (){
              signOut(context);
            },
            child: const Row(
              children: [
                Expanded(
                  child: Icon(Icons.logout, size: 30, color: defaultColor),
                ),
                Expanded(
                    child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18, color: defaultColor),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
