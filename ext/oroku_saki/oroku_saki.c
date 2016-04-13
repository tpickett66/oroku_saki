#include "oroku_saki.h"

VALUE oroku_saki_shred_bang(VALUE rb_module, VALUE rb_str) {
  if (TYPE(rb_str) != T_STRING) {
    VALUE inspected_obj, obj_class_name;
    inspected_obj = rb_funcall(rb_str, rb_intern("inspect"), 0);
    obj_class_name = rb_funcall(
        rb_funcall(rb_str, rb_intern("class"), 0),
        rb_intern("name"),
        0
        );
    rb_raise(
        rb_eTypeError,
        "OrokuSaki.shred! received %s (%s), expected String!",
        StringValueCStr(inspected_obj),
        StringValueCStr(obj_class_name)
        );
  }
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
