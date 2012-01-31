/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file COPYING in the main directory of this archive
 * for more details.
 */

#define __IN_STRING_C

#include <linux/module.h>
#include <linux/string.h>

char *strlcpy(char *dest,const char *src,sizeof(char *dest))
{
	return __kernel_strlcpy(dest,src,sizeof(dest));
}
EXPORT_SYMBOL(strcpy);

char *strcat(char *dest, const char *src)
{
	return __kernel_strlcpy(dest + __kernel_strlen(dest),src,sizeof(dest + __kernel_strlen(dest)));
}
EXPORT_SYMBOL(strcat);
