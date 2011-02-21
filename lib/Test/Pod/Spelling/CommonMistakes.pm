#
# This file is part of Test-Pod-Spelling-CommonMistakes
#
# This software is copyright (c) 2011 by Apocalypse.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use strict; use warnings;
package Test::Pod::Spelling::CommonMistakes;
BEGIN {
  $Test::Pod::Spelling::CommonMistakes::VERSION = '1.000';
}
BEGIN {
  $Test::Pod::Spelling::CommonMistakes::AUTHORITY = 'cpan:APOCAL';
}

# ABSTRACT: Checks POD for common spelling mistakes

# Import the modules we need
use Pod::Spell::CommonMistakes 0.01 qw( check_pod_all );
use Test::Pod 1.40 ();

# setup our tests and etc
use Test::Builder 0.94;
my $Test = Test::Builder->new;

# auto-export our 2 subs
use base qw( Exporter );
our @EXPORT = qw( pod_file_ok all_pod_files_ok ); ## no critic ( ProhibitAutomaticExportation )


sub all_pod_files_ok {
	my @files = @_ ? @_ : Test::Pod::all_pod_files();

	$Test->plan( tests => scalar @files );

	my $ok = 1;
	foreach my $file ( @files ) {
		pod_file_ok( $file ) or undef $ok;
	}

	return $ok;
}


sub pod_file_ok {
	my $file = shift;
	my $name = @_ ? shift : "Spelling test for $file";

	if ( ! -f $file ) {
		$Test->ok( 0, $name );
		$Test->diag( "Error: '$file' does not exist" );
		return;
	}

	# Parse the POD!
	my $res;
	eval {
		$res = check_pod_all( $file );
	};
	if ( $@ ) {
		$Test->ok( 0, $name );
		$Test->diag( "Error: Unable to parse '$file' - $@" );
		return;
	}

	# Did we get any errors?
	if ( keys %$res == 0 ) {
		$Test->ok( 1, $name );
		return 1;
	} else {
		$Test->ok( 0, $name );
		foreach my $e ( keys %$res ) {
			## no critic ( ProhibitAccessOfPrivateData )
			$Test->diag( "'$e' should be spelled " . $res->{ $e } );
		}
		return;
	}
}

1;


__END__
=pod

=for stopwords TESTNAME spellchecker

=head1 NAME

Test::Pod::Spelling::CommonMistakes - Checks POD for common spelling mistakes

=head1 VERSION

  This document describes v1.000 of Test::Pod::Spelling::CommonMistakes - released February 21, 2011 as part of Test-Pod-Spelling-CommonMistakes.

=head1 SYNOPSIS

	#!/usr/bin/perl
	use strict; use warnings;

	use Test::More;

	eval "use Test::Pod::Spelling::CommonMistakes";
	if ( $@ ) {
		plan skip_all => 'Test::Pod::Spelling::CommonMistakes required for testing POD';
	} else {
		all_pod_files_ok();
	}

=head1 DESCRIPTION

This module checks your POD for common spelling errors. This differs from L<Test::Spelling> because it doesn't use your system spellchecker
and instead uses L<Pod::Spell::CommonMistakes> for the heavy lifting. Using it is the same as any standard Test::* module, as seen here.

=head1 METHODS

=head2 all_pod_files_ok( [ @files ] )

This function is what you will usually run. It automatically finds any POD in your distribution and runs checks on them.

Accepts an optional argument: an array of files to check. By default it checks all POD files it can find in the distribution. Every file it finds
is passed to the C<pod_file_ok()> function.

=head2 pod_file_ok( $file, [ $name ] )

C<pod_file_ok()> will okay the test if there is spelling errors present in the POD. Furthermore, if the POD was
malformed as reported by L<Pod::Simple>, the test will fail and not attempt to check spelling.

When it fails, C<pod_file_ok()> will show any misspelled words and their suggested spelling as diagnostics.

The optional second argument $name is the name of the test.  If it is omitted, C<pod_file_ok()> chooses a default
test name "Spelling test for $file".

=head1 EXPORT

Automatically exports the two subs.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Pod::Spell::CommonMistakes>

=back

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Test::Pod::Spelling::CommonMistakes

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

L<http://search.cpan.org/dist/Test-Pod-Spelling-CommonMistakes>

=item *

RT: CPAN's Bug Tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Pod-Spelling-CommonMistakes>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Pod-Spelling-CommonMistakes>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Pod-Spelling-CommonMistakes>

=item *

CPAN Forum

L<http://cpanforum.com/dist/Test-Pod-Spelling-CommonMistakes>

=item *

CPANTS Kwalitee

L<http://cpants.perl.org/dist/overview/Test-Pod-Spelling-CommonMistakes>

=item *

CPAN Testers Results

L<http://cpantesters.org/distro/T/Test-Pod-Spelling-CommonMistakes.html>

=item *

CPAN Testers Matrix

L<http://matrix.cpantesters.org/?dist=Test-Pod-Spelling-CommonMistakes>

=back

=head2 Email

You can email the author of this module at C<APOCAL at cpan.org> asking for help with any problems you have.

=head2 Internet Relay Chat

You can get live help by using IRC ( Internet Relay Chat ). If you don't know what IRC is,
please read this excellent guide: L<http://en.wikipedia.org/wiki/Internet_Relay_Chat>. Please
be courteous and patient when talking to us, as we might be busy or sleeping! You can join
those networks/channels and get help:

=over 4

=item *

irc.perl.org

You can connect to the server at 'irc.perl.org' and join this channel: #perl-help then talk to this person for help: Apocalypse.

=item *

irc.freenode.net

You can connect to the server at 'irc.freenode.net' and join this channel: #perl then talk to this person for help: Apocal.

=item *

irc.efnet.org

You can connect to the server at 'irc.efnet.org' and join this channel: #perl then talk to this person for help: Ap0cal.

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-test-pod-spelling-commonmistakes at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Pod-Spelling-CommonMistakes>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<http://github.com/apocalypse/perl-test-pod-spelling-commonmistakes>

  git clone git://github.com/apocalypse/perl-test-pod-spelling-commonmistakes.git

=head1 AUTHOR

Apocalypse <APOCAL@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Apocalypse.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

The full text of the license can be found in the LICENSE file included with this distribution.

=cut

