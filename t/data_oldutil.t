#!perl

use 5.010;
use strict;
use warnings;

use Test::More 0.98;

use SHARYANTO::Data::OldUtil qw(
                                has_circular_ref
                        );

subtest has_circular_ref => sub {
    ok(!has_circular_ref(undef), "undef");
    ok(!has_circular_ref("x"), "x");
    ok(!has_circular_ref([]), "[]");
    ok(!has_circular_ref([[], []]), "[[], []]");

    my $a;
    $a = []; push @$a, $a;
    ok( has_circular_ref($a), "circ array 1");
    my $b = [1];
    $a = [$b, $b];
    ok( has_circular_ref($a), "circ array 2");

    $a = {k1=>$b, k2=>$b};
    ok( has_circular_ref($a), "circ hash 1");
};

DONE_TESTING:
done_testing;
