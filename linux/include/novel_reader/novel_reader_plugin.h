#ifndef FLUTTER_PLUGIN_NOVEL_READER_PLUGIN_H_
#define FLUTTER_PLUGIN_NOVEL_READER_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _NovelReaderPlugin NovelReaderPlugin;
typedef struct {
  GObjectClass parent_class;
} NovelReaderPluginClass;

FLUTTER_PLUGIN_EXPORT GType novel_reader_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void novel_reader_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_NOVEL_READER_PLUGIN_H_
