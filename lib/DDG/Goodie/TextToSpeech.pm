package DDG::Goodie::TextToSpeech;

use DDG::Goodie;

zci answer_type => "text_to_speech";
zci is_cached   => 1;

my @triggers = ("text to audio", "text to speech", "text to speach", "text to voice");
triggers start => @triggers;

handle query_lc => sub {

    my $remove_triggers = "(";
    $remove_triggers .= join "|", @triggers;
    $remove_triggers .= ")";

    my $say = $_;
    $say =~ s/$remove_triggers//;
    $say =~ s/^\s+//;

    return '',
    structured_answer => {
        data => {
            say => $say,
        },
        templates => {
            group => 'text',
            item => 0,
            options => {
                content => 'DDH.text_to_speech.content'
            }
        }
    }
};

1;
