import 'package:flutter/widgets.dart';
import 'package:fr_lenra_client/socket/lenra_channel.dart';

abstract class SocketModel extends ChangeNotifier {
  LenraChannel channel(String channelName, Map<String, dynamic> params);
}
