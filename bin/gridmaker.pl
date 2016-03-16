#!/usr/bin/perl -w

# This script produces a list of points to draw a grid of approximated squares
# on the surface of the Earth.

use strict;
use constant PI    => 4 * atan2(1, 1);
use constant DEBUG => 0;

my $pi = PI;
my $re = 6378000;
my $resolution = 100000; 

my $startLat = 0;
my $maxLat = 80;
my $currLat = $startLat;
my $currRad; 
my $pixelCount;
my $meterRad;
my $meterDegs;
my @coords;
my $countUpPixRow;
my $countUpPixCol;
my $countUpLat;
my $roundPixWidth;

print "Pi is $pi\n";

#Rounding subroutine to fuck shit up
sub roundup {
    my $n = shift;
    return(($n == int($n)) ? $n : int($n + 1))
}

#Caluclate the degrees per meter from N to S

sub calcLong {
  $meterRad = 2 * $pi * $re / $resolution;
  $meterDegs = 360 / $meterRad;
  my $maxSlices = $maxLat / $meterDegs;
  return ($meterDegs, $maxSlices);
}

#Caluclate how many pixels at the current latitude

sub calcPixels {
  $currRad = cos($currLat) * $re;
  my $prepixelCount = 2 * $pi * $currRad / $resolution;
  my $latHeight = 360 / $prepixelCount;
  $pixelCount = &roundup($prepixelCount);
  $roundPixWidth = 360 / $pixelCount;
  print "Pre Pixel Count for Latitude $currLat is $prepixelCount\n";
  print "Pixel Count for Latitude $currLat is $pixelCount\n";
  print "Latitude Height is $latHeight\n";
  print "Rounded Longitude Width is $roundPixWidth\n";
  return ($pixelCount, $roundPixWidth); 
}

sub main {

  &calcLong;
  my $rowCount = 0;
  my $colCount = 0;
  my $currLong = $meterDegs;

  while ($currLat < $maxLat) {
    &calcPixels($currLat);
    print "Pixel Count is NOW $pixelCount and Rounded Pixel Width is  $roundPixWidth\n";
    my @rowdata;
    my $lastLong = 0;
    while ($colCount < $pixelCount) {
      $colCount++;
      $currLong = $currLong + $lastLong;
      print "Current Row is $rowCount - Current Col is $colCount - Current Longitude is $currLong - Current Latitude is $currLat\n";
      push (@rowdata, "$rowCount,$colCount,$currLong,$currLat"); 
      $currLong = $currLong + $roundPixWidth;
    }
    $rowCount++;
    $currLat = $currLat + $meterDegs;
  }
}

&main;
  
 

