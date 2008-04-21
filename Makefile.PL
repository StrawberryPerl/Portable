use inc::Module::Install;

all_from      'lib/Portable.pm';
requires      'List::Util'        => '1.19';
requires      'File::Spec'        => '0.80';
requires      'Parse::CPAN::Meta' => '0.03';
test_requires 'Test::More'        => '0.42';

WriteAll;
