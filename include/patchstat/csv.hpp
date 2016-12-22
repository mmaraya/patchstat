/*
 * Copyright (c) 2016 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

#ifndef PATCHSTAT_CSV_H_
#define PATCHSTAT_CSV_H_

#include <fstream>
#include <sstream>
#include <string>
#include <vector>

class CSV {
  private:
    std::vector<std::string> data;
  public:
    std::size_t size() const;
    std::string const &operator[](std::size_t index) const;
    void next(std::istream &str);
};

std::istream &operator>>(std::istream &str, CSV &data); 

#endif // PATCHSTAT_CSV_H_
