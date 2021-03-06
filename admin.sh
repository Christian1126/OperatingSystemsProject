#! /bin/bash

: '
This program controls the functionality of the admin
'


: '
The following code are functions that will be used
in the main code below all of the functions.
'

YELLOW="\033[1;38;5;136;48;5;234m"
GREEN="\033[1;38;5;34;48;5;234m"
WHITE="\033[0;38;5;253;48;5;234m"
BACKGROUND="\033[48;5;234m"
DEFAULT="\033[0m"

# creates all directories and files if they do not exist
function check_for_and_create_directories
{
	if [ ! -d "General_Files" ]; then
		mkdir General_Files
		touch General_Files/test.txt
		echo "This is a test file." >> General_Files/test.txt
		echo "This is line 2." >> General_Files/test.txt
		echo "This is line 3." >> General_Files/test.txt
		echo "This is line 4." >> General_Files/test.txt
		touch General_Files/test1.txt
		echo "This is a test file." >> General_Files/test1.txt
		echo "This is line 2." >> General_Files/test1.txt
		echo "This is line 3." >> General_Files/test1.txt
		echo "This is line 4." >> General_Files/test1.txt
		touch General_Files/test2.txt
		echo "This is a test file." >> General_Files/test2.txt
		echo "This is line 2." >> General_Files/test2.txt
		echo "This is line 3." >> General_Files/test2.txt
		echo "This is line 4." >> General_Files/test2.txt
	fi
	if [ ! -d "Project_Files" ]; then
		mkdir Project_Files
		touch Project_Files/test.txt
		echo "This is a test file." >> Project_Files/test.txt
		echo "This is line 2." >> Project_Files/test.txt
		echo "This is line 3." >> Project_Files/test.txt
		echo "This is line 4." >> Project_Files/test.txt
		touch Project_Files/test1.txt
		echo "This is a test file." >> Project_Files/test1.txt
		echo "This is line 2." >> Project_Files/test1.txt
		echo "This is line 3." >> Project_Files/test1.txt
		echo "This is line 4." >> Project_Files/test1.txt
		touch Project_Files/test2.txt
		echo "This is a test file." >> Project_Files/test2.txt
		echo "This is line 2." >> Project_Files/test2.txt
		echo "This is line 3." >> Project_Files/test2.txt
		echo "This is line 4." >> Project_Files/test2.txt
	fi
	if [ ! -d "Financial_Files" ]; then
		mkdir Financial_Files
		touch Financial_Files/test.txt
		echo "This is a test file." >> Financial_Files/test.txt
		echo "This is line 2." >> Financial_Files/test.txt
		echo "This is line 3." >> Financial_Files/test.txt
		echo "This is line 4." >> Financial_Files/test.txt
		touch Financial_Files/test1.txt
		echo "This is a test file." >> Financial_Files/test1.txt
		echo "This is line 2." >> Financial_Files/test1.txt
		echo "This is line 3." >> Financial_Files/test1.txt
		echo "This is line 4." >> Financial_Files/test1.txt
		touch Financial_Files/test2.txt
		echo "This is a test file." >> Financial_Files/test2.txt
		echo "This is line 2." >> Financial_Files/test2.txt
		echo "This is line 3." >> Financial_Files/test2.txt
		echo "This is line 4." >> Financial_Files/test2.txt
	fi
	if [ ! -f "users.txt" ]; then
		touch users.txt
		echo "admin-power_user-buasa-buasa" > users.txt
	fi
}

function print_menu_header
{
	clear
	printf "\n%b   ===============================================\n" "$YELLOW"
	printf "   |  %badmin                                      %b|\n" "$GREEN" "$YELLOW"
	printf "   ===============================================\n"
}

function print_main_menu
{
	printf "   |  %b1) Create a new Power User                 %b|\n" "$WHITE" "$YELLOW"
	printf "   |  %b2) Create a new General User               %b|\n" "$WHITE" "$YELLOW"
	printf "   |  %b3) List Users                              %b|\n" "$WHITE" "$YELLOW"
	printf "   |  %b4) Delete Users                            %b|\n" "$WHITE" "$YELLOW"
	printf "   |  %b5) Open a Directory                        %b|\n" "$WHITE" "$YELLOW"
	printf "   |  %b6) Logout                                  %b|\n" "$WHITE" "$YELLOW"
	printf "   ===============================================\n\n"
}

function prompt_admin_to_change_password
{
	# displays password prompt until valid option is entered
	while [ "$input" != 1 ] && [ "$input" != 2 ]; do
		print_menu_header
		printf "   |  %bBecause you are the first user of the      %b|\n" "$WHITE" "$YELLOW"
		printf "   |  %bprogram, you are logged in as admin. The   %b|\n" "$WHITE" "$YELLOW"
		printf "   |  %bdefault password is 'buasa'. Press 1 to    %b|\n" "$WHITE" "$YELLOW"
		printf "   |  %bchange the password and 2 to logout.       %b|\n" "$WHITE" "$YELLOW"
		printf "   ===============================================\n\n"

		printf "%b   Option: " "$WHITE"
		read -r input
	done
}

function get_new_password_for_admin
{
	# if admin wants to change password
	if [ "$input" = 1 ]; then
		print_menu_header
		printf "   |  %bPlease enter a new password!               %b|\n" "$WHITE" "$YELLOW"
		printf "   ===============================================\n\n"
		printf "%b   New Password: " "$WHITE"
		read -r -s password
		# adds new password to admin file
		echo "admin-power_user-$password-buasa" > users.txt
	fi
}

function init_admin
{
	input=0
	# gets the current admin information
	current_password=$(head -n 1 "users.txt")

	# if admin information is the defualt
	if [ "$current_password" = "admin-power_user-buasa-buasa" ]; then
		# while the new password is not null and the user does not want to logout
		while [ -z "$password" ] && [ "$input" != 2 ]; do
			prompt_admin_to_change_password
			get_new_password_for_admin
		done
	fi

	# if user wants to logout without changing the password
	if [ "$input" = 2 ]; then
		# breaks main loop / logout
		input=6
	fi
}

function create_power_user
{
	print_menu_header
	printf "   |  %bEnter Credentials for new Power User       %b|\n" "$WHITE" "$YELLOW"
	printf "   ===============================================\n\n"
	printf "%b   Username: " "$WHITE"
	read -r name
	printf "%b   Password: " "$WHITE"
	read -r -s password

	matched=0
	# checks to the no user has the same username and username and password are
	# not null
	while IFS='-' read -r user access pass default_pass; do
		if [ "$name" = "$user" ] || [ -z "$name" ] || [ -z "$password" ]; then
			matched=1
		fi
	done < users.txt

	# if user credientials are valid
	if [ "$matched" != 1 ]; then
		# add user to users.txt file
		echo "$name-power_user-$password-$password" >> users.txt
	fi
}

function create_general_user
{
	print_menu_header
	printf "   |  %bEnter Credentials for new General User     %b|\n" "$WHITE" "$YELLOW"
	printf "   ===============================================\n\n"
	printf "%b   Username: " "$WHITE"
	read -r name
	printf "%b   Password: " "$WHITE"
	read -r -s password

	matched=0
	# checks to the no user has the same username and username and password are
	# not null
	while IFS='-' read -r user access pass default_pass; do
		if [ "$name" = "$user" ] || [ -z "$name" ] || [ -z "$password" ]; then
			matched=1
		fi
	done < users.txt

	# if user credientials are valid
	if [ "$matched" != 1 ]; then
		# add user to users.txt file
		echo "$name-general_user-$password-$password" >> users.txt
	fi
}

function list_users_and_types
{
	print_menu_header

	# loops through users.txt file and list all the users
	i=1
	while IFS='-' read -r user access pass default_pass; do
		printf "   | %b%2d) %-15s  - %-12s        %b|\n" "$WHITE " "$i" "$user" "$access" "$YELLOW"
		i=$((i+1))
	done < users.txt

	printf "   ===============================================\n\n"
	printf "%b   Press enter to continue..." "$WHITE"
	# read input to exit screen
	read -r input
	input=0
}

function delete_user
{
	print_menu_header
	printf "   |  %bSelect user to delete                      %b|\n" "$WHITE" "$YELLOW"
	printf "   |                                             |\n"

	# loops through users.txt file and list all the users
	i=1
	while IFS='-' read -r user access pass; do
		printf "   | %b%2d) %-15s  - %-12s         %b|\n" "$WHITE" "$i" "$user" "$access" "$YELLOW"
		i=$((i+1))
	done < users.txt

	# gets user to delete
	printf "   ===============================================\n\n"
	printf "%b   User to delete: " "$WHITE"
	read -r input

	# if user is not admin and not null
	if [ "$input" != 1 ] && [ -n "$input" ]; then
		# copies all information except the user to be deleted into a temp
		# file
		i=1
		while read -r line; do
			if [ "$input" != "$i" ]; then
				echo "$line" >> tmp_users.txt
			fi
			i=$((i+1))
		done < users.txt

		# deletes users.txt
		rm users.txt
		# input data from temp file to users.txt
		while read -r line; do
			echo "$line" >> users.txt
		done < tmp_users.txt

		# deletes temp file 
		rm tmp_users.txt
	fi
}


: '
The following code is what is actually running
for the program.
'

printf "%b" "$BACKGROUND"

input=""
check_for_and_create_directories
init_admin

current_password=$(head -n 1 "users.txt")
name=""
password=""

while [ "$input" != 6 ] && [ "$current_password" != "admin-power_user-buasa" ]; do

	print_menu_header
	print_main_menu
	printf "%b   Option: " "$WHITE"
	read -r input

	if [ "$input" = 1 ]; then
		create_power_user
	elif [ "$input" = 2 ]; then
		create_general_user
	elif [ "$input" = 3 ]; then
		list_users_and_types
	elif [ "$input" = 4 ]; then
		delete_user
	elif [ "$input" = 5 ]; then
		./access.sh "admin" "power_user"
		printf "%b" "$BACKGROUND"
	fi
done

printf "%b" "$DEFAULT"
