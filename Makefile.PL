use 5.008;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Portable',
    VERSION_FROM     => 'lib/Portable.pm',
    AUTHOR           => 'KMX',
    ABSTRACT         => 'Perl on a Stick',
    MIN_PERL_VERSION => '5.008',
    LICENSE          => 'perl',
    PREREQ_PM => {
        'CPAN::Mini' => '0.575',
    },
    BUILD_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.59',
        'Class::Inspector'    => '1.22',
        'LWP::Online'         => '1.07',
        'Test::Exception'     => '0.27',
        'Test::More'          => '0.42',
        'Test::NoWarnings'    => '0.084',
    },
    META_MERGE => {
      resources => {
        repository => 'https://github.com/StrawberryPerl/Portable',
        bugtracker => 'https://github.com/StrawberryPerl/Portable/issues',
      },
    },
    dist => {
      PREOP => 'perldoc -u lib/Portable.pm | pod2markdown > README.md',
      TAR => 'ptar',
      TARFLAGS => '-c -C -f'
    },
);
