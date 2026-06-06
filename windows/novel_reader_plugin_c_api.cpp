#include "include/novel_reader/novel_reader_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "novel_reader_plugin.h"

void NovelReaderPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  novel_reader::NovelReaderPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
