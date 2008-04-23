package Portable::CPAN;

use 5.008;
use strict;
use Carp ();

our $VERSION   = '0.04';

# Create the enumerations
our %bin  = map { $_ => 1 } qw{
	bzip2 curl ftp gpg gzip lynx
	ncftp ncftpget pager patch
	shell tar unzip wget
};
our %post = map { $_ => 1 } qw{
	make_arg make_install_arg makepl_arg
	mbuild_arg mbuild_install_arg mbuildpl_arg
};
our %file = ( %bin, histfile => 1 );





#####################################################################
# Constructor

sub new {
	my $class  = shift;
	my $parent = shift;
	unless ( Portable::_HASH($parent->portable_cpan) ) {
		Carp::croak('Missing or invalid cpan key in portable.perl');
	}

	# Create the object
	my $self = bless { }, $class;

	# Map the 
	my $cpan = $parent->portable_cpan;
	my $root = $parent->dist_root;
	foreach my $key ( sort keys %$cpan ) {
		unless (
			defined $cpan->{$key}
			and
			length $cpan->{$key}
			and not
			$post{$key}
		) {
			$self->{$key} = $cpan->{$key};
			next;
		}
		my $method = $file{$key} ? 'catfile' : 'catdir';
		$self->{$key} = File::Spec->$method(
			$root, split /\//, $cpan->{$key}
		);
	}
	my $config = $parent->portable_config;
	foreach my $key ( sort keys %post ) {
		next unless defined $self->{$key};
		$self->{$key} =~ s/\$(\w+)/$config->{$1}/g;
	}

	return $self;
}

1;
