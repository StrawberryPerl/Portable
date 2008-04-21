package Portable;

=pod

=head1 NAME

Portable - Perl on a Stick

=head1 SYNOPSIS

  perl -MPortable script.pl

=head1 DESCRIPTION

B<THIS MODULE IS HIGHLY EXPERIMENTAL AND SUBJECT TO CHANGE WITHOUT
NOTICE.>

B<YOU HAVE BEEN WARNED!>

"Portable" is a term used for applications that are installed onto a
portable storage device (most commonly a USB memory stick) rather than
onto a single host.

This technique has become very popular for Windows applications, as it
allows a user to make use of their own software on typical publically
accessible computers at libraries, hotels and internet cafes.

Converting a Windows application into portable form has a specific set
of challenges, as the application has no access to the Windows registry,
no access to "My Documents" type directories, and does not exist at a
reliable filesystem path (because the portable storage medium can be
mounted at an arbitrary volume or filesystem location).

B<Portable> provides a methodology and implementation to support
the creating of  "Portable Perl" distributions. While this will initially
be focused on a Windows implementation, wherever possible the module will
be built to be platform-agnostic.

For now, see the code for more...

=cut

use 5.010;
use strict;
use feature          'state';
use Config           ();
use Carp             ();
use File::Spec       ();
use List::Util       ();
use YAML::Tiny       ();
use Params::Util     qw{ _STRING _HASH _ARRAY };

our $VERSION = '0.03';

# This variable is provided exclusively for the
# use of test scripts.
our $FAKE_PERL = undef;

use constant portable_conf => 'portable.perl';

# Create the enumerations
sub enum (@) { map { $_ => 1 } @_ }
our %conf_file = enum qw{ perlpath };
our %conf_post = enum qw{ ldflags lddlflags };
our %cpan_bin  = enum qw{
	bzip2 curl ftp gpg gzip lynx
	ncftp ncftpget pager patch
	shell tar unzip wget
};
our %cpan_post = enum qw{
	make_arg make_install_arg makepl_arg
	mbuild_arg mbuild_install_arg mbuildpl_arg
};
our %cpan_file = ( %cpan_post, enum qw{ histfile } );




#####################################################################
# Constructors

sub new {
	my $class = shift;
	my $self  = bless { @_ }, $class;

	# Param checking
	unless ( exists $self->{dist_volume} ) {
		Carp::croak('Missing or invalid dist_volume param');
	}
	unless ( _STRING($self->dist_dirs) ) {
		Carp::croak('Missing or invalid dist_dirs param');
	}
	unless ( _STRING($self->dist_root) ) {
		Carp::croak('Missing or invalid dist_root param');
	}
	unless ( _HASH($self->{portable}) ) {
		Carp::croak('Missing or invalid portable param');
	}
	unless ( _HASH($self->{portable}->{ENV}) ) {
		Carp::croak('Missing or invalid ENV key in portable.perl');
	}
	unless ( _ARRAY($self->{portable}->{ENV}->{PATH}) ) {
		Carp::croak('Missing or invalid ENV.PATH key in portable.perl');
	}
	unless ( _ARRAY($self->{portable}->{ENV}->{LIB}) ) {
		Carp::croak('Missing or invalid ENV.LIB key in portable.perl');
	}
	unless ( _ARRAY($self->{portable}->{ENV}->{INCLUDE}) ) {
		Carp::croak('Missing or invalid ENV.INCLUDE key in portable.perl');
	}
	unless ( _HASH($self->{portable}->{config}) ) {
		Carp::croak('Missing or invalid config key in portable.perl');
	}

	# Localize Config.pm entries
	SCOPE: {
		eval { require 'Config_heavy.pl'; };
		my $config  = $self->{config} = {};
		my $pconfig = $self->{portable}->{config};
		foreach my $key ( sort keys %$pconfig ) {
			unless (
				defined $pconfig->{$key}
				and
				length $pconfig->{$key}
				and
				! $conf_post{$key}
			) {
				$config->{$key} = $pconfig->{$key};
				next;
			}
			my @parts = split /\//, $pconfig->{$key};
			if ( $conf_file{$key} ) {
				$config->{$key} = File::Spec->catfile(
					$self->dist_root, @parts,
				);
			} else {
				$config->{$key} = File::Spec->catdir(
					$self->dist_root, @parts,
				);
			}
		}
		foreach my $key ( sort keys %conf_post ) {
			next unless defined $config->{$key};
			$config->{$key} =~ s/\$(\w+)/$config->{$1}/g;
		}
	}

	# Localize CPAN/Config.pm entries
	SCOPE: {
		require CPAN::Config;
		my $cpan  = $self->{cpan} = {};
		my $pcpan = $self->{portable}->{cpan};
		foreach my $key ( sort keys %$pcpan ) {
			unless (
				defined $pcpan->{$key}
				and
				length $pcpan->{$key}
				and not
				$cpan_post{$key}
			) {
				$cpan->{$key} = $pcpan->{$key};
				next;
			}
			my @parts = split /\//, $pcpan->{$key};
			if ( $cpan_file{$key} ) {
				$cpan->{$key} = File::Spec->catfile(
					$self->dist_root, @parts,
				);
			} else {
				$cpan->{$key} = File::Spec->catdir(
					$self->dist_root, @parts,
				);
			}
		}
		foreach my $key ( sort keys %cpan_post ) {
			next unless defined $cpan->{$key};
			$cpan->{$key} =~ s/\$(\w+)/$self->{config}->{$1}/g;
		}
	}

	return $self;
}

sub _default {
	state $cache;
	return $cache if $cache;

	# Get the perl executable location
	my $perlpath = ($ENV{HARNESS_ACTIVE} and $FAKE_PERL) ? $FAKE_PERL : $^X;

	# The path to Perl has a localized path.
	# G:\\strawberry\\perl\\bin\\perl.exe
	# Split it up, and search upwards to try and locate the
	# portable.perl file in the distribution root.
	my ($dist_volume, $d, $f) = File::Spec->splitpath($perlpath);
	my @d = File::Spec->splitdir($d);
	pop @d if $d[-1] eq '';
	my $dist_dirs = List::Util::first {
			-f File::Spec->catpath( $dist_volume, $_, portable_conf )
		}
		map {
			File::Spec->catdir(@d[0 .. $_])
		} reverse ( 0 .. $#d );
	unless ( defined $dist_dirs ) {
		Carp::croak("Failed to find the portable.perl file");
	}

	# Derive the main paths from the plain dirs
	my $dist_root = File::Spec->catpath($dist_volume, $dist_dirs, '' );
	my $conf      = File::Spec->catpath($dist_volume, $dist_dirs, portable_conf );

	# Load the YAML file
	my $portable = YAML::Tiny::LoadFile( $conf );
	unless ( _HASH($portable) ) {
		Carp::croak("Missing or invalid portable.perl file");
	}

	# Hand off to the main constructor,
	# cache the result and return it
	$cache = __PACKAGE__->new(
		dist_volume => $dist_volume,
		dist_dirs   => $dist_dirs,
		dist_root   => $dist_root,
		conf        => $conf,
		perlpath    => $perlpath,
		portable    => $portable,
	);
}





#####################################################################
# Main Interface

sub apply {
	my $default = _default();

	# Apply the Perl configuration changes
	my $config = $default->{config};
	foreach my $k ( %$config ) {
		$Config::Config{$k} = $config->{$k};
	}

	# Apply the CPAN configuration changes
	my $cpan = $default->{cpan};
	foreach my $k ( %$cpan ) {
		$CPAN::Config->{$k} = $cpan->{$k};
	}

	return 1;
}

sub import {
	state $applied;
	unless ( $applied ) {
		$_[0]->apply;
		$applied = 1;
	}
	return $applied;
}







#####################################################################
# Configuration Accessors

sub dist_volume {
	$_[0]->{dist_volume};
}

sub dist_dirs {
	$_[0]->{dist_dirs};
}

sub dist_root {
	$_[0]->{dist_root};
}

sub conf {
	$_[0]->{conf};
}

sub perlpath {
	$_[0]->{perlpath};
}

sub portable_cpan {
	$_[0]->{portable}->{cpan};
}

sub portable_config {
	$_[0]->{portable}->{config};
}

sub portable_env {
	$_[0]->{portable}->{ENV};
}

sub portable_env_path {
	@{ $_[0]->{portable}->{ENV}->{PATH} };
}

sub portable_env_lib {
	@{ $_[0]->{portable}->{ENV}->{LIB} };
}

sub portable_env_include {
	@{ $_[0]->{portable}->{ENV}->{INCLUDE} };
}
1;

=pod

=head1 SUPPORT

Bugs should be reported via the CPAN bug tracker.

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Perl-Portable>

For other issues, or commercial support, contact the author.

=head1 AUTHOR

Adam Kennedy E<lt>adamk@cpan.orgE<gt>

=head1 SEE ALSO

L<http://win32.perl.org/>

=head1 COPYRIGHT

Copyright 2008 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
