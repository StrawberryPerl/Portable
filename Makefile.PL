use inc::Module::Install 0.79;

all_from      'lib/Portable.pm';
requires      'List::Util'        => '1.19';
requires      'File::Spec'        => '3.27';
requires      'Parse::CPAN::Meta' => '0.03';
requires      'File::HomeDir'     => '0.80';
requires      'CPAN::Mini'        => '0.575';
test_requires 'Test::More'        => '0.42';
test_requires 'Test::Exception'   => '0.27';
test_requires 'Class::Inspector'  => '1.22';

WriteAll;
