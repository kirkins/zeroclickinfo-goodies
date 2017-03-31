package DDG::Goodie::RandomName;
# ABSTRACT: Return random first and last name

use strict;
use DDG::Goodie;

use Data::RandomPerson;

triggers start  => 'random name','random person';
zci answer_type => "randomname";
zci is_cached   => 0;

handle query => sub {
    my $person = Data::RandomPerson->new()->create();
    my $name = "$person->{firstname} $person->{lastname}";
    my %genders = (m => 'Male', f => 'Female');
    my $string_answer = "Name: $name\nGender: $genders{$person->{gender}}\nDate of birth: $person->{dob}\nAge: $person->{age}";

    return $string_answer,
    	structured_answer => {
    	data => {
    		name => $name,
		gender => $genders{$person->{gender}},
		date_of_birth => $person->{dob},
		age => $person->{age}
    	},
    	templates => {
    		group => 'text',
    		options => {
    			content => 'DDH.random_name.content'
    		}
    	}
    };

};


1;
