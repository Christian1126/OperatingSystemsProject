#! /bin/bash

YELLOW="\033[38;5;136m"
WHITE="\033[1;37m"

function print_menu_header 
{
	clear

	printf "\n${YELLOW}   ===============================================\n"
	printf "   |  ${WHITE}Welcome to the Bash User Access System     ${YELLOW}|\n"
	printf "   ===============================================\n"
	printf "   |  ${WHITE}Hello %-36s ${YELLOW}|\n" "$1"
	printf "   |  ${WHITE}You are logged in as a %-19s ${YELLOW}|\n" "$2"
}

if [[ ( -d "Financial_Files" && -d "General_Files" && -d "Project_Files" ) ]]; then

	while [[ ( "$2" == "power_user" && "$input" != 4 ) || ( "$2" == "general_user" && "$input" != 3 ) ]]; do
		
		print_menu_header "$1" "$2"
		printf "   |  ${WHITE}These are the directory options for your   ${YELLOW}|\n"
		printf "   |  ${WHITE}privilege level.                           ${YELLOW}|\n"
		printf "   ===============================================\n"
		printf "   |  ${WHITE}1) General Files                           ${YELLOW}|\n"
		printf "   |  ${WHITE}2) Project Files                           ${YELLOW}|\n"
		
		if [ "$2" == "power_user" ]; then
			printf "   |  ${WHITE}3) Financial Files                         ${YELLOW}|\n"
			printf "   |  ${WHITE}4) Return to user menu                     ${YELLOW}|\n"
		elif [ "$2" == "general_user" ]; then
			printf "   |  ${WHITE}3) Return to user menu                     ${YELLOW}|\n"
		fi
		
		printf "   ===============================================\n\n"
		printf "${WHITE}"
		read -p "   Directory Option: " input
		
		if [ "$input" == 1 ]; then
			clear
			print_menu_header "$1" "$2"
			printf "   |                                             |\n"
			printf "   |  ${WHITE}General Files                              ${YELLOW}|\n"
			printf "   ===============================================\n"
			i=1
			for entry in "General_Files"/*; do
				printf "   | ${WHITE}%2d) %-39s ${YELLOW}|\n" "$i" "$entry"
				i=$((i+1))
			done
			printf "   ===============================================\n"
			
		elif [ "$input" == 2 ]; then
			clear
			print_menu_header "$1" "$2"
			printf "   |                                             |\n"
			printf "   |  ${WHITE}Project Files                              ${YELLOW}|\n"
			printf "   ===============================================\n"
			i=1
			for entry in "Project_Files"/*; do
				printf "   | ${WHITE}%2d) %-39s ${YELLOW}|\n" "$i" "$entry"
				i=$((i+1))
			done
			printf "   ===============================================\n"
			
		elif [[ ( "$input" == 3 && "$2" == "power_user" ) ]]; then
			clear
			print_menu_header "$1" "$2"
			printf "   |                                             |\n"
			printf "   |  ${WHITE}Financial Files                            ${YELLOW}|\n"
			printf "   ===============================================\n"
			i=1
			for entry in "Financial_Files"/*; do
				printf "   | ${WHITE}%2d) %-39s ${YELLOW}|\n" "$i" "$entry"
				i=$((i+1))
			done
			printf "   ===============================================\n"
		fi
		
		if [[ ( "$input" == 1 || "$input" == 2 ) || ( "$input" == 3 && "$2" == "power_user" ) ]]; then
			printf "${WHITE}\n"
			read -p "   Press enter to return to menu..." input
		fi
		
	done

fi


