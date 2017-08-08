package DDG::Goodie::SpeedTest;

use DDG::Goodie;

zci answer_type => "speed_test";
zci is_cached   => 1;

triggers start => "internet speed test";

my $goodie_version = $DDG::GoodieBundle::OpenSourceDuckDuckGo::VERSION // 999;
my $image;

if($goodie_version == 999) {
    $image = "https://upload.wikimedia.org/wikipedia/commons/2/2c/A_new_map_of_Great_Britain_according_to_the_newest_and_most_exact_observations_%288342715024%29.jpg";
} else {
    $image = "share/spice/speed_test/" . $goodie_version . "/img/big_free_img.jpg";
}

$image = $image . "?" . time();

handle remainder => sub {
    return '',
    structured_answer => {
        data => {
            test => $image
        },
        templates => {
            group => 'text',
            item => 0,
            options => {
                content => 'DDH.speed_test.content'
            }
        }
    }
};

1;
