/*
 * Copyright (c) 2016 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

#include "patchstat/main.hpp"

int main(int argc, char* argv[]) {
    std::cout << "Reading " << argc - 1 << " files\n";
    for (int i = 1; i < argc; i++) {
        std::ifstream file(argv[i]);
        CSV row;
        while(file >> row) {
            std::cout << row[4] << row[0] << row[3] << '\n';
        }
    }

}
