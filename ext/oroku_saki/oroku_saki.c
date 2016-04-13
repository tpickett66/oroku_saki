#include "oroku_saki.h"

VALUE rb_mOrokuSaki;

void
Init_oroku_saki(void)
{
  rb_mOrokuSaki = rb_define_module("OrokuSaki");
}
