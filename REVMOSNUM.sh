#!/bin/bash

################################################################################
#                                                                              #
# REVMOSNUM                                                                    #
#                                                                              #
# This script shall scry the Holy Ether of the Wikipedia Manual of Style/Dates #
# and numbers and autowrite The Holy Scriptures of MOSNUM.                     #
#                                                                              #
# version: 2014-05-07T1523                                                     #
#                                                                              #
################################################################################
#                                                                              #
# LICENCE INFORMATION                                                          #
#                                                                              #
# The program REVMOSNUM downloads Wikipedia pages and converts the results to  #
# a convenient format.                                                         #
#                                                                              #
# copyright (C) 2014 William Breaden Madden                                    #
#                                                                              #
# This software is released under the terms of the GNU General Public License  #
# version 3 (GPLv3).                                                           #
#                                                                              #
# This program is free software: you can redistribute it and/or modify it      #
# under the terms of the GNU General Public License as published by the Free   #
# Software Foundation, either version 3 of the License, or (at your option)    #
# any later version.                                                           #
#                                                                              #
# This program is distributed in the hope that it will be useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or        #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for    #
# more details.                                                                #
#                                                                              #
# For a copy of the GNU General Public License, see                            #
# <http://www.gnu.org/licenses/>.                                              #
#                                                                              #
################################################################################

actualityOfProgram(){
    type "${1}" &> /dev/null;
}

instate(){
    for currentProgram in "${@}"; do
        # If the program exists for the system, do not attempt to install it.
            #echo "checking for actuality of program "${currentProgram}"..."
            if actualityOfProgram "${currentProgram}"; then
                #echo "program actualised... aborting instatement"
                :
            else
                echo "instating "${currentProgram}"..."
                # If Apt is available, use it to install the program.
	        if actualityOfProgram apt-get; then
                    sudo apt-get -y install "${currentProgram}"
                # If YUM is available, use it to install the program.
                elif actualityOfProgram yum; then
                    sudo yum -y install "${currentProgram}"
		# If neither Apt nor YUM is available, cease attempts at
                # installation.
                else
                    echo "could not instate "${currentProgram}""
                fi
            fi
    done
}

instate wkhtmltopdf pdftk pdflatex

for i in {130..146}; do
    #echo ${i}
    wkhtmltopdf http://en.wikipedia.org/wiki/Wikipedia_talk:Manual_of_Style/Dates_and_numbers/Archive_${i} ${i}.pdf    
done

cat >> 0.tex<<'EOF'
\documentclass{article}
\usepackage{graphicx}
\usepackage{fix-cm}
\begin{document}
\pagestyle{empty}
\vspace*{\fill}
\begin{center}
\hrule
\vspace{1.5 cm}
\textbf{
\fontsize{25}{45}\selectfont
The Holy Scriptures\\
of\\
\fontsize{45}{45}\selectfont
\vspace{0.5 cm}
MOSNUM\\
\vspace{1.5 cm}
\hrule
\vspace{3.5 cm}
}
\end{center}
\vspace*{\fill}
\end{document}
EOF
pdflatex 0.tex

pdftk *.pdf cat output The_Holy_Scriptures_of_MOSNUM.pdf