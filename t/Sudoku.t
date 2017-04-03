#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Deep;
use DDG::Test::Goodie;

zci answer_type => 'sudoku';
zci is_cached => 0;

sub build_answer {
    my @test_params = @_;

    return re(qr/^[0-9_].*[0-9_]$/s),
        structured_answer => {
            data => {
                sudoku_values => [re(qr/^[0-9_]{81}/)]
            },

            templates => {
                group => "text",
                options  => {
                    content  => "DDH.sudoku.content"
                }
            }
        };
}

sub build_test { test_zci(build_answer(@_)) }

ddg_goodie_test(
	[
		'DDG::Goodie::Sudoku'
	],
	"sudoku" => build_test(),
	# "play sudoku" => build_test(),
	# "easy sudoku" => build_test(),
	# "sudoku hard" => build_test(),
	# "generate sudoku" => build_test(),
	# "sudoku party" => undef,
	# "sudoku toys" => undef,
	# 'sudoku easy' => build_test()
);

done_testing;
