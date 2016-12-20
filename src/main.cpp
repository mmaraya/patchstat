/*
 * Copyright (c) 2016 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "Reading " << argc - 1 << " files\n";
    for (int i = 1; i < argc; i++) {
        std::cout << argv[i] << '\n';
    }
}
