import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../page/camera_preview_page.dart';

/// Routes class
/// [routes] is mapper route name [RouteNames] and widget builder

class Routes {
  /// key is route name [RouteNames] and value is widgetBuilder
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.cameraPreviewPage: (context) {
      final arguments = ModalRoute.of(context)!.settings.arguments! as Map;

      final cameraController =
          arguments[RouteParameters.camera] as CameraDescription;

      return FutureBuilder(
          future: availableCameras(),
          builder: (context, state) {
            if (state.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final camera = state.data?.firstWhere(
                  (camera) => camera.lensDirection == CameraLensDirection.back);
              return CameraPreviewPage(
                camera: camera ?? cameraController,
              );
            }
          });
    },
  };
}

/// Route names
/// contain static const variable example homePage = 'homePage'
/// using for navigate
/// example: Navigator.pushNamed(context, RouteNames.homePage)
class RouteNames {
  static const emptyRoute = '/';
  static const homePage = 'homePage';
  static const cameraPreviewPage = 'cameraPreviewPage';
}

/// Route parameters
/// using for key in arguments ModalRoute.of(context)!.settings.arguments
class RouteParameters {
  static const camera = 'camera';
}
