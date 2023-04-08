import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/services/MerchantService.dart';
import 'package:sariapp/utils/Constants.dart';
import 'package:settings_ui/settings_ui.dart';

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  late Merchant activeMerchant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(LineIcons.arrowLeft),
              onPressed: () => Navigator.pop(context)),
          title: const Text("Information", overflow: TextOverflow.fade),
          backgroundColor: HexColor(kGunmetalColor)),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Store'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(LineIcons.store),
                title: const Text('Name'),
                value: Text(activeMerchant.merchant_name),
              ),
              SettingsTile.navigation(
                leading: const Icon(LineIcons.map),
                title: const Text('Address'),
                value: Text(activeMerchant.merchant_address),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Contact'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(LineIcons.mobilePhone),
                title: const Text('Mobile no.'),
                value: Text(activeMerchant.merchant_contact),
              )
            ],
          ),
          SettingsSection(
            title: const Text('Operation hours'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(LineIcons.clock),
                title: const Text('Weekdays'),
                value: const Text('5:00 am - 6:00 pm'),
              ),
              SettingsTile.navigation(
                leading: const Icon(LineIcons.clock),
                title: const Text('Weekends'),
                value: const Text('8:00 am - 5:00 pm'),
              )
            ],
          ),
          SettingsSection(
            title: const Text('Social media'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(LineIcons.facebook),
                title: const Text('Facebook'),
                value: const Text('fb.com/sunnyvilebagsakan'),
              ),
              SettingsTile.navigation(
                leading: const Icon(LineIcons.googleLogo),
                title: const Text('Gmail'),
                value: const Text('sunnyvillebagsakan@gmail.com'),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeMerchant = MerchantService.getProviderActiveMerchant(context);
  }
}
