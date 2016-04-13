#include "oroku_saki.h"

VALUE oroku_saki_shred_bang(VALUE rb_module, VALUE rb_str) {
  memzero(RSTRING_PTR(rb_str), RSTRING_LEN(rb_str));
  return Qnil;
}

VALUE rb_mOrokuSaki;

void
Init_oroku_saki(void)
{
  rb_mOrokuSaki = rb_define_module("OrokuSaki");
  rb_define_singleton_method(rb_mOrokuSaki, "shred!",
      oroku_saki_shred_bang, 1);
}
