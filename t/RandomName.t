#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;

zci is_cached => 0;
zci answer_type => "randomname";

sub build_name_answer {
    my @test_params = @_;

    return re(qr/\w\w/),
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

sub build_person_answer {
    my @test_params = @_;

    return re(qr/Name: [\w\s]+\nGender: (?:Male|Female)\nDate of birth: \d{4}\-\d{2}\-\d{2}\nAge: \d+/),
        structured_answer => {
            data => {
                name => re(qr/\w\w/),
                gender => re(qr/\w/),
                date_of_birth => re(qr/\d{4}\-\d{2}\-\d{2}/),
                age => re(qr/\d/)
            },

            templates => {
                group => "text",
                options  => {
                    content  => "DDH.random_name.content"
                }
            }
        };
}

sub build_name_test { test_zci(build_name_answer(@_)) }
sub build_person_test { test_zci(build_person_answer(@_)) }

ddg_goodie_test(
    [
        'DDG::Goodie::RandomName'
    ],
    'random name' => build_name_test(),
    'random Name' => build_name_test(),
    'random person' => build_person_test(),
    'random Person' => build_person_test(),
    'random domain name' => undef,
    'random city name' => undef,
    'names of random people' => undef
);

done_testing;
