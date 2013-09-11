package SHARYANTO::Data::OldUtil;

use 5.010;
use strict;
use warnings;
#use experimental 'smartmatch';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(has_circular_ref);

# VERSION

our %SPEC;

$SPEC{has_circular_ref} = {
    v => 1.1,
    summary => 'Check whether data item contains circular references',
    description => <<'_',

Does not deal with weak references.

_
    args_as => 'array',
    args => {
        data => {
            schema => "any",
            pos => 0,
            req => 1,
        },
    },
    result_naked => 1,
};
sub has_circular_ref {
    my ($data) = @_;
    my %refs;
    my $check;
    $check = sub {
        my $x = shift;
        my $r = ref($x);
        return 0 if !$r;
        return 1 if $refs{"$x"}++;
        if ($r eq 'ARRAY') {
            for (@$x) {
                next unless ref($_);
                return 1 if $check->($_);
            }
        } elsif ($r eq 'HASH') {
            for (values %$x) {
                next unless ref($_);
                return 1 if $check->($_);
            }
        }
        0;
    };
    $check->($data);
}

1;
# ABSTRACT: Data utilities

=head1 SYNOPSIS


=head1 DESCRIPTION


=head1 FUNCTIONS

None are exported by default, but they are exportable.


=head1 SEE ALSO

L<Data::Structure::Util> has the XS/C version of C<has_circular_ref> which is 3
times or more faster than this module's implementation which is pure Perl). Use
that instead.

This module is however much faster than L<Devel::Cycle>.

=cut
