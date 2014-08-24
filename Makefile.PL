use strict;
use warnings;

use inc::Module::Install;

name			'Attean';
all_from		'lib/Attean.pm';
author			'Gregory Todd Williams <gwilliams@cpan.org>';
license			'perl';

build_requires	'Test::More'				=> 0.88;
build_requires	'Test::Exception'			=> 0;
build_requires	'Test::Moose'				=> 0;

perl_version	'5.014';

requires		'Digest::SHA'		=> 0;
requires		'Encode'			=> 0;
requires		'List::Util'		=> 0;
requires		'Moose'				=> 0;
requires		'MooseX::ArrayRef'	=> 0;
requires		'Scalar::Util'		=> 0;
requires		'Set::Scalar'		=> 0;

resources(
	'homepage'   => "http://search.cpan.org/dist/Attean/",
	'repository' => "http://github.com/kasei/attean/",
	'bugtracker' => "https://github.com/kasei/attean/issues"
);

author_tests('xt');

sign;

WriteAll;