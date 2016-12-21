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
#include "patchstat/csv.hpp"

CSV::CSV(std::string in_file, std::string out_file) {
    in_file_ = in_file;
    out_file_ = out_file;
}


