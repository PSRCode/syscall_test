/*
 * arm_fadvise64_64 syscall test
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
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>

void create_file(const char *path)
{
	static bool file_created = false;
	int ret;

	if (!path || file_created) {
		return;
	}

	ret = creat(path, S_IRWXU);
	if (ret < 0) {
		fprintf(stderr, "Failed to create file %s\n", path);
		return;
	}

	(void) close(ret);
	file_created = true;
}

static
void wait_on_file(const char *path)
{
	if (!path) {
		return;
	}

	for (;;) {
		int ret;
		struct stat buf;

		ret = stat(path, &buf);
		if (ret == -1 && errno == ENOENT) {
			(void) poll(NULL, 0, 10);	/* 10 ms delay */
			continue;			/* retry */
		}
		if (ret) {
			perror("stat");
			exit(EXIT_FAILURE);
		}
		break;	/* found */
	}
}

int main(int argc, char **argv)
{
	int ret, fd;

	char *trigger_start_file_path = NULL;
	char *trigger_end_file_path = NULL;

	if (argc >= 2) {
		trigger_start_file_path = argv[1];
	}
	if (argc >= 3) {
		trigger_end_file_path = argv[2];
	}

	wait_on_file(trigger_start_file_path);

#if defined(__x86_64__)
	/* x86 64-bit */
	printf("ok - Valid architecture: x86_64\n");
	printf("# x86_64 syscall version\n");
	printf("# Nothing to test\n");

	/* Suppress unused variable warning */
	(void)fd;
	ret = -1;
#elif defined(__i386__)
	/* x86 32-bit */
	printf("ok - Valid architecture: x86_32\n");
	printf("# x86_32 syscall version\n");
	printf("# Nothing to test\n");

	/* Suppress unused variable warning */
	(void)fd;
	ret = -1;
#elif defined(__arm__)
	/* arm 32-bit */
	printf("ok - Valid architecture: arm32\n");
	printf("# Arm 32 syscall version\n");
	fd = open("foo", O_RDONLY);
	uint64_t offset= 0;
	uint64_t len= 1ULL << 13;
	ret = syscall(SYS_arm_fadvise64_64, fd, POSIX_FADV_SEQUENTIAL,
			__LONG_LONG_PAIR ((long) (offset >> 32), (long) offset),
			__LONG_LONG_PAIR ((long) (len >> 32), (long) len));
	if (ret < 0) {
		ret = -ret;
	}
#elif defined(__aarch64__)
	/* arm 64-bit */
	printf("ok - Valid architecture: arm64\n");
	printf("# Arm 64 syscall version\n");
	printf("# Nothing to test\n");

	/* Suppress unused variable warning */
	(void)fd;
	ret = -1;
#elif defined(__powerpc__) || defined(__ppc__) || defined(__PPC__)
#if defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__)
	/* POWER 64-bit */
	printf("ok - Valid architecture: PowerPC 64\n");
	printf("# PowerPC 64 syscall version\n");
	printf("# Nothing to test\n");

	/* Suppress unused variable warning */
	(void)fd;
	ret = -1;
#else
	/* POWER 32-bit */
	printf("ok - Valid architecture: PowerPC 32\n");
	printf("# PowerPC 32 syscall version\n");
	printf("# Nothing to test\n");

	/* Suppress unused variable warning */
	(void)fd;
	ret = -1;

#endif /* defined(__powerpc64__) || defined(__ppc64__) || defined(__PPC64__) */

#else
	/* Suppress unused variable warning */
	(void)fd;
	printf("not ok - Invalid architecture\n");
	ret = -1;
#endif
	create_file(trigger_end_file_path);
	return ret;
}
