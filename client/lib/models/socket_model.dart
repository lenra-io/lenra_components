import 'package:flutter/widgets.dart';
import 'package:fr_lenra_client/config/config.dart';
import 'package:fr_lenra_client/models/auth_model.dart';
import 'package:fr_lenra_client/socket/lenra_channel.dart';
import 'package:fr_lenra_client/utils/connexion_utils_stub.dart'
    if (dart.library.io) 'package:fr_lenra_client/utils/connexion_utils_io.dart'
    if (dart.library.js) 'package:fr_lenra_client/utils/connexion_utils_web.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class LenraSocketModel extends ChangeNotifier {
  AuthModel authModel;
  late PhoenixSocket _socket;
  LenraSocketModel(this.authModel) {
    this._updateSocket();
  }

  void _updateSocket() {
    this._socket.disconnect();

    if (this.authModel.isAuthenticated()) {
      this._socket = createPhoenixSocket(
        Config.instance.wsEndpoint,
        {"token": this.authModel.accessToken!},
      );
      this._socket.connect();
    }
  }

  void update(AuthModel authModel) {
    this.authModel = authModel;
    this._updateSocket();
    notifyListeners();
  }

  LenraChannel channel(String channelName, Map<String, dynamic> params) {
    return new LenraChannel(this._socket, channelName, params);
  }
}
