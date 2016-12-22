/*
 * Copyright (c) 2016 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

#include "patchstat/csv.hpp"

std::size_t CSV::size() const {
    return data.size();
}

std::string const &CSV::operator[](std::size_t index) const {
    return data[index];
}

void CSV::next(std::istream &str) {
    std::string line;
    std::getline(str, line);
    std::stringstream stream(line);
    std::string value;

    data.clear();
    while(std::getline(stream, value, ',')) {
        data.push_back(value);
    }
}

std::istream &operator>>(std::istream &str, CSV& data) {
    data.next(str);
    return str;
}
