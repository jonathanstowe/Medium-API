#!/usr/bin/env perl6

use v6.c;

use Test;

use Medium::API;

my $obj;

# This is not a good one BTW, just the right length
my $integration-token = '181d415f34379af07b2c11d144dfbe35d';

lives-ok { $obj = Medium::API.new(:$integration-token) }, "new Medium::API";

isa-ok $obj, Medium::API, "and (of course it's the right thing.)";




done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
