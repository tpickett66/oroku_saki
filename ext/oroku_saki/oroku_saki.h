#ifndef OROKU_SAKI_H
#define OROKU_SAKI_H 1

#include "ruby.h"
#include "memzero.h"

VALUE oroku_saki_secure_compare(VALUE rb_module, VALUE rb_str_a, VALUE rb_str_b);
VALUE oroku_saki_shred_bang(VALUE rb_module, VALUE rb_str);

#endif /* OROKU_SAKI_H */
