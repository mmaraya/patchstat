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

#include <string>

class CSV {
  private:
    std::string in_file_;
    std::string out_file_;
  public:
    explicit CSV(std::string in_file, std::string out_file);
    std::string in_file() const;
    std::string out_file() const;
    void set_in_file(std::string in_file);
    void set_out_file(std::string out_file);
};

#endif // PATCHSTAT_CSV_H_
