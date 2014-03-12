package DDG::Goodie::Peppers;
# ABSTRACT: Show the Scoville level for a given pepper

use DDG::Goodie;

triggers startend => 'scoville', 'hotness';
primary_example_queries 'scoville habanero';
description 'Show the Scoville number for a pepper';
category 'random';
topics 'special_interest';
name 'Peppers';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Peppers.pm';
attribution
    web => ['www.transistor.io', 'Jason Dorweiler'],
    github => [ 'jdorweiler', 'Jason_Dorweiler'];

zci answer_type => 'Peppers';

my %peppers = (
 #from http://en.wikipedia.org/wiki/scoville_scale
	"trinidad moruga" => ['Trinidad Moruga Scorpion', '1,500,000 - 2,000,000', 'https://en.wikipedia.org/wiki/Trinidad_Moruga_Scorpion'],
	"carolina reaper" => ['Carolina Reaper', '1,569,300', 'https://en.wikipedia.org/wiki/Carolina_Reaper'],
	"naga viper"      => ['Naga Viper pepper', '1,382,118', 'https://en.wikipedia.org/wiki/Naga_Viper_pepper'],
	"infinity chilli" => ['Infinity Chilli', '1,067,286', 'https://en.wikipedia.org/wiki/Infinity_Chilli'],
	"Bhut Jolokia" => ['Infinity Chilli', '1,067,286', 'https://en.wikipedia.org/wiki/Infinity_Chilli'],

);

sub more_at {
    return "<br><a href='$_[0]'>More at Wikipedia</a>";
}

sub build_html {
	# builds a string to display using the given $command
	# and $usage
	return "<i>Scoville heat units:<pre style='display: inline; padding: 1px;'>$_[0] $_[1] SHU</pre></i>" . more_at($_[2]);
}

handle remainder => sub {
	my $key = lc $_; #set key to lower case
	$key =~ s/'pepper'//; #This doesn't work.  We need to remove 'pepper' if it was included to find the key
	print $key;
	my $name = $peppers{$key}[0]; #get heat units from table

	if($name) { #check to see if the key was in the table
        my $heading = $peppers{$key}[0];
        my $hotness = $peppers{$key}[1];
		my $more = $peppers{$key}[2];
		my $text = "Pepper: $name";

        #build the html string to display
        my $html = build_html($name, $hotness, $more);

        return $text, html => $html, heading => "$heading (Pepper)";
	}
	return; #return if no key was found
};

1;
