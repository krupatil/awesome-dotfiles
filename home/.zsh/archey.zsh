# Only run if archey is actually installed
if which archey &> /dev/null
then
    archey
else
    print "zsh archey plugin: archey not found. Please install archey before using this plugin: brew install archey"
fi
