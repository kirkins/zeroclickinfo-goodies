use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;

zci answer_type => 'sum';
zci is_cached => 1;

sub commify {
    # Disable bigint in this function. It interferes with `1 while ...`.
    no bigint;
    local $_  = shift;
    1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
    return $_;
}

sub build_sum_answer {
    my ($from_number, $to_number, $answer) = map { commify($_) } @_;

    return "Sum of natural numbers from " . $from_number . " to " . $to_number . " is " . $answer . ".",
        structured_answer => {
            data => {
                title => "$answer\n",
                subtitle => "Sum of natural numbers from " . $from_number . " to " . $to_number . " is " . $answer . "."
            },
            templates => {
                group => "text",
            }
        };
}

sub build_sum_test { test_zci(build_sum_answer(@_)) }

ddg_goodie_test(
    [
        'DDG::Goodie::SumOfNaturalNumbers'
    ],
    'sum 1 to 10' => build_sum_test(1, 10, 55),
    'sum 55 to 63' => build_sum_test(55, 63, 531),
    'sum 33 to 100' => build_sum_test(33, 100, 4522),
    'sum 1-10' => build_sum_test(1, 10, 55),
    'sum from 1 to 10' => build_sum_test(1, 10, 55),
    '1-10 sum' => build_sum_test(1, 10, 55),
    'add from 1 to 100' => build_sum_test(1, 100, 5050),

    # Invalid Input
    'sum 1 --- 10' => undef,
    'sum 100 - 10' => undef,
    'add ten to twenty' => undef,
);

done_testing;
