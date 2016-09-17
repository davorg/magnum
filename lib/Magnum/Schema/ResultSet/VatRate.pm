package Magnum::Schema::ResultSet::VatRate;

use strict;
use warnings;
use Moose;
use MooseX::NonMoose;
extends 'DBIx::Class::ResultSet';

sub BUILDARGS { $_[2] }

has datetime_formatter => (
  is => 'ro',
  lazy_build => 1,
);

sub _build_datetime_formatter {
  return $_[0]->result_source->schema->storage->datetime_parser;
}

sub vat_rate_for_date {
  my $self = shift;
  my ($date, $type) = @_;

  $type //= 'standard';

  my $search_date = $self->datetime_formatter->format_datetime($date);

  my ($rate) = $self->search({
    type => $type,
    start_date => [ { '<=' => $search_date },
                    undef ],
    end_date   => [ { '>=' => $search_date },
                    undef ],
  });

  return $rate;
}

1;
