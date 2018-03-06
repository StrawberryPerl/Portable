use inc::Module::Install::DSL 1.19;

all_from      lib/Portable.pm
requires_from lib/Portable.pm
requires_from lib/Portable/HomeDir.pm
requires_from lib/CPAN/Mini/Portable.pm
test_requires Test::More       0.42
test_requires Test::NoWarnings 0.084
test_requires Test::Exception  0.27
test_requires Class::Inspector 1.22
test_requires LWP::Online      1.07
