#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <re.h>
#include <regex.h>

int main() {
    // OS-related functions
    pid_t pid = getpid();
    printf("Process ID: %d\n", pid);

    // Regular expression functions
    regex_t regex;
    regcomp(&regex, "hello", REG_EXTENDED);
    regmatch_t match;
    if (regexec(&regex, "hello", 0, &match, 0) == 0) {
        printf("Match found!\n");
    } else {
        printf("No match found.\n");
    }
    regfree(&regex);

    return 0;
}
