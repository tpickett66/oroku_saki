/* Copyright 2012-2016, Mansour Moufid <mansourmoufid@gmail.com>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <assert.h>
#include <stddef.h>
#include <stdint.h>

#include "memzero.h"

static const unsigned long int qzero = 0UL;

/*@ requires \valid((unsigned char *)mem);
    requires stride > 0;
    assigns \nothing;
 */
static size_t
offset_align(void *const mem, const size_t stride)
{
    uintptr_t offset = (uintptr_t) mem % stride;
    if (offset == 0) {
        return (size_t) 0;
    } else {
        return (stride - (size_t) offset);
    }
}

/*@ requires \valid(p + (0 .. n - 1));
    assigns *(p + (0 .. n - 1));
    ensures \forall integer i; 0 <= i < n ==> p[i] == 0;
 */
static inline void
zero_bytes(unsigned char *p, const size_t n)
{
    size_t i;
    if (n == 0) {
        return;
    }
    p[0] = 0;
    /*@ loop invariant n;
        loop invariant i > 0;
        loop assigns i, p[1 .. n - 1];
     */
    for (i = 1; i < n; i++) {
        p[i] = p[i - 1];
    }
    return;
}

/*@ requires \valid((unsigned char *)mem + (0 .. (n - 1)));
    ensures \forall integer i; 0 <= i < n
        ==> ((unsigned char *)mem)[i] == 0;
 */
void *
memzero(void *const mem, const size_t n)
{
    size_t i, j;
    unsigned long int *q;
    unsigned char *b;

    assert(mem != NULL);

    if (n == 0) {
        goto done;
    }

    i = 0;

    if (n - i >= 2 * sizeof(qzero)) {
        /* Zero bytes up to the first aligned word. */
        b = mem;
        b += i;
        zero_bytes(b, offset_align(b, sizeof(qzero)));
        i += offset_align(b, sizeof(qzero));
        b += i;

        /* Zero word by word. */
        assert(offset_align(b, sizeof(qzero)) == 0);
        q = (unsigned long int *) b;
        q[0] = qzero;
        /*@ loop invariant i;
            loop invariant n;
            loop invariant j > 0;
            loop assigns q[j];
         */
        for (j = 1; j < (n - i) / sizeof(qzero); j++) {
            q[j] = q[j - 1];
        }
        i += j * sizeof(qzero);
    }

    if (i >= n) {
        goto done;
    }

    /* Zero any trailing bytes. */
    b = mem;
    b += i;
    zero_bytes(b, n - i);

done:
    return mem;
}
