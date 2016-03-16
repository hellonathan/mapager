#!/usr/bin/perl -w

use strict;
use constant PI    => 4 * atan2(1, 1);
use constant DEBUG => 0;

my $pi = PI;
my $re = 6378000;

my $startLat = 0;
my $currLat = $startLat;
my $currRad; 
my $pixelCount;

print "Pi is $pi\n";

#Rounding Subroutine
sub roundup {
    my $n = shift;
    return(($n == int($n)) ? $n : int($n + 1))
}

#Caluclate how many pixels at the current latitude

sub calcPixels {
    my $currRad = cos($currLat) * $re;
    my $prepixelCount = 2 * $pi * $currRad;
    my $latHeight = 360 / $prepixelCount;
    $pixelCount = &roundup($prepixelCount);
    print "Pre Pixel Count for Latitude $currLat is $prepixelCount\n";
    print "Pixel Count for Latitude $currLat is $pixelCount\n";
    print "Latitude Height is $latHeight\n";
}

sub main {

  &calcPixels;

}

&main;
  
 

