#!perl

use 5.010;
use strict;
use warnings;

use Test::More 0.98;

use SHARYANTO::Data::Util qw(
                                clone_circular_refs
                        );

subtest clone_circular_refs => sub {
    ok(clone_circular_refs(undef), "undef");
    ok(clone_circular_refs("x"), "x");
    ok(clone_circular_refs([]), "[]");
    ok(clone_circular_refs([[], []]), "[[], []]");

    my $b = [];
    my $a = [$b, $b, $b];
    ok(clone_circular_refs($a), "circ 1 status");
    is_deeply($a, [[], [], []], "circ 1 result");

    $a = [1]; push @$a, $a;
    ok(!clone_circular_refs($a), "circ 2 status");
};

DONE_TESTING:
done_testing;
