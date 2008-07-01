use inc::Module::Install 0.75;

all_from      'lib/Portable.pm';
requires      'List::Util'        => '1.19';
requires      'File::Spec'        => '0.80';
requires      'Parse::CPAN::Meta' => '0.03';
requires      'File::HomeDir'     => '0.80';
test_requires 'Test::More'        => '0.42';
test_requires 'Class::Inspector'  => '1.20';

WriteAll;
