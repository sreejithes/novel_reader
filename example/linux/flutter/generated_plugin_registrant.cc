//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <novel_reader/novel_reader_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) novel_reader_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "NovelReaderPlugin");
  novel_reader_plugin_register_with_registrar(novel_reader_registrar);
}
