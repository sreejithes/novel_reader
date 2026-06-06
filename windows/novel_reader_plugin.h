#ifndef FLUTTER_PLUGIN_NOVEL_READER_PLUGIN_H_
#define FLUTTER_PLUGIN_NOVEL_READER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace novel_reader {

class NovelReaderPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NovelReaderPlugin();

  virtual ~NovelReaderPlugin();

  // Disallow copy and assign.
  NovelReaderPlugin(const NovelReaderPlugin&) = delete;
  NovelReaderPlugin& operator=(const NovelReaderPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace novel_reader

#endif  // FLUTTER_PLUGIN_NOVEL_READER_PLUGIN_H_
