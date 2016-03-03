/*
 * clone syscall test
 *
 * Copyright (c) 2016 Antoine Busque <abusque@efficios.com>
 *                    Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <errno.h>
#include <fcntl.h>
#include <poll.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sched.h>


int main(int argc, char **argv)
{
	int ret;
#if defined(__x86_64__)
	/* x86 64-bit */
	printf("x86_64\n");
	ret = 0;
#elif defined(__i386__)
	/* x86 32-bit */
	printf("x86_32\n");
	ret = 0;
#elif defined(__arm__)
	/* arm 32-bit */
	printf("arm32\n");
	ret = 0;
#elif defined(__aarch64__)
	/* arm 64-bit */
	printf("arm64\n");
	ret = 0;
#elif defined(__powerpc__) || defined(__ppc__) || defined(__PPC__)
#if defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__)
	printf("ppc64\n");
	ret = 0;
#else
	/* POWER 32-bit */
	printf("#ppc\n");
	ret = 0;

#endif /* defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__) */

#else
	printf("invalid architecture\n");
	ret = -1;
#endif
	return ret;
}
