# Removes directory from the $path variable if the directory doesn't exist.
for test_path ($path); do
    if [ ! -d ${test_path} ]; then
        path=("${(@)path:#$test_path}")
    fi
done

# Makes path array unique, effectively removing duplicates
typeset -U path
