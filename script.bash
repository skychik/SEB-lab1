#!/bin/bash
# USAGE ./script.bash
log="$HOME/lab1_err"
IFS=""

# Prints the working directory path
func1() {
	/bin/pwd
	return $?
}

# Changes the working directory
func2() {
	echo "Enter the dirname:"
	read dir || return $?
	cd -- "$dir"
	return $?
}

# Creates a file
func3() {
	echo "Enter the filename:"
	read file || return $?
	touch -- "$file"
	return $?
}

# Lets everybody write to the file
func4() {
	echo "Enter the filename:"
	read file || return $?
	chmod a+w -- "$file"
	return $?
}

# Removes a file
func5() {
	echo "Enter the filename:"
	read file || return $?
	ls -- "$file" 2>/dev/null >&2
	if [ $? != 0 ]; then
		echo "File '$file' does not exist" >&2
		return 1
	fi
	echo "rm: remove regular file '$file'?"
	read answer || return $?
	if [ "$answer" == "yes" ]
		then
			rm -f -- "$file"
			return $?
		else
			echo "Perhaps, you've misspeled 'yes'"
			return 0
	fi
}

# Calls the corresponding function
call() {
	case "$1" in
		1) func1 ;;
		2) func2 ;;
		3) func3 ;;
		4) func4 ;;
		5) func5 ;;
		6) ;;
		*) echo "Unknown option" >&2; return 1
	esac
	return $?
}

while [ "$option" != 6 ]
do
	echo "Available options are:"
	echo "1. Print current directory name."
	echo "2. Change current directory."
	echo "3. Create a file."
	echo "4. Let everybody write to a provided file."
	echo "5. Remove a file."
	echo "6. Exit from the program."
	echo "Please, choose one:"
	read option || break
	call "$option" 2>>"$log" ||
		echo "Something went wrong. Consider reading the log." >&2
done
