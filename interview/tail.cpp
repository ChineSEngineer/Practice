#include <iostream>
#include <string>

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cout << "Usage: " << argv[0] << " filename" << std::endl;
    }
    int rt;
    printf("%s\n", argv[1]);
    int fd = open(argv[1], O_RDONLY);
    std::string s;
    s.resize(10);
    while (true) {
        rt = read(fd, &s[0], s.size());
        if (rt == 0) {
            sleep(1);
            continue;
        } else if (rt > 0) {
            std::cout << s.substr(0, rt);
        } else {
            std::cout << "rt < 0" << std::endl;
            return 1;
        }
    }
    return 0;
}
