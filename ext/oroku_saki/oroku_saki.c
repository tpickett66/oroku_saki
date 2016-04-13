#include <stdint.h>
#include "oroku_saki.h"

void raise_unless_string(VALUE rb_maybe_str, char *original_function_name) {
  if (TYPE(rb_maybe_str) != T_STRING) {
    VALUE inspected_obj, obj_class_name;
    inspected_obj = rb_funcall(rb_maybe_str, rb_intern("inspect"), 0);
    obj_class_name = rb_funcall(
        rb_funcall(rb_maybe_str, rb_intern("class"), 0),
        rb_intern("name"),
        0
        );
    rb_raise(
        rb_eTypeError,
        "%s received %s (%s), expected String!",
        original_function_name,
        StringValueCStr(inspected_obj),
        StringValueCStr(obj_class_name)
        );
  }
}

/*
 * This is a modified version of NaCl's crypto_verify_N functions adatpted to
 * work with Ruby's String types and with variable lengths. We're returning
 * the bitmonkeyed int from this to avoid branch predication.
 */
int secure_compare(VALUE rb_str_a, VALUE rb_str_b) {
  uint_fast16_t d = 0U;
  int i;
  int len = RSTRING_LEN(rb_str_a);
  char *a = RSTRING_PTR(rb_str_a);
  char *b = RSTRING_PTR(rb_str_b);

  for (i = 0; i < len; i++) {
    d |= a[i] ^ b[i];
  }

  return (1 & ((d - 1) >> 8)) - 1;
}

/* The C implementation of the secure compare, the return type is a Fixnum
 * to avoid certain optimizations that cause the branch predictor to leak timing
 * information.
 */
VALUE oroku_saki_secure_compare(VALUE rb_module, VALUE rb_str_a, VALUE rb_str_b) {
  raise_unless_string(rb_str_a, "OrokuSaki.secure_compare");
  raise_unless_string(rb_str_b, "OrokuSaki.secure_compare");

  if (RSTRING_LEN(rb_str_a) != RSTRING_LEN(rb_str_b)) {
    return INT2FIX(-1);
  }

  return INT2FIX(secure_compare(rb_str_a, rb_str_b));
}

/* Zero out the memory housing the passed string.
 *
 * This method takes in a string and zeros out the memory it occupies, by design
 * it does not respect frozen states of strings so make sure you're actually
 * done with the String before using this method.
 *
 * @param [String] str The string to be zeroed out.
 * @raise [TypeError] When passed something other than a String
 * @return [nil]
 */
VALUE oroku_saki_shred_bang(VALUE rb_module, VALUE rb_str) {
  raise_unless_string(rb_str, "OrokuSaki.shred!");
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
  rb_define_singleton_method(rb_mOrokuSaki, "secure_compare_c",
      oroku_saki_secure_compare, 2);
}
