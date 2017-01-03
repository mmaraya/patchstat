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
        std::cout << "argv[" << i << "] = " << argv[i] << std::endl;
        io::CSVReader<3> in (argv[i]);
        in.read_header(io::ignore_extra_column, "Plugin ID", "Risk", "Host");
        std::string plugin_id;
        std::string risk;
        std::string host;
        while (in.read_row(plugin_id, risk, host)) { 
            std::cout << plugin_id << '|' << risk << '|' << host << "|\n";
        }  
    }
    std::cout << "Hit enter to continue ...\n"; 
    std::string input = ""; 
    getline(std::cin, input);
    return 0;
}
