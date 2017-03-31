#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;

zci is_cached => 0;
zci answer_type => "randomname";

sub build_structured_answer {
    my @test_params = @_;

    return "",
        structured_answer => {
            data => {
                name => re(qr/\w\w/)
            },

            templates => {
                group => "text",
                options  => {
                    content  => "DDH.random_name.content"
                }
            }
        };
}

sub build_test { test_zci(build_structured_answer(@_)) }

ddg_goodie_test(
    [
        'DDG::Goodie::RandomName'
    ],
    'random name' => build_test()
);

done_testing;
